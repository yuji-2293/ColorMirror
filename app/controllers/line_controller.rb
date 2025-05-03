class LineController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :callback ]
  protect_from_forgery except: :callback
  require "line/bot"


    def callback
      body = request.body.read.force_encoding("UTF-8")
      Rails.logger.info "[LINE] 受け取ったリクエストボディ: #{body}"

      signature = request.env["HTTP_X_LINE_SIGNATURE"]
      unless LINE_MESSAGING_CLIENT.validate_signature(body, signature)
        head :bad_request and return
      end

      events = LINE_MESSAGING_CLIENT.parse_events_from(body)

      events.each do |event|
        case event
        when Line::Bot::Event::Follow
          handle_follow(event)
        when Line::Bot::Event::Unfollow
          handle_unfollow(event)
        when Line::Bot::Event::Message
          handle_message(event)
        end
      end
      head :ok
    end

    private

    def handle_follow(event)
      line_id = event["source"]["userId"]
      user = User.find_by(line_id: line_id)
      if user
        user&.need_alert!
      else
        Rails.logger.info "未連携のユーザー（#{line_id}）が友だち追加しました"
      end
      reply = "友だち登録ありがとうございます！ご自身のLINEアカウントとColorMirrorアカウントを連携すると、リマインダー機能を使用することができます！アカウント連携するためには、マイページのアカウント連携トークンをコピーして送信してください！"
      LINE_MESSAGING_CLIENT.reply_message(event["replyToken"], {
        type: "text",
        text: reply
      })
    end

    def handle_unfollow(event)
      line_id = event["source"]["userId"]
      user = User.find_by(line_id: line_id)
      if user
        user.no_alert!
        user.update(line_id: nil)
      end
    end

    def handle_message(event)
      # LINEのtextイベントで送信されたトークンコードを取得、Userよりline_tokenを持つユーザーを検索
      message_text = event.message["text"]
      user_by_token = User.find_by(line_token: message_text)
      # line_tokenを持つユーザーが存在し、userIdを持たない場合の取得後、連携完了通知
      if user_by_token && user_by_token.line_id.blank?
        line_id = event["source"]["userId"]
        user_by_token.update!(line_id: line_id)
        reply = "LINE連携を完了しました。ColorMirrorのリマインダ通知を受け取れるようになりました.通知は毎朝９時にお届けします"
      # 連携完了済みの場合、userIdを取得、LINE上で送信されたメッセージに従い処理を分岐
      elsif user_by_line = User.find_by(line_id: event["source"]["userId"])
          case message_text
          when /リマインダ(設定|登録)/
            user_by_line&.need_alert!
            reply = "リマインダを設定しました。毎朝９時にお知らせします。"
          when /リマインダ解除/
            user_by_line&.no_alert!
            reply = "リマインダを解除しました。再開するには「リマインダ設定 or 登録」と送信してください"
          else
            reply =  "ColorMirrorのリマインダ設定ができます。「リマインダ設定 or 登録」または「リマインダ解除」と送信してください。"
          end
      else
        reply = "無効なトークンです。マイページからLINE連携トークンをコピーして送ってください。"
      end

      response = LINE_MESSAGING_CLIENT.reply_message(event["replyToken"], {
        type: "text",
        text: reply
      })
      Rails.logger.info "[LINE返信] status=#{response.code}, body=#{response.body}"
    end
end

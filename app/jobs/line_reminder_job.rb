class LineReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users = User.where(line_alert: :need_alert).where.not(line_id: nil)

    users.each do |user|
      LINE_MESSAGING_CLIENT.push_message(user.line_id, {
        type: "text",
        text: "おはようございます！！ \nColorMirrorで今日の気分を記録しよう！\nhttps://colormirror.onrender.com/"
      })
    end
  end
end

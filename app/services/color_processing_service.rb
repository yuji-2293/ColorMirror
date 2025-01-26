class ColorProcessingService
  def initialize(color, current_user)
    # ColorProcessingServiceがインスタンス化されると、自動的に@color,@userにモデル情報が格納
    @color = color
    @user = current_user
  end

  def process_color(mapped_color)
    # プロンプトの生成mapped_colorを引数にとり、AIに渡す
    prompt = "色「#{ mapped_color }」についてコメントを生成してください。"
    # 別のserviceクラスからColorResponseServiceをインスタンス化、レスポンスの生成
    ai_response = ::ColorResponseService.new.fetch_response(prompt)
    # レスポンスの成形
    color_response = ai_response["choices"][0]["message"]["content"]
    # colorの関連テーブルとai_commentカラムへの保存
    self_log = @color.self_logs.create(user: @user)
    @response = self_log.responses.create(ai_comment: color_response)
  end
end

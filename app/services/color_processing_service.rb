class ColorProcessingService
  def initialize(color, current_user)
    # ColorProcessingServiceがインスタンス化されると、自動的に@color,@userにモデル情報が格納
    @color = color
    @user = current_user
  end

  def process_color(mapped_color, weather_data)
    # プロンプトの生成mapped_colorを引数にとり、AIに渡す
    prompt = "
              気分を表す色 =#{ mapped_color },
              外部環境 = #{ weather_data[:weather_name] },#{ weather_data[:weather_pressure] }hpa,#{ weather_data[:temperature] }℃
              気分を表す色, 外部環境をもとにコメントを生成してください
              その際、冒頭で外部環境について復唱してください"
    # 別のserviceクラスからColorResponseServiceをインスタンス化、レスポンスの生成
    ai_response = ::ColorResponseService.new.fetch_response(prompt)
    # レスポンスの成形
    ai_response["choices"][0]["message"]["content"]
  end
end

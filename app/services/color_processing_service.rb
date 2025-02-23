class ColorProcessingService
  def initialize(color, current_user)
    # ColorProcessingServiceがインスタンス化されると、自動的に@color,@userにモデル情報が格納
    @color = color
    @user = current_user
  end

  def process_color(prompt_color, weather_data, prompt_mood)
      pressure_warning = case weather_data[:weather_pressure].to_i
      when 1000..1010 then "低気圧が近づいているので、体調管理に注意してください。"
      when 1011..1015 then "気圧は安定しています。過ごしやすい一日になりそうです。"
      when 1016..1030 then "高気圧の影響で、空気が澄んでいます！"
      else "気圧が不安定です。無理せずリラックスしてください。"
      end

      # PROMPT
      # 1. 気分を表す色での心情の言語化
      prompt_1 = <<~PROMPT
        あなたは色彩心理の専門家です。
        以下の条件でユーザーの気分と色で心象を言語化してください。

        気分: #{ prompt_mood } = 直感で選んだユーザーの気分
        色: #{ prompt_color } = 気分をもとに今の気分に合う選択した色

        できるだけポジティブな言葉を使ってください。
        150字程度で要点を押さえて表現してください。
        マークダウン方式を使わないでください。
        PROMPT

      # 2. 外部環境を踏まえた根拠や注意喚起
      prompt_2 = <<~PROMPT
        外部環境データ：
        - 天候: #{weather_data[:weather_name]}
        - 気圧: #{weather_data[:weather_pressure]}hPa
        - 気温: #{weather_data[:temperature]}℃
        - 追加情報: #{pressure_warning}

        気圧: #{weather_data[:weather_pressure]}hPaは直接コメントの中に含めないでください。

        #{ prompt_1 }をもとに外部環境データを使って根拠づけてください。

        また、追加情報: #{pressure_warning}について注意すべき点についてコメントしてください。
        できるだけポジティブな言葉を使ってください。
        150字程度で要点を押さえて表現してください
        マークダウン方式を使わないでください。
      PROMPT
    # 別のserviceクラスからColorResponseServiceをインスタンス化、レスポンスの生成
    ai_response1 = ::ColorResponseService.new.fetch_response(prompt_1)
    ai_response2 = ::ColorResponseService.new.fetch_response(prompt_2)
    # レスポンスの成形（2つの結果を1つのデータとして返す）
    ai_responses = {
      color_analysis: ai_response1["choices"][0]["message"]["content"],
      weather_analysis: ai_response2["choices"][0]["message"]["content"]
    }
  end
end

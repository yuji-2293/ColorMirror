class ColorResponseService
  def initialize
    @client = OpenAI::Client.new
    @default_model = Rails.application.config.openai[:default_model]
  end

  def fetch_response(prompt)
  @client.chat(
      parameters: {
        model: @default_model,
        messages: [
          { role: "system", content: "あなたは色彩心理の専門家です。
          「色について:」という題名でユーザーからのpromptの「色」に従い、人に気分と紐付けたコメントを出してください。
          「天気について:」という題名で、外部根拠として情報をもとに「色について」考察してください。

          条件: ポジティブ、「色」、「天気」に合わせたポジティブなワードを使ってください"
        },
          { role: "user", content: prompt }
        ],
        max_tokens: 300,
        temperature: 0.7
      }
    )
  end
end

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
          { role: "system", content: "あなたは色彩心理の専門家です。promptに連想される言葉を3つ出してください。その後に、
          ユーザーからのpromptの「色」に従い、天気と紐付けた気分を表してください。
          条件: 段落をつけて3行にしてください、ポジティブ、「色」に合わせた具体的な生活行動を答えてください。" },
          { role: "user", content: prompt }
        ],
        max_tokens: 300,
        temperature: 0.7
      }
    )
  end
end

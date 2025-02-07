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
          { role: "system", content: "あなたは色彩心理の専門家です。#{prompt}" },
          { role: "user", content: prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )
  end
end

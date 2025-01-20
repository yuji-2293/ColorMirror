class ChatbotService
  def initialize
    @client = OpenAI::Client.new
    @default_model = Rails.application.config.openai[:default_model]
  end

  def fetch_response(prompt)
  @client.chat(
      parameters: {
        model: @default_model,
        messages: [
          { role: "system", content: "ユーザーから「色」「天気」について質問されます。この条件をもとに、天気に気分が左右される体質の人に向けてコメントしてください。条件: ３行、ポジティブ、「色」に合わせた具体的な生活行動" },
          { role: "user", content: prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )
  end
end

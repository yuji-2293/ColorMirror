class ChatbotsController < ApplicationController
  protect_from_forgery

  def ask #ユーザーがアクセスして質問を入力するページを表示
  end

  def answer #ユーザーが質問を入力して送信すると、質問をOpenAIに送信して回答を取得
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    prompt = params[:question] #ユーザーが入力した質問を取得

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "ユーザーから「色」「天気」について質問されます。この条件をもとに、天気に気分が左右される体質の人に向けてコメントしてください。条件: ３行、ポジティブ、「色」に合わせた具体的な生活行動" },
          { role: "user", content: prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )

    if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
      @answer = response["choices"][0]["message"]["content"]
    else
      @answer = "回答が見つかりませんでした"
    end
    respond_to do |format|
      format.turbo_stream
    end
  end
end

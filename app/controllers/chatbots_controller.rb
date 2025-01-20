class ChatbotsController < ApplicationController
  protect_from_forgery

  def ask #ユーザーがアクセスして質問を入力するページを表示
  end

  def answer #ユーザーが質問を入力して送信すると、質問をOpenAIに送信して回答を取得
    prompt = params[:question] #ユーザーが入力した質問を取得
    response = ::ChatbotService.new.fetch_response(prompt)
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

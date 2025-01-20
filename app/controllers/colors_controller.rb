class ColorsController < ApplicationController
  helper PromptMapping
  def top;end

  def index
    @colors = Color.last(1)
    @response = Response.last(1)

  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(color_params)
    if @color.save
      #formから渡ってきたcolor_nameをhelperメソッドで色名に変換
      color_id = color_params[:color_name]
      mapped_color = view_context.mapping_color(color_id)

      #openai に色名を渡してプロンプトを作成する
      prompt = "色「#{ mapped_color }」についてコメントを生成してください。"
      #color_responseからAIにプロンプトを投げてresponseを生成する
      ai_response = ::ColorResponseService.new.fetch_response(prompt)
      color_response = ai_response["choices"][0]["message"]["content"]

      #self_logレコードを作成後、responsesテーブルにai_commentを保存
      self_log = @color.self_logs.create(user: current_user)
      @response = self_log.responses.create(ai_comment: color_response)

      redirect_to colors_path, notice: '色とAIレスポンスを保存しました'
    else
      flash.now[:alert] = '保存失敗'
      render :new, status: :unprocessable_entity
    end

  end

  private
  def color_params
    params.require(:color).permit(:color_name)
  end
end

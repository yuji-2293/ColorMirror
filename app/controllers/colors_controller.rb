class ColorsController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :new ]
  def top;end

  def index
    @start_date = Date.today.beginning_of_week
    @end_date = Date.today.end_of_week
    @week_colors = Color
      .joins(:self_logs)
      .includes(self_logs: [ :response, :weather_log ])
      .where(self_logs: { user_id: current_user.id })
      .where(colors: { created_at: @start_date.beginning_of_day..@end_date.end_of_day })
      .select("DISTINCT ON (DATE(colors.created_at)) colors.*")
      .order("DATE(colors.created_at), colors.created_at DESC")
  end

  def new
    @color = ColorForm.new
    @city = current_user.prefecture&.text
  end

  def create
    # newアクションで作成したオブジェクトにformオブジェクトインスタンスを格納
    @color = ColorForm.new(color_params)

    # formオブジェクトで処理されたデータを保存
    if @color.save
      flash[:notice] = "本日のデータは登録し、コメントを生成しました"
      self_log = @color.color.self_logs.find_by(user_id: current_user.id)

      # Jobを呼ぶコードを書く
      # promptとして使うデータを変数に格納
      prompt = color_params.slice(:color_name, :mood)
      weather_data = color_params.slice(:weather_name, :weather_pressure, :temperature)

      AiGenerationJob.perform_later(prompt, weather_data, self_log.id, @color.color.id, current_user.id)
      redirect_to colors_path
    else
      flash.now[:alert] = "保存失敗、情報が不足している可能性があります"
      render :new,  status: :unprocessable_entity
    end
  end

  def analyze
    mood = params[:mood]
    weather = params[:weather]

    suggested_colors = AiColorService.generate_color(mood, weather)
    render json: { colors: suggested_colors }
  end
  def form;end

  private

  def set_color
    @color = current_user.colors.find(params[:id])
  end
  def color_params
    params.require(:color).permit(:color_name, :mood, :mood_level, :weather_name, :description, :temperature, :temp_max, :temp_min, :weather_pressure, :weather_icon, :city, :color_analysis, :weather_analysis, :self_log_id).merge(user_id: current_user.id)
  end
end

class ColorsController < ApplicationController
  before_action :set_color, only: [ :edit, :update, :destroy ]
  def top;end

  def index
    @color = current_user.colors.today_form.first
    @response = current_user.responses.today_form.first
    @weather = current_user.weather_logs.today_form.first
  end

  def new
    @color = ColorForm.new
  end

  def create
    @color = ColorForm.new(color_params)
    # マッピングした色データを変数に格納
    mapped_color = ColorMapping.mapping_color(color_params[:color_name])
    weather_data = color_params.slice(:weather_name, :weather_pressure, :temperature)
    # AIレスポンス生成のserviceを呼び出す/必要な引数を渡す、生成したレスポンスを変数に格納
    ai_responses= ColorProcessingService.new(@color, current_user,).process_color(mapped_color, weather_data)
    @color.color_analysis = ai_responses[:color_analysis]
    @color.weather_analysis = ai_responses[:weather_analysis]
    if @color.save
      redirect_to colors_path, notice: "色とAIレスポンスを保存しました"
    else
      flash.now[:alert] = "保存失敗"
      render :new,  status: :unprocessable_entity
    end
  end

  def edit
    @color_form = ColorForm.new(color: @color)
  end

  def update
        mapped_color = ColorMapping.mapping_color(color_params[:color_name])
        weather_data = color_params.slice(:weather_name, :weather_pressure, :temperature)
        ai_responses = ColorProcessingService.new(@color, current_user).process_color(mapped_color, weather_data)
        @color_form = ColorForm.new(color_params.merge(color: @color),color_analysis: color_analysis, weather_analysis: weather_analysis)
        if @color_form.save
        redirect_to colors_path(@color), notice: "色の更新に成功しました！"
        else
        flash.now[:alert] = "編集失敗"
        render :edit, status: :unprocessable_entity
        end
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
  end

  def destroy
    current_user.colors.today_form.destroy_all
    redirect_to new_color_path, notice: "データの削除成功", status: :see_other
  end


  private

  def set_color
    @color = current_user.colors.find(params[:id])
  end
  def color_params
    params.require(:color).permit(:color_name, :weather_name, :description, :temperature, :temp_max, :temp_min, :weather_pressure, :weather_icon, :city, :color_analysis, :weather_analysis).merge(user_id: current_user.id)
  end
end

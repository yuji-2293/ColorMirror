class ColorsController < ApplicationController
  before_action :set_color, only: [ :edit, :update, :destroy ]
  def top;end

  def index
    @color = current_user.colors.today_form.first
    @response = current_user.responses.today_form.first
  end

  def new
    @color = Color.new
  end

  def create
    @color = current_user.colors.build(color_params)
    if @color.save!
      self_log = @color.self_logs.create(user: current_user)
      self_log.create_weather_log!(color_params[:self_logs_attributes]["0"][:weather_log_attributes])
      raise
      # /lib/にあるmoduleで色のマッピング
      mapped_color = ColorMapping.mapping_color(color_params[:color_name])
      # AIレスポンス生成のserviceを呼び出す/必要な引数を渡す
      ColorProcessingService.new(@color, current_user).process_color(mapped_color)
      redirect_to colors_path, notice: "色とAIレスポンスを保存しました"
    else
      flash.now[:alert] = "保存失敗"
      render :new,  status: :unprocessable_entity
    end
  end

  # def create
  #   @color = current_user.colors.build(color_params)

  #   if @color.save
  #     @weather = colors.weather_log.build(color_params[:weather_logs_attributes])
  #     raise

  #     # /lib/にあるmoduleで色のマッピング
  #     mapped_color = ColorMapping.mapping_color(color_params[:color_name])
  #     # AIレスポンス生成のserviceを呼び出す/必要な引数を渡す
  #     ColorProcessingService.new(@color, current_user).process_color(mapped_color)
  #     redirect_to colors_path, notice: "色とAIレスポンスを保存しました"
  #   else
  #     flash.now[:alert] = "保存失敗"
  #     render :new,  status: :unprocessable_entity
  #   end
  # end




  def edit;end

  def update
    if @color.update(color_params)
      mapped_color = ColorMapping.mapping_color(color_params[:color_name])
      ColorProcessingService.new(@color, current_user).process_color(mapped_color)
      redirect_to colors_path(@color), notice: "色の更新に成功しました！"
    else
      flash.now[:alert] = "編集失敗"
      render :edit, status: :unprocessable_entity
    end
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
    params.require(:color).permit(:color_name,
    self_logs_attributes: [:id,
    weather_log_attributes: [:weather_name, :city, :description, :temperature, :temp_max, :temp_min, :weather_pressure, :weather_icon
  ]
  ]
    )
  end
end

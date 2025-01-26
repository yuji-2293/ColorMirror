class ColorsController < ApplicationController
  before_action :set_color, only: [:edit, :update, :destroy]
  def top;end

  def index
    @color = current_user.colors.today_form.first
    @response = current_user.responses.today_form.first

  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(color_params)
    if @color.save
      # /lib/にあるmoduleで色のマッピング
      mapped_color = ColorMapping.mapping_color(color_params[:color_name])
      # AIレスポンス生成のserviceを呼び出す/必要な引数を渡す
      ColorProcessingService.new(@color, current_user).process_color(mapped_color)
      redirect_to colors_path, notice: '色とAIレスポンスを保存しました'
    else
      flash.now[:alert] = '保存失敗'
      render :new, status: :unprocessable_entity
    end
  end

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
    @color.destroy!
    redirect_to colors_path, notice: "削除成功", status: :see_other
  end


  private

  def color_params
    params.require(:color).permit(:id, :color_name)
  end
end

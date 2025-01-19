class ColorsController < ApplicationController
  def top;end

  def index
    @colors = Color.all.includes(:self_logs)

  end

  def new
    @color = Color.new
  end

  def create
    @color = current_user.colors.build(color_params)

    if @color.save

      redirect_to colors_path, notice: '保存成功'
    else
      flash.now[:alert] = '保存失敗'
      render :new, status: :unprocessable_entity
    end

  end

  private
  def color_params
    params.require(:color).permit(:color_name, :user_id, :id)
  end
end

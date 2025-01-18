class ColorsController < ApplicationController
  def top;end

  def index
    @colors = Color.all.includes(:user)

  end

  def new
    @color = Color.new
  end

  def create
    @color = current_user.color.build(color_params)

    if @color.save
      redirect_to root_path, notice: '保存成功'
    else
      flash.now[:alert] = '保存失敗'
      render :new, status: :unprocessable_entity
    end

  end

  private
  def color_params
    params.require(:color).permit(:color_id)
  end
end

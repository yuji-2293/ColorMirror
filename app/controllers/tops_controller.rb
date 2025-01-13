class TopsController < ApplicationController
  def index
    @tops = User.all # 条件を指定
  end
end

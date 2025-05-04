class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def reminder
    respond_to do |format|
      format.turbo_stream
    end
  end
end

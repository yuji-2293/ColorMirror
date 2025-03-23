# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :require_no_authentication, only: [:new, :create, :edit, :update, :reset_password]

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = User.find_by(email: params[:user][:email])

   if resource.present?
    super
    flash[:notice] = "パスワードリセットのメールを送信しました"
   else
    flash[:alert] = "メールアドレスが未入力です"
    redirect_to new_session_path(resource_name)
   end
  end

  def reset_password
    self.resource = resource_class.new
    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  def after_resetting_password_path_for(resource)
    if user_signed_in?
      flash[:notice] = "パスワードが変更されました"
      profile_users_path(current_user)
    else
      new_session_path(resource_name)
    end
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    if user_signed_in?
      profile_users_path(current_user)
    else
      new_session_path(resource_name)
    end
  end
end

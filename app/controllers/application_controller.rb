class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  def after_sign_in_path_for(resource)
    root_path
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :prefecture ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :name, :email, :prefecture, :type ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :prefecture, :password, :password_confirmation, :type ])
  end

  private
  def set_color
    @color = current_user.colors.find(params[:id])
  end
end

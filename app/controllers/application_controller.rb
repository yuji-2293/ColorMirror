class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :name, :email ])
  end

  private
  def set_color
    @color = current_user.colors.find(params[:id])
  end
end

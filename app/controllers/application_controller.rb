class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_gon
  protect_from_forgery


  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :prefecture ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :name, :email, :prefecture ])
  end

  private
  def set_color
    @color = current_user.colors.find(params[:id])
  end

  def set_gon
    gon.color_mapping = ColorMapping::COLOR_MAPPING
  end
end

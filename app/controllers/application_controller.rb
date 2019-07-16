class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :dummy_avatar

  def dummy_avatar(user)
    "https://ui-avatars.com/api/?name=#{user.first_name}+#{user.last_name}&size=256&background=333333&color=FFFFFF"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end

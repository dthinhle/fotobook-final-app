class ApplicationController < ActionController::Base
  begin
    :user_signed_in?
  rescue => exception
    layout 'devise'
  end

  # if :devise_controller?
  #   layout 'devise'
  # end

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end

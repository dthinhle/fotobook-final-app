class ApplicationController < ActionController::Base

  include LetterAvatar::AvatarHelper

  before_action :authenticate_user!
  before_action :is_blocked?, unless: :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :dummy_avatar

  protected

  def dummy_avatar(user)
    letter_avatar_url(user.name, 256)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end

  def is_blocked?
    begin
      if current_user.blocked
        redirect_to blocked_path
      end
    rescue => exception

    end
  end
end

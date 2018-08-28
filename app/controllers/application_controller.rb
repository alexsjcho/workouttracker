class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?
before_action :redirect_to_subdomain

private

def redirect_to_subdomain
  return if self.is_a?(DeviseController)
  if current_user.present? && request.subdomain != current_user.subdomain
    redirect_to workouts_url(subdomain: current_user.subdomain)

  end
end

def after_sign_in_path_for(resource_or_scope)
  root_url(subdomain: resource_or_scope.subdomain)
end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :subdomain])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :subdomain])
    end
end

#Google OAuth 2

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authenticate
  	redirect_to :login unless user_signed_in?
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
  	# converts current_user to a boolean by negating the negation
  	!!current_user
  end

end

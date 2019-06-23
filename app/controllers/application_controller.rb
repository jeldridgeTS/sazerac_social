class ApplicationController < ActionController::Base
  include Pundit
  include DeviseWhitelistConcern
  include SetVisitorOriginConcern
  include CurrentUserConcern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # TEMP STUFF
  # Devise code
  before_action :configure_permitted_parameters, if: :devise_controller?
  # TEMP STUFF

  protected
  # TEMP STUFF
  # Devise methods
  # Authentication key(:username) and password field will be added automatically by devise.
  def configure_permitted_parameters
    added_attrs = [:email, :display_name, :first_name, :last_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  # TEMP STUFF

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end

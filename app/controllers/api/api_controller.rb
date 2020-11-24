class Api::ApiController < ActionController::Base
  include Pundit

  respond_to :json

  before_action :authenticate
  skip_before_action :verify_authenticity_token

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate
    unless logged_in?
      render json: { error: "WRONG!" }, status: 401
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present?
      user = User.find(auth["user_id"])
      @current_user ||= user if user
    end
  end

  private

  def auth
    jwt = cookies.signed[:jwt]
    Auth::JwtTokenAuth.decode_token(jwt)
  end

  def auth_present?
    !!cookies.signed[:jwt]
  end

  def user_not_authorized
    render json: { error: "Unauthorzed" }, status: 401
  end
end

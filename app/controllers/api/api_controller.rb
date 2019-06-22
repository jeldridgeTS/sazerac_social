class Api::ApiController < ActionController::Base
  respond_to :json
  before_action :authenticate
  skip_before_action :verify_authenticity_token

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present?
      user = User.find(auth["user_id"])
      @current_user ||= user if user
    end
  end

  def authenticate
    unless logged_in?
      render json: { error: "WRONG!" }, status: 401
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
end

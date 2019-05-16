class Api::ApiController < ActionController::API
  before_action :authenticate

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present?
      user = User.find(auth["user_id"])
      @current_user ||= user if user
      render json: { data: @current_user }, status: 200
    end
  end

  def authenticate
    unless logged_in?
      render json: { error: "POOPOO" }, status: 401
    end
  end

  private

  def auth
    Auth::JwtTokenAuth.decode_token(request.authorization)
  end

  def auth_present?
    !!request.authorization
  end
end

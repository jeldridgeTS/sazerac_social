class Api::V1::SessionsController < Api::ApiController
  skip_before_action :authenticate

  def create
    @user = User.where(email: params[:email]).first

    if @user&.valid_password? params[:password]
      # TODO: Signin/Login helper here
      jwt = Auth::JwtTokenAuth.issue_token({ user_id: @user.id })

      cookies.signed[:jwt] = { value: jwt, httponly: true }
    else
      head(:unauthorized)
    end
  end

  def logged_in
    if current_user
      render json: { logged_in: true }
    else
      render json: { logged_in: false }
    end
  end

  def destroy
    cookies.delete(:jwt)

    render json: { msg: "Logged out" }
  end
end

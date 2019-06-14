class Api::V1::SessionsController < Api::ApiController
  skip_before_action :authenticate

  def create
    @user = User.where(email: params[:email]).first

    if @user&.valid_password? params[:password]
      jwt = Auth::JwtTokenAuth.issue_token({ user_id: @user.id })
      
      cookies.signed[:jwt] = {value:  jwt, httponly: true}
    else
      # respond_to do |format|
      #   format.json { render plain: { error: 'invalid_credentials' }.to_json, content_type: 'application/json' }
      # end
      head(:unauthorized)
    end
  end

  def destroy
    cookies.delete(:jwt)

    render json: { msg: "Logged out" }
  end
end

class Api::V1::CurrentUserController < Api::ApiController

  def show
    render json: { user: @current_user }
  end
end

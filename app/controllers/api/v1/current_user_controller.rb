class Api::V1::CurrentUserController < Api::ApiController

  def show
    render json: { user: current_user }, include: :roles
  end
end

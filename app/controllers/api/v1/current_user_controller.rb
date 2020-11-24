class Api::V1::CurrentUserController < Api::ApiController
  def show
    render :show, status: 200, locals: { user: current_user }, include: :roles
  end
end

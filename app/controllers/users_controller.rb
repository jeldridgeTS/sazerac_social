class UsersController < ApplicationController
  # TODO: Get rid of this, use list_users or similar
  def index
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :display_name)
    end
end

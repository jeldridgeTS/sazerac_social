class AdminsController < ApplicationController
  before_action :set_admin

  after_action :verify_authorized

  def list_users
    @users = User.all
  end

  private
    def set_admin
      @admin = current_user
      authorize @admin
    end
end

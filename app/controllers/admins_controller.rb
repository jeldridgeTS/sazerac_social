class AdminsController < ApplicationController
  before_action :set_admin

  def users
    @users = User.all
  end

  private
    def set_admin
      @admin = current_user
    end
end

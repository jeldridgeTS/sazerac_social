module Admin
  class DashboardController < ApplicationController
    before_action :set_admin

    after_action :verify_authorized

    def dashboard
    end

    private
    def set_admin
      @admin = current_user
      authorize @admin
    end
  end
end

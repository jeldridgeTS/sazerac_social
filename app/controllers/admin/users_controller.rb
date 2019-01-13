module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_admin

    after_action :verify_authorized

    def index
      @users = User.all
    end

    def show
      find_by_display_name
    end

    def search_users
      redirect_to admin_user_path(params[:display_name])
    end

    # TODO: Maybe move this to model / refactor to use ids as well
    def find_by_display_name
      @user = User.find_by_id(params[:id])
    end

    def add_role
      @user = User.find_by_id(params[:id])
      @user.assign_role params[:user][:roles]

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_user_path(@user.id), notice: 'User role successfully added.' }
          format.json { render :show, status: :updated, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def remove_role
      @users = User.all
    end

    private
      def set_admin
        @admin = current_user
        authorize @admin
      end

      def user_params
        params.require(:user).permit(:id, :email, :display_name)
      end
  end
end

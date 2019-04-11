module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_admin

    after_action :verify_authorized

    # TODO: Get rid of this, use list_users or similar
    def index
      unless params[:display_name]
        redirect_to admin_dashboard_path, notice: 'Please enter a user display name.'
      end

      @users = User.where(display_name: params[:display_name])
    end

    def show
      @user = User.find(params[:id])
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
      @user = User.find_by_id(params[:id])
      @user.remove_role params[:user][:roles]

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_user_path(@user.id), notice: 'User role successfully removed.' }
          format.json { render :show, status: :updated, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
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

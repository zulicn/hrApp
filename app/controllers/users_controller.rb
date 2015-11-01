class UsersController < ApplicationController
	respond_to :html

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = sign_up(user_params)
    sign_in(@user) do
      respond_with(@user, location: root_path) and return
    end
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :email, :password, :role_id, :department_id)
  end
end

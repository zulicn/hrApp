class UsersController < ApplicationController
	respond_to :html

  def new
    @user = User.new
  end

  def index
    @accepted_users = User.where(is_accepted: true)
    @new_users = User.where(is_accepted: false)
    if params[:search]
      @accepted_users = User.where(is_accepted: true).search(params[:search])
    else
      @accepted_users = User.where(is_accepted: true)
    end
  end

  def create
    @user = sign_up(user_params)
    sign_in(@user) do
      respond_with(@user, location: root_path) and return
    end
    render :new
  end

  # Accept user
  def accept
    user = User.find(params[:id])
    user.is_accepted = true
    user.save!
    redirect_to users_path
  end

  # Promote user to admin
  def promote
    user = User.find(params[:id])
    user.role = Role.find_by(name: 'Admin')
    user.save!
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :email, :password, :role_id, :department_id)
  end
end

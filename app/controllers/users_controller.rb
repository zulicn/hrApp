class UsersController < ApplicationController
	respond_to :html
  before_action :restrict_access, only: [:accept, :promote]

  def new
    @user = User.new
  end

  def index
    @new_users = User.where(is_accepted: false)

    @accepted_users = User.where(is_accepted: true)
    if params[:search]
      @accepted_users = User.where(is_accepted: true).search(params[:search])
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

  def restrict_access
    return redirect_to new_session_path if current_user.nil? || current_user.role != Role.find_by(name: 'Admin')
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :email, :password, :role_id, :department_id)
  end
end

class UsersController < ApplicationController
	respond_to :html
  before_action :restrict_access, only: [:accept, :promote]
  layout 'public'

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params.merge(role_id: Role.member.id))
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :phone, :department_id, :birth_date, :place_of_birth, :previous_experience, :reason_of_enrollment, :additional_skills, :password)
  end
end

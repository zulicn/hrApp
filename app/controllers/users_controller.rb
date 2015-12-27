class UsersController < ApplicationController
	respond_to :html
  before_action :restrict_access, only: [:accept, :promote]
  before_action :set_user, only: [:edit, :update]
  layout 'public'

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params.merge(role_id: Role.member.id, is_accepted: false))
    respond_to do |format|
      # if user is saved by sign up method id will be populated
      if @user.id
        #EestecMailer.new_user(@user.firstname).deliver
        redirect_to dashboard_path
      else
        render :new
      end
    end
  end

  def edit
    @edit = true
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        redirect_to dashboard_path
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :phone, :department_id, :birth_date, :place_of_birth, :previous_experience, :reason_of_enrollment, :additional_skills, :password, :alumni_position)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

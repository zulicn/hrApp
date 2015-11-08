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
      if @user
        format.html { redirect_to dashboard_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @edit = true
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to dashboard_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :phone, :department_id, :birth_date, :place_of_birth, :previous_experience, :reason_of_enrollment, :additional_skills, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

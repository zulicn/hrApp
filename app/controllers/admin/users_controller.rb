module Admin
  class UsersController < AdminController
  	respond_to :html
    before_action :restrict_access, only: [:accept, :promote]

    def index
      @new_users = User.where(is_accepted: false)

      @accepted_users = User.where(is_accepted: true)
      if params[:search]
        @accepted_users = User.where(is_accepted: true).search(params[:search])
      end
    end

    # Accept user
    def accept
      @user = User.find(params[:id])
      @user.is_accepted = true
      if @user.save
        EestecMailer.user_acceptance(@user.id).deliver
        respond_to do |format|
          format.html { redirect_to users_path }
          format.js { }
        end
      end
    end

    # Promote user to admin
    def promote
      @user = User.find(params[:id])
      @user.role = Role.find_by(name: 'Admin')
      @user.save!
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js { }
      end
    end

    def show
      @user = User.find(params[:id])
      @details = UserInfo.new(@user).build
    end
  end
end

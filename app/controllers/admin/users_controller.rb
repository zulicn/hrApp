module Admin
  class UsersController < AdminController
  	respond_to :html

    def index
      @new_users = User.where(is_accepted: false)

      @accepted_users = User.where(is_accepted: true)
      if params[:search]
        @accepted_users = User.where(is_accepted: true).search(params[:search])
      end
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

    def show
      @user = User.find(params[:id])
    end

  end
end

class SessionsController < ApplicationController
  skip_before_filter :restrict_access, except: :destroy
  respond_to :html
  layout 'public'

  def new
  end

  def create
    user = authenticate_session(session_params)
    if user && user.is_accepted
      sign_in(user) do
        if user.is_admin?
          respond_with(user, location: admin_dashboard_path) and return
        else
          respond_with(user, location: dashboard_path) and return
        end
      end
    else
      respond_with(user, location: dashboard_path) and return
    end
    render :new
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
class SessionsController < ApplicationController
  respond_to :html

  def new
  end

  def create
    user = authenticate_session(session_params)
    if user.is_accepted
      sign_in(user) do
        respond_with(user, location: dashboard_path) and return
      end
    else
      respond_with(user, location: root_path) and return
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
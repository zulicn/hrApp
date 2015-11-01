class DashboardController < ApplicationController
  def index
  	@current_user = current_user
  end

  private
  def current_user
    User.find(1) 
  end
end
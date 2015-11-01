module Admin
  class AdminController < ApplicationController
    before_filter :restrict_access
    layout 'admin'

    def restrict_access
      return redirect_to new_session_path if current_user.nil? || current_user.role != Role.admin
    end
  end
end

class WelcomesController < ApplicationController
  skip_before_filter :restrict_access
  layout 'public'

  def show
  end
end
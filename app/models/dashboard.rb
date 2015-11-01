class Dashboard
  attr_accessor :notifications

  def initialize(user)
    @user = user
    @notifications = []
  end

  def build
    build_notifications
    self
  end

  def build_notifications
    projects = Project.all
    projects.each do |project|
      next if project.member?(@user)
      notifications << Notification.new(
        message: "Kreiran je novi projekat #{project.name}, da li želite učestvovati",
        link: "/memberships/new?project_id=#{project.id}"
      )
    end
  end
end
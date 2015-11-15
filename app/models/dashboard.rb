class Dashboard
  attr_accessor :notifications, :active_projects

  def initialize(user)
    @user = user
    @notifications = []
    @active_projects = []
    @active_events = []
  end

  def build
    build_notifications
    build_active_projects
    build_active_events
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

  def build_active_projects
    @active_projects = Project.where(is_active: true)
  end

  def build_active_events
    @active_events = Event.where(is_active: true)
  end
end
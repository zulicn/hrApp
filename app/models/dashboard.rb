class Dashboard
  attr_accessor :notifications, :active_projects, :tasks, :applications

  def initialize(user, filter)
    @user = user
    @filter = filter
    @notifications = []
    @active_projects = []
    @tasks = []
  end

  def build
    build_notifications
    build_active_projects
    build_applications
    build_tasks
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

  def build_tasks
    @memberships = Membership.where(user: @user, project: Project.where(is_active: true))
    @memberships.each do |mem|
      pt = ProjectTeam.where(project_id: mem.project_id, team_id: mem.team_id)
      Task.where(project_team_id: pt.map(&:id)).each do |task|
        next if task.deadline_to_apply < Time.now
        next if @filter[:tasks] == 'my_tasks' && !@applications.map(&:task_id).include?(task.id)
        next if @filter[:tasks] == 'open_tasks' && @applications.map(&:task_id).include?(task.id)
        next if task.user_tasks.count > task.num_of_members
        @tasks << task
      end
    end
  end

  def build_applications
    @applications = UserTask.where(user: @user)
  end
end
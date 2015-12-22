class Dashboard

  attr_accessor :notifications, :active_projects, :active_events, :tasks, :applications, :workshops

  def initialize(user, filter)
    @user = user
    @filter = filter
    @notifications = []
    @active_projects = []
    @active_events = []
    @tasks = []
    @workshops = []
  end

  def build
    build_notifications
    build_active_projects
    build_active_events
    build_applications
    build_tasks
    build_workshops
    self
  end

  def build_notifications
    user_tasks = @user.tasks.where('deadline > ?', Time.now)
    user_tasks.each do |task|
      next if task.deadline > 2.days.from_now
      notifications << Notification.new(
        message: "Deadline za task #{task.name} vam ističe za #{task.days_to_deadline} dana",
        class: 'red'
        )
    end

    projects = Project.all
    projects.each do |project|
      next if project.member?(@user)
      notifications << Notification.new(
        message: "Kreiran je novi projekat #{project.name}, da li želite učestvovati",
        link: "/memberships/new?project_id=#{project.id}"
      )
    end

    events = Event.includes(:users).where(is_active: true)
    events.each do |event|
      next if event.joined?(@user)
      notifications << Notification.new(
        message: "Kreiran je novi event #{event.name}, da li želite prisustvovati",
        link: "/events/#{event.id}"
        )
    end

    workshops = Workshop.for_apply
    workshops.each do |ws|
      notifications << Notification.new(
        message: "Kreirana je nova radionica #{ws.name}, prijave do #{ws.deadline.strftime('%d.%m.%Y')}",
        )
    end
  end

  def build_active_projects
    @active_projects = Project.where(is_active: true)
  end


  def build_active_events
    @active_events = Event.where(is_active: true).
                           where('start_date > ?', DateTime.now.to_date).
                           order('start_date ASC, created_at ASC')
  end

  def build_tasks
    @memberships = Membership.where(user: @user, project: Project.where(is_active: true))
    @memberships.each do |mem|
      pt = ProjectTeam.where(project_id: mem.project_id, team_id: mem.team_id)
      Task.where(project_team_id: pt.map(&:id)).each do |task|
        next if task.deadline_to_apply_over?
        next if @filter[:tasks] == 'my_tasks' && !@applications.map(&:task_id).include?(task.id)
        next if @filter[:tasks] == 'open_tasks' && @applications.map(&:task_id).include?(task.id)
        next if task.user_tasks.count > task.num_of_members
        @tasks << task
      end
    end
  end

  def build_workshops
    @workshops = @user.workshops
  end

  def build_applications
    @applications = UserTask.where(user: @user)
  end
end
class UserInfo
  attr_accessor :user, :tasks, :teams_per_project

  def initialize(user)
    @user = user
    @tasks = []
    @teams_per_project = []
  end

  def build
    build_tasks
    build_teams
    self
  end

  private

  def build_tasks
    teams = Team.all
    @tasks = Hash[teams.map {|t| [t.shortcode, []]}]
    user_tasks = @user.tasks
                 .joins(project_team: [:project, :team])
                 .includes(project_team: [:project, :team])
                 .where('projects.is_active = ?', true)

    user_tasks.each do |task|
      team_shortcode = task.team ? task.team.shortcode : task.project_team.team.shortcode
      @tasks[team_shortcode] << task
    end
  end

  def build_teams
    projects = Hash[Project.all.map { |p| [p.id, p.name] }]
    teams = Hash[Team.all.map { |t| [t.id, t.shortcode] }]
    memberships = @user.memberships.joins(:project)
                 .includes(:project)
                 .where('projects.is_active = ?', true)
                 .group_by(&:project_id)

    memberships.each do |project_id, mems|
      @teams_per_project << {
        project: projects[project_id],
        teams: mems.map(&:team_id).map { |team_id| teams[team_id] }.join(', ')
      }
    end
  end
end

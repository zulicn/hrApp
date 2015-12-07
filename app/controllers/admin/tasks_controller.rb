module Admin
  class TasksController < AdminController

    def new
      @task = Task.new()
      @project_team = ProjectTeam.find(params[:project_team_id])
    end

    def create
      task = Task.create(task_params.merge(:creator_id => @current_user.id, :is_active => true, :project_team_id => params[:project_team_id]))
      task.save!
      redirect_to admin_project_path(params[:project_id])
    end


  def edit
    @project = Project.find(params[:project_id])
    @project_team = ProjectTeam.find(params[:project_team_id])
    @teams = @project_team.team
    @task = Task.find(params[:id])
    @edit = true
  end

  def update
    params[:user_tasks] ||= []
    project = Project.find(params[:project_id])
    task = Task.find(params[:id])
    task.update(task_params)
    accepted_users = params[:user_tasks]

    task.user_tasks.each do |unchecked|
      unchecked.accepted=false;
      unchecked.save!
    end

    accepted_users.each do |user_task|
      find_user_task = UserTask.find(user_task);
      find_user_task.accepted = true;
      find_user_task.admin_report=params[:admin_report];
      find_user_task.save!
    end

    task.save!
    redirect_to admin_project_path(project)
  end

   def destroy
      project = Project.find(params[:project_id])
      task = Task.find(params[:id])
      #user_task=UserTask.where(task_id: task.id);
      #user_task.destroy!
      task.destroy!
      redirect_to admin_project_path(project)
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :num_of_members, :deadline_to_apply, :deadline, :note,:report,:material,:is_active, :admin_report)
    end

def set_task
    @task = Task.find(params[:id])
  end
  end
end
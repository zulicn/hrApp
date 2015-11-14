module ApplicationHelper
  def project_active_class(project)
    project.is_active ? 'project-active' : 'project-archived'
  end

  def task_active_badge(task)
    task.is_active ? 'Active' : 'Finished'
  end
end

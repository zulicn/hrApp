module ApplicationHelper
  def project_active_class(project)
    project.is_active ? 'project-active' : 'project-archived'
  end

  def task_active_badge(task)
    task.is_active ? 'Active' : 'Finished'
  end

  def task_label(task, applications)
    return 'Prijavljen' if applications.map(&:task_id).include?(task.id)
    'Otvoren'
  end
end

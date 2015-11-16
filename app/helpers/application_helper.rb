module ApplicationHelper
  def project_active_class(project)
    project.is_active ? 'project-active' : 'project-archived'
  end
<<<<<<< HEAD
  def event_active_class(event)
    event.is_active ? 'event-active' : 'event-archived'
=======

  def task_active_badge(task)
    task.is_active ? 'Active' : 'Finished'
  end

  def task_label(task, applications)
    return 'Prijavljen' if applications.map(&:task_id).include?(task.id)
    'Otvoren'
>>>>>>> 30bd1d9926283403ce8f3ce438c1cede3fc395e5
  end
end

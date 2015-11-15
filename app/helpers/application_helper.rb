module ApplicationHelper
  def project_active_class(project)
    project.is_active ? 'project-active' : 'project-archived'
  end
  def event_active_class(event)
    event.is_active ? 'event-active' : 'event-archived'
  end
end

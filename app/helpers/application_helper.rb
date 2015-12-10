module ApplicationHelper
  def project_active_class(project)
    project.is_active ? 'project-active' : 'project-archived'
  end
  def event_active_class(event)
    event.is_active ? 'event-active' : 'event-archived'
  end

  def task_active_badge(task)
    task.is_active ? 'Active' : 'Finished'
  end

  def task_label(task, applications)
    unless UserTask.where(task_id: task.id).empty?
      return 'Zavrsen' if !task.is_active
      return 'Odobren' if  UserTask.find_by(task_id: task.id).user_id == @current_user.id && UserTask.find_by(task_id: task.id).accepted
      return 'Odbijen' if UserTask.find_by(task_id: task.id).user_id == @current_user.id && !UserTask.find_by(task_id: task.id).accepted
    end
    return 'Prijavljen' if applications.map(&:task_id).include?(task.id)
    'Otvoren'
  end

  def event_attendence(event)
    return "Da" if event.should_record_attendence
    "Ne"
  end

  def event_chargeable(event)
    return "Naplata" if event.is_chargeable
    "Besplatan"
  end

end

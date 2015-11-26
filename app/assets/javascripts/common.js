function showApplicationModal(id, task_id, task_description) {
  $(id + ' #task-description').text(task_description);
  $(id + ' #task_id').attr('value', task_id);
  $(id).modal();
}

function showUserTaskModal(id, taskDescription, taskNote, task_id) {
    $('#userTaskDescription').text(taskDescription);
    $('#userTaskNote').text(taskNote);
    $('#task_id').attr('value', task_id);
    $(id).modal();
}

$(document).ready(function(){
  attachProjectListeners(); 
});

function attachProjectListeners() {
  $('a.load-messages').on('click', function(e){
    $(this).hide();
    const id = $(this).data('id')
    e.preventDefault(); 
    loadMessages(this, id); 
  });
  $('a.load-tasks').on('click', function(e){
    $(this).hide(); 
    const id = $(this).data('id')
    e.preventDefault();
    loadTasks(this, id); 
  });
  $('a.next-project').on('click', function(e){
    const id = $(this).data('id')
    e.preventDefault(); 
    nextProject(this, id);
  })
};

function loadMessages(element, id){
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: `/projects/${id}/messages.json`
  })
  .success(function(messages){
    if (messages.length === 0){
      let $header = $("div.project-messages"); 
      $header.html("No Message(s)")
    } else {
      let $header = $("div.project-messages"); 
      $header.html("Message(s):")
      let $ul = $("#messages")
      messages.forEach(message => {
        let newMessage = new Message(message)
        let messageHtml = newMessage.formatMessage() 
        $ul.append(messageHtml)
      });
    }
  })
  .error(function(data){
    console.log(data)
  });
};

function Message(message) {
  this.title = message.title 
  this.content = message.content 
  this.id = message.id
}

Message.prototype.formatMessage = function() {
  let messageHtml = `
  <li><a href='/messages/${this.id}'><strong><u>${this.title}:</strong></u> ${this.content}</a></li>`
  return messageHtml; 
}

function loadTasks(element, id) {
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: `/projects/${id}/tasks.json`
  })
  .success(function(tasks){ 
    if (tasks.length === 0) {
      let $header = $("div.project-tasks");
      $header.html("No Task(s)")
    } else {
      let $header = $("div.project-tasks");
      $header.html("Task(s):")
      let $ul = $("#tasks")
      tasks.forEach(task => {
        let newTask = new Task(task) 
        let taskHtml = newTask.formatTask() 

        $ul.append(taskHtml)
      });
    }
  });
}

function Task(task) {
  this.title = task.title 
  this.description = task.description
  this.assigned_to = task.assigned_to
  this.status = task.status 
  this.id = task.id 
}

Task.prototype.formatTask = function() {
  let taskHtml = `<li><a href='/tasks/${this.id}'><strong><u>${this.title}:</strong></u> <br>
  ${this.description}<br><strong>
  Assigned to: </strong>${this.assigned_to}<br><strong>
  Status: </strong>${this.status}</a></li>`
  return taskHtml;
}

// Rendering next show page of each project
function nextProject(element, id){
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: `/projects/${id +1}.json`
  })
  .success(function(response){
    const newProject = new Project(response)
    $('.title').html(newProject.title)
    $('.description').html(newProject.description) 
    $('.project-messages').html(newProject.messages)
    $('.project-tasks').html(newProject.tasks)
  });
}

function Project(project){
  this.title = project.title 
  this.description = project.description
  this.id = project.id
}

Project.prototype.formatProject = function() {
  let projectHtml = `<li><a href='/projects/${this.id}>${this.title} <br>
  ${this.description}
  </li>` 
  return projectHtml;
}
//create new Project prototype, add all the attributes, and then render the new attribute for each new project


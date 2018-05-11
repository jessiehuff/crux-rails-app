$(document).on('turbolinks:load', function(){
  attachProjectListeners(); 
});

function attachProjectListeners() {
  $('a.load-messages').on('click', function(e){
    $(this).hide();
    const id = $(this).data('id')
    e.preventDefault(); 
    loadMessages(this, id); 
  });
  $('a.new_message').on('click', function(e){
    $(this).hide();
    const id = $(this).data('id')
    e.preventDefault();
    getMessageForm(this, id);
  });
  $(document).on('submit', "#new_message", function(e){
    const id = $(this).data('id')
    e.preventDefault();
    postMessages(this, id);
  });
  $('a.load-tasks').on('click', function(e){
    $(this).hide(); 
    const id = $(this).data('id')
    e.preventDefault();
    loadTasks(this, id); 
  });
  $('a.new-task').on('click', function(e){
    $(this).hide();
    const id = $(this).data('id')
    e.preventDefault();
    getTaskForm(this, id);
  });
  $(document).on('submit', "#new_task", function(e){
    e.preventDefault(); 
    const id = $(this).data('id')
    postTasks(this, id);
  });
  $('a.next-project').on('click', function(e){
    debugger
    const id = $(this).data('id')
    e.preventDefault(); 
    nextProject(this, id);
  })
};

// Loading Messages
function loadMessages(element, id){
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: `/projects/${id}/messages.json`
  })
  .success(function(messages){
    if (messages.length === 0){
      let $header = $(".project-messages"); 
      $header.html("No Message(s)")
    } else {
      let $header = $(".project-messages"); 
      $header.html("Message(s):")
      let $ul = $("#messages")
      messages.forEach(message => {
        let newMessage = new Message(message)
        let messageHtml = newMessage.formatMessages() 
        $ul.append(messageHtml)
      });
    }
  })
};

function Message(message, project_id) {
  
  this.title = message.title 
  this.content = message.content 
  this.id = message.id
  this.project_id = project_id
}

Message.prototype.formatMessages = function() {
  let messageHtml = `
  <li><a href='/projects/${this.project_id}/messages/${this.id}'><strong><u>${this.title}:</strong></u> ${this.content}</a></li>`
  return messageHtml;
}

// Submit New Message via AJAX 
function getMessageForm(element, id){
  $.ajax({
    url: element.getAttribute('href'), 
    type: "GET", 
  })
  .success(function(response) {
    $(".messageResult").html(response)
    });
  }

function postMessages(element, id){
  const data = $(element).serialize()
  $.post(`/projects/${id}/messages.json`, data).success(function(response) {          
    const newMessage = new Message(response)
    let messageHtml = newMessage.formatMessages()
    $('#messages').prepend(messageHtml)
    })
  }


//Loading Tasks 
function loadTasks(element, id) {
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: `/projects/${id}/tasks.json`
  })
  .success(function(tasks){ 
    if (tasks.length === 0) {
      let $header = $(".project-tasks");
      $header.html("No Task(s)")
    } else {
      let $header = $(".project-tasks");
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

function Task(task, project_id) {
  this.title = task.title 
  this.description = task.description
  this.assigned_to = task.assigned_to
  this.status = task.status 
  this.id = task.id 
  this.project_id = project_id
}

Task.prototype.formatTask = function() {
  let taskHtml = `<li><a href='/projects/${this.project_id}/tasks/${this.id}'><strong><u>${this.title}:</strong></u> <br>
  ${this.description}<br><strong>
  Assigned to: </strong>${this.assigned_to}<br><strong>
  Status: </strong>${this.status}</a></li><br>`
  return taskHtml;
}

// Submit New Task via AJAX
function getTaskForm(element, id){
  $.ajax({
    url: element.getAttribute('href'),
    type: "GET", 
  })  
  .success(function(response){
    $(".taskResult").html(response)
  });
}
function postTasks(element, id){
  const data = $(element).serialize()
  $.post(`/projects/${id}/tasks.json`, data).success(function(response){
    const newTask = new Task(response, id)
    let taskHtml = newTask.formatTask() 
    $('#tasks').prepend(taskHtml)
  })
}

// Rendering next show page of each project
function nextProject(element, id){
  const nextId = id + 1
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: `/projects/${nextId}.json`
  })
  .success(function(response){
    console.log(response)
    const newProject = new Project(response)
    $('.next-project').attr('data-id', nextId)
    $('.next-project').attr('href', `/projects/${nextId}`)
    $('.title').html(newProject.title)
    $('.description').html(newProject.description)
    $('.project-tags').html(newProject.formatTags())
    $('#messages').html(newProject.formatNestedMessages())
    $('#tasks').html(newProject.formatNestedTasks())
  });
}

function Project(project){
  this.id = project.id
  this.title = project.title 
  this.description = project.description
  this.tags = project.tags
  this.messages = project.messages.map(message => new Message(message, project.id)) 
  this.tasks = project.tasks.map(task => new Task (task))
}

Project.prototype.formatProject = function() {
  let projectHtml = `<li><a href='/projects/${this.id}>${this.title} <br>
  ${this.description}
  ${this.tags}
  ${this.messages}
  ${this.tasks}
  </li>` 
  return projectHtml
}
Project.prototype.formatTags = function() {
  let tagsArray = []
  let tagHtml = this.tags.forEach(function(tag){
    tagsArray.push(`<li>${tag.name}</li>`)
  })

  return tagsArray.join('')
}

Project.prototype.formatNestedMessages = function() {
  let messagesArray = []
  let messageHtml = this.messages.forEach(function(message){
    messagesArray.push(message.formatMessages())
  })
  return messagesArray.join('')
}

Project.prototype.formatNestedTasks = function() {
  let tasksArray = []
  let taskHtml = this.tasks.forEach(function(task){
    tasksArray.push(task.formatTask())
  })
  return tasksArray.join('')
}

//create new Project prototype, add all the attributes, and then render the new attribute for each new project
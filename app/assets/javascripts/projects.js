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
  $('a.new_message').on('click', function(e){
    const id = $(this).data('id')
    e.preventDefault();
    getMessageForm(this, id);
  });
  $(".new_message").submit(function(e){
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
    const id = $(this).data('id')
    e.preventDefault();
    getTaskForm(this, id);
  });
  $('.new-task').submit(function(e){
    const id = $(this).data('id')
    e.preventDefault(); 
    postTasks(this, id);
  });
  $('a.next-project').on('click', function(e){
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
      let $header = $("div.project-messages"); 
      $header.html("No Message(s)")
    } else {
      let $header = $("div.project-messages"); 
      $header.html("Message(s):")
      let $ul = $("#messages")
      messages.forEach(message => {
        let newMessage = new Message(message)
        let messageHtml = newMessage.formatMessages() 
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

Message.prototype.formatMessages = function() {
  let messageHtml = `
  <li><a href='/messages/${this.id}'><strong><u>${this.title}:</strong></u> ${this.content}</a></li>`
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
$.ajax({
  url: `/projects/${id}/messages.json`,
  type: "POST",
  contentType: 'application/json; charset=utf-8',
  dataType: "json",
  async: false
})
.success(function(response){
  const newMessage = new Message(response)
  let messageHtml = newMessage.formatMessages(); 

  $(".messages").append(messageHtml)
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
        console.log(newTask)
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
  $.ajax({
    url: `/projects/${id}/tasks.json`,
    type: "POST", 
    contentType: 'application/json; charset=utf-8',
    dataType: "json", 
    async: false
  })
  .success(function(response){
    const newTask = new Task(response)
    let taskHtml = newTask.formatTask(); 

    $(".tasks").append(taskHtml)
  })
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
    $('.project-tags').html(newProject.formatTags())
    console.log(newProject) 
    $('.project-messages').html(newProject.formatNestedMessages())
    $('.project-tasks').html(newProject.tasks)
  });
}

function Project(project){
  this.id = project.id
  this.title = project.title 
  this.description = project.description
  this.tags = project.tags
  this.messages = project.messages 
  this.tasks = project.tasks
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
    messagesArray.push(`
    <li><a href='/messages/${this.id}'><strong><u>${this.title}:</strong></u> ${this.content}</a></li>`)
  })
  return messagesArray.join('')
  console.log(messagesArray)
}

//create new Project prototype, add all the attributes, and then render the new attribute for each new project
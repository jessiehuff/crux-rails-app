$(document).ready(function(){
  attachProjectListeners(); 
});

function attachProjectListeners() {
  $('a.load-messages').on('click', function(e){
    $(this).hide();
    e.preventDefault(); 
    loadMessages(this); 
  });
  $('a.load-tasks').on('click', function(e){
    $(this).hide(); 
    e.preventDefault();
    loadTasks(this); 
  });
}

function loadMessages(element){
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: element.href
  })
  .success(function(data){
    let messages = data.messages 
    if (messages.length === 0){
      let $header = $("div.project-messages strong"); 
      $header.html("No Message(s)")
    } else {
      let $header = $("div.project-messages strong"); 
      $header.html("Message(s):")
      let $ul = $("div.project-messages ul")
      messages.forEach(message => {
        let newMessage = new Message(message)
        let messageHtml = newMessage.formatMessage() 

        $ul.append(messageHtml)
      });
    }
  });
}

function Message(message) {
  this.title = message.title 
  this.content = message.content 
  this.id = message.id
}

Message.prototype.formatMessage = function() {
  let messageHtml = `
  <li><a href='/messages/${this.id}'>${this.title}</a></li>`
  return messageHtml; 
}

function loadTasks(element) {
  $.ajax({
    method: "GET", 
    dataType: "json", 
    url: element.href 
  })
  .success(function(data){
    let tasks = data.tasks 
    if (tasks.length === 0) {
      let $header = $("div.project-tasks strong");
      $header.html("No Task(s)")
      let $ul = $("div.project-tasks ul")
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
  let taskHtml = `<li><a href='/tasks/${this.id}'>${this.title}</a></li>`
  return taskHtml;
}
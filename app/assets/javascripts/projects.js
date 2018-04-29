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
  <li><a href='/messages/${this.id}'>${this.name}</a></li>`
  return messageHtml; 
}
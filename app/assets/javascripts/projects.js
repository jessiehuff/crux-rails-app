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


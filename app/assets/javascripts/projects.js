$(function(){
  $(".project").on('click, '.js-more', function(event) {
    var id = this.dataset.id;

    $.get("/projects/" + id + ".json", function(data) {
      $("#description-" + id).text(data.description); 
    })
    event.preventDefault();
  })
});
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
  var startDeleteButton = document.getElementById("start-delete-button");
  if (startDeleteButton) {
    startDeleteButton.addEventListener("click", function(event) {
      event.preventDefault();
      var el = document.getElementById("remove-all-songs");
      var on = document.getElementById("delete-on");
      var off = document.getElementById("delete-off");
      el.style.display = (el.style.display == "none") ? "block" : "none";
      on.style.display = (on.style.display == "none") ? "block" : "none";
      off.style.display = (off.style.display == "none") ? "block" : "none";
    });
  }
});

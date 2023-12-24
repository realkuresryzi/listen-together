// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function hideNotice() {
  var noticeElement = document.getElementById('notice');
  if (noticeElement) {
    noticeElement.style.display = 'none';
  }
}

setTimeout(hideNotice, 5000);

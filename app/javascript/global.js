// Hiding the notifications after a while

document.addEventListener("turbolinks:load", function() {

  var notification = document.querySelector('.global-notification');

  if(notification) {
    window.setTimeout(function() {
      notification.style.display = "none";
    }, 4000);
  }

});

document.addEventListener('DOMContentLoaded', () => {
  // Get all "navbar-burger" elements
  const burgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  if (burgers.length > 0) {
    burgers.forEach(el => {
      el.addEventListener('click', () => {
        const targetId = el.dataset.target;
        const target = document.getElementById(targetId);

        el.classList.toggle('is-active');
        target.classList.toggle('is-active');
      });
    });
  }
});

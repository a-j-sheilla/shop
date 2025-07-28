import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

console.log("Application JavaScript loaded");

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".global-notification").forEach(msg => {
    setTimeout(() => {
      msg.style.transition = "opacity 1s ease-out";
      msg.style.opacity = 0;
      setTimeout(() => msg.remove(), 4000);
    }, 100);
  });
});

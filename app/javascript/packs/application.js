console.log("Application JavaScript loaded");

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".flash-message").forEach(msg => {
    setTimeout(() => {
      msg.style.transition = "opacity 1s ease-out";
      msg.style.opacity = 0;
      setTimeout(() => msg.remove(), 100);
    }, 100);
  });
});

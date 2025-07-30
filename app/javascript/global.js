/**
 * Global JavaScript Functionality
 *
 * Contains JavaScript code that applies to the entire application.
 * Handles global UI interactions and behaviors that are used across
 * multiple pages and components.
 *
 * Key Features:
 * - Auto-hiding flash notifications
 * - Mobile navigation menu toggle (Bulma navbar burger)
 * - Global event listeners and utilities
 *
 * Dependencies:
 * - Turbolinks (for turbolinks:load event)
 * - Bulma CSS framework (for navbar styling classes)
 */

// === FLASH NOTIFICATION AUTO-HIDE ===

/**
 * Automatically hide flash notifications after a delay
 *
 * Listens for Turbolinks page loads and sets up auto-hide functionality
 * for global notification messages (success, error, alert, notice).
 *
 * Behavior:
 * - Finds elements with 'global-notification' class
 * - Hides them after 4 seconds (4000ms)
 * - Works with Turbolinks navigation
 *
 * CSS Classes Expected:
 * - .global-notification (applied to notification containers)
 */
document.addEventListener("turbolinks:load", function() {

  // Find the global notification element
  var notification = document.querySelector('.global-notification');

  // If notification exists, set up auto-hide timer
  if(notification) {
    window.setTimeout(function() {
      notification.style.display = "none";
    }, 4000); // Hide after 4 seconds
  }

});

// === MOBILE NAVIGATION MENU ===

/**
 * Handle mobile navigation menu toggle functionality
 *
 * Implements the Bulma CSS framework's navbar burger menu behavior
 * for responsive navigation on mobile devices.
 *
 * Behavior:
 * - Toggles 'is-active' class on burger button when clicked
 * - Toggles 'is-active' class on target menu to show/hide
 * - Supports multiple burger menus on the same page
 *
 * HTML Structure Expected:
 * <div class="navbar-burger burger" data-target="navbar">
 *   <span></span>
 *   <span></span>
 *   <span></span>
 * </div>
 * <div id="navbar" class="navbar-menu">
 *   <!-- menu content -->
 * </div>
 *
 * CSS Classes Used:
 * - .navbar-burger (burger button selector)
 * - .is-active (toggle class for active state)
 */
document.addEventListener('DOMContentLoaded', () => {

  // Get all navbar burger elements and convert to array
  const burgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  // If burger menus exist, set up click handlers
  if (burgers.length > 0) {
    burgers.forEach(el => {
      el.addEventListener('click', () => {
        // Get the target menu ID from data-target attribute
        const targetId = el.dataset.target;
        const target = document.getElementById(targetId);

        // Toggle active state on both burger and menu
        el.classList.toggle('is-active');
        target.classList.toggle('is-active');
      });
    });
  }
});

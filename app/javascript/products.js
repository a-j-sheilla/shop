/**
 * Product-Specific JavaScript Functionality
 *
 * Handles JavaScript interactions specific to product management,
 * including image upload previews and product form enhancements.
 *
 * Key Features:
 * - Image upload preview functionality
 * - File validation for image uploads
 * - Dynamic thumbnail generation
 *
 * Dependencies:
 * - Turbolinks (for turbolinks:load event)
 * - FileReader API (for image preview)
 * - HTML5 File API (for file handling)
 */

// === PRODUCT IMAGE UPLOAD PREVIEW ===

/**
 * Initialize product-related functionality when page loads
 *
 * Uses Turbolinks event to ensure functionality works with
 * Turbolinks navigation and page caching.
 */
document.addEventListener("turbolinks:load", function() {

  // Find the product image upload input element
  var productImage = document.querySelector('.product-image');

  /**
   * Handle file selection for image upload preview
   *
   * Creates thumbnail previews of selected image files before upload.
   * Validates that only image files are processed and displays them
   * as preview thumbnails for user feedback.
   *
   * @param {Event} evt - File input change event
   *
   * Process:
   * 1. Get selected files from input
   * 2. Loop through each file
   * 3. Validate file is an image
   * 4. Read file as data URL
   * 5. Create and display thumbnail preview
   *
   * HTML Structure Expected:
   * <input type="file" class="product-image" />
   * <div id="list"></div> <!-- Preview container -->
   */
  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object containing selected files

    // Loop through all selected files and process each one
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files - skip non-image files
      if (!f.type.match('image.*')) {
        continue;
      }

      // Create FileReader to read the image file
      var reader = new FileReader();

      // Set up onload handler using closure to capture file info
      // Closure is needed to maintain reference to the current file
      reader.onload = (function(theFile) {
        return function(e) {
          // Create thumbnail preview element
          var span = document.createElement('span');
          span.innerHTML = [
            '<img class="product-preview-thumb" src="', e.target.result,
            '" title="', escape(theFile.name), '"/>'
          ].join('');

          // Insert the thumbnail into the preview container
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);

      // Read the image file as a data URL for preview
      reader.readAsDataURL(f);
    }
  }

  // Attach file selection handler if product image input exists
  if (productImage) {
    productImage.addEventListener('change', handleFileSelect, false);
  }

});
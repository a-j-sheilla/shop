/**
 * Application JavaScript Entry Point
 *
 * Main JavaScript file for the Shop e-commerce application.
 * This file is the entry point for all JavaScript functionality and
 * is processed by Webpacker for bundling and optimization.
 *
 * Key Responsibilities:
 * - Initialize Rails UJS for AJAX functionality
 * - Start Turbolinks for faster page navigation
 * - Enable Active Storage for file uploads
 * - Import and initialize application-specific modules
 *
 * File Location: app/javascript/packs/application.js
 * Processed by: Webpacker
 * Output: public/packs/js/application-[hash].js
 */

// === RAILS FRAMEWORK IMPORTS ===

// Rails UJS - Provides AJAX functionality for Rails forms and links
// Handles data-method, data-confirm, data-remote attributes
import Rails from "@rails/ujs"

// Turbolinks - Speeds up navigation by replacing page content via AJAX
// Maintains JavaScript state between page transitions
import Turbolinks from "turbolinks"

// Active Storage - Handles file uploads with progress tracking
// Provides direct upload functionality to cloud storage
import * as ActiveStorage from "@rails/activestorage"

// === APPLICATION MODULE IMPORTS ===

// Action Cable channels for real-time WebSocket functionality
// Currently includes consumer setup for potential real-time features
import "../channels"

// Global JavaScript functionality used across the entire application
// Contains utility functions and application-wide event handlers
import "../global"

// Product-specific JavaScript functionality
// Handles product display, interactions, and cart operations
import "../products"

// === FRAMEWORK INITIALIZATION ===

// Initialize Rails UJS to enable AJAX functionality
// This must be called before any Rails AJAX features work
Rails.start()

// Start Turbolinks for faster page navigation
// Intercepts link clicks and form submissions for AJAX page loading
Turbolinks.start()

// Initialize Active Storage for file upload functionality
// Enables direct uploads and progress tracking for file inputs
ActiveStorage.start()


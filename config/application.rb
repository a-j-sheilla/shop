# Application Configuration
#
# Main configuration file for the Shop e-commerce Rails application.
# This file is loaded during Rails initialization and sets up the
# application-wide configuration and behavior.
#
# Key responsibilities:
# - Load Rails framework components
# - Configure application-wide settings
# - Set up gem dependencies
# - Define the application module and class
#

# Load the Rails boot process (sets up Bundler and load paths)
require_relative "boot"

# Load all Rails framework components
# This includes ActionController, ActiveRecord, ActionView, etc.
require "rails/all"

# Require all gems listed in Gemfile based on the current environment
# Loads gems for all groups plus environment-specific groups
# (e.g., :development, :test, :production)
Bundler.require(*Rails.groups)

# Shop Application Module
# Defines the main application namespace and configuration
module Shop
  # Main Application Class
  # Inherits from Rails::Application and configures the entire application
  class Application < Rails::Application

    # === RAILS VERSION CONFIGURATION ===

    # Initialize configuration defaults for Rails 6.1
    # This ensures the application uses Rails 6.1 defaults for:
    # - Security settings
    # - Performance optimizations
    # - Framework behavior
    config.load_defaults 6.1

    # === CUSTOM CONFIGURATION ===

    # Application-specific configuration goes here.
    # These settings can be overridden in environment-specific files
    # located in config/environments/ (development.rb, production.rb, test.rb)

    # Example configurations (commented out):

    # Set application time zone
    # config.time_zone = "Central Time (US & Canada)"

    # Add additional load paths for custom libraries
    # config.eager_load_paths << Rails.root.join("extras")

    # Configure autoload paths for custom modules
    # config.autoload_paths << Rails.root.join("lib")

    # Set default locale for internationalization
    # config.i18n.default_locale = :en

    # Configure asset pipeline settings
    # config.assets.precompile += %w( admin.js admin.css )

    # Configure Active Job queue adapter
    # config.active_job.queue_adapter = :sidekiq

    # Configure Action Mailer settings
    # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  end
end

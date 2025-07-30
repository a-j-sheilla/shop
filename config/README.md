# Config Directory

This directory contains all configuration files for the Rails application, including environment settings, routes, database configuration, and initializers.

## 📁 Core Configuration Files

### `application.rb`
Main application configuration file that:
- Sets up the Rails application class
- Configures application-wide settings
- Loads gems and dependencies
- Defines the application module (`Shop`)

### `routes.rb`
Defines all URL routes and maps them to controller actions:
- Product routes (CRUD operations)
- Cart management routes
- User authentication routes (Devise)
- Custom route aliases (shop, root)

### `database.yml`
Database configuration for different environments:
- Development: SQLite3 database
- Test: Separate SQLite3 database
- Production: Configurable for PostgreSQL/MySQL

### `environment.rb`
Loads the Rails application and all dependencies.

### `boot.rb`
Sets up Bundler and loads gems before Rails initialization.

## 📁 Environment-Specific Settings (`environments/`)

### `development.rb`
Development environment configuration:
- Detailed error pages
- Asset debugging enabled
- Live reloading
- Caching disabled for development

### `production.rb`
Production environment configuration:
- Error logging
- Asset compilation and caching
- Performance optimizations
- Security settings

### `test.rb`
Test environment configuration:
- Fast test execution
- Simplified logging
- Test-specific settings

## 📁 Initializers (`initializers/`)

Contains files that run during application startup to configure gems and libraries:

### `devise.rb`
Devise authentication gem configuration:
- Authentication strategies
- Password requirements
- Session management
- Email settings

### `assets.rb`
Asset pipeline configuration:
- Asset paths
- Precompilation settings
- Version management

### `filter_parameter_logging.rb`
Configures parameter filtering for security (passwords, tokens).

### `inflections.rb`
Custom pluralization and singularization rules.

### `mime_types.rb`
Custom MIME type definitions.

### `wrap_parameters.rb`
Parameter wrapping configuration for JSON requests.

## 📁 Other Configuration Files

### `cable.yml`
Action Cable configuration for WebSocket connections:
- Development: Async adapter
- Production: Redis adapter (configurable)

### `credentials.yml.enc`
Encrypted credentials file containing:
- Secret keys
- API tokens
- Database passwords
- Other sensitive configuration

### `master.key`
Key file for decrypting credentials (not committed to version control).

### `storage.yml`
Active Storage configuration for file uploads:
- Local storage for development
- Cloud storage options for production

### `puma.rb`
Puma web server configuration:
- Port settings
- Worker processes
- Thread configuration
- Environment-specific settings

### `spring.rb`
Spring application preloader configuration for faster development.

## 📁 Webpack Configuration (`webpack/`)

### `environment.js`
Webpacker environment configuration.

### `development.js`
Development-specific webpack settings.

### `production.js`
Production webpack optimization settings.

### `test.js`
Test environment webpack configuration.

## 📁 Locale Files (`locales/`)

### `en.yml`
English language translations and text:
- Default Rails messages
- Custom application text
- Form labels and error messages

## 🔧 Key Configuration Highlights

### Security
- Parameter filtering for sensitive data
- Encrypted credentials storage
- CSRF protection enabled
- Secure session configuration

### Performance
- Asset compilation and caching
- Database connection pooling
- Webpacker optimization
- Gzip compression in production

### Development Tools
- Better error pages
- Live reloading
- Asset debugging
- Detailed logging

### Authentication (Devise)
- Email/password authentication
- Remember me functionality
- Password reset capabilities
- Registration customization

## 🌍 Environment Variables

The application uses environment variables for:
- Database URLs
- Secret keys
- API credentials
- Feature flags

Set these in:
- `.env` files (development)
- Server environment (production)
- Rails credentials (encrypted)

## 🔄 Configuration Loading Order

1. `boot.rb` - Bundler setup
2. `application.rb` - Main app configuration
3. Environment-specific file (`development.rb`, etc.)
4. Initializers (alphabetical order)
5. `environment.rb` - Final loading

## 📝 Best Practices

### Security
- Never commit `master.key` to version control
- Use encrypted credentials for sensitive data
- Filter sensitive parameters in logs
- Use environment variables for configuration

### Organization
- Keep environment-specific settings in appropriate files
- Use initializers for gem configuration
- Group related settings together
- Comment complex configurations

### Performance
- Optimize asset compilation for production
- Configure appropriate caching strategies
- Set up proper database connection pooling
- Use CDN for static assets in production

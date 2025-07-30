# App Directory

This directory contains the core application code following the Model-View-Controller (MVC) architecture pattern.

## 📁 Directory Structure

### Controllers (`controllers/`)
Contains all application controllers that handle HTTP requests and coordinate between models and views.

**Key Controllers:**
- `application_controller.rb` - Base controller with shared functionality
- `products_controller.rb` - Handles product CRUD operations
- `carts_controller.rb` - Manages shopping cart functionality
- `registrations_controller.rb` - Custom Devise registration handling

### Models (`models/`)
Contains Active Record models that represent data and business logic.

**Core Models:**
- `product.rb` - Product listings with validations and associations
- `cart.rb` - Shopping cart with item management
- `cart_item.rb` - Individual items within a cart
- `user.rb` - User authentication and product ownership

**Concerns:**
- `current_cart.rb` - Session-based cart management logic

### Views (`views/`)
Contains ERB templates for rendering HTML responses.

**View Directories:**
- `layouts/` - Application-wide layout templates
- `products/` - Product listing, show, and form views
- `carts/` - Shopping cart display and management
- `devise/` - User authentication views (registration, login)

### Helpers (`helpers/`)
Contains helper methods to assist views with formatting and logic.

**Helper Files:**
- `application_helper.rb` - Global helper methods
- `products_helper.rb` - Product-specific helpers (author display, permissions)

### JavaScript (`javascript/`)
Contains JavaScript files organized with Webpacker.

**Structure:**
- `packs/` - Entry points for JavaScript bundles
- `channels/` - Action Cable WebSocket channels
- Individual feature files for specific functionality

### Assets (`assets/`)
Contains static assets like images and stylesheets.

**Subdirectories:**
- `images/` - Application images and icons
- `stylesheets/` - SCSS/CSS files (though Bulma is used via CDN)

### Other Directories

#### Channels (`channels/`)
Action Cable channels for real-time features (WebSocket connections).

#### Jobs (`jobs/`)
Background job classes for asynchronous processing.

#### Mailers (`mailers/`)
Email handling classes for sending notifications.

#### Uploaders (`uploaders/`)
CarrierWave uploaders for file handling (product images).

## 🔄 Request Flow

1. **Route** → Determines which controller action to call
2. **Controller** → Processes request, interacts with models
3. **Model** → Handles data operations and business logic
4. **View** → Renders HTML response using data from controller
5. **Helper** → Assists view with formatting and utility methods

## 🎯 Key Features Implemented

### Authentication & Authorization
- User registration and login with Devise
- Product ownership validation
- Permission-based edit/delete controls

### Shopping Cart System
- Session-based cart persistence
- Add/remove items functionality
- Quantity management
- Total price calculations

### Product Management
- CRUD operations for products
- Image upload with CarrierWave
- Form validation and error handling
- Owner-only edit permissions

### User Interface
- Responsive design with Bulma CSS
- Flash message notifications
- Dynamic cart counter updates
- Professional styling and icons

## 🧪 Testing

Each component should have corresponding tests:
- **Models**: Unit tests for validations, associations, methods
- **Controllers**: Integration tests for actions and responses
- **Helpers**: Unit tests for helper methods
- **Views**: Feature tests for user interactions

## 📝 Conventions

### Naming
- Controllers: PascalCase with "Controller" suffix
- Models: PascalCase, singular
- Views: snake_case, match controller actions
- Helpers: snake_case with "_helper" suffix

### Organization
- Keep controllers thin, models fat
- Use concerns for shared functionality
- Helpers for view-specific logic only
- Partials for reusable view components

## 🔧 Configuration

Application-specific configurations are handled in:
- `config/application.rb` - Global app settings
- `config/environments/` - Environment-specific settings
- `config/initializers/` - Gem and library configurations

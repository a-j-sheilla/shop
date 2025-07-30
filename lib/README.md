# Lib Directory

This directory contains library code, custom tasks, templates, and additional assets that extend the Rails application functionality.

## 📁 Directory Structure

### `assets/`
Contains additional assets that are not part of the main app/assets pipeline:
- Custom stylesheets that don't belong in app/assets
- Third-party assets
- Library-specific assets

### `tasks/`
Contains custom Rake tasks for application maintenance and automation:
- Database maintenance tasks
- Deployment scripts
- Data migration utilities
- Custom administrative tasks

**Common Task Examples:**
```ruby
# lib/tasks/maintenance.rake
namespace :maintenance do
  desc "Clean up old cart sessions"
  task cleanup_carts: :environment do
    Cart.where('created_at < ?', 30.days.ago).destroy_all
  end
end
```

### `templates/`
Contains custom templates for Rails generators:

#### `erb/`
Custom ERB templates for scaffolding and generators:
- Customized view templates
- Form templates
- Layout templates

**Usage:**
- Override default Rails generator templates
- Maintain consistent styling across generated views
- Include application-specific markup patterns

## 🔧 Custom Extensions

### Application Libraries
Place custom Ruby classes and modules that:
- Don't fit into the MVC pattern
- Provide utility functions
- Extend third-party gems
- Implement business logic that spans multiple models

**Example Structure:**
```
lib/
├── shop/
│   ├── cart_calculator.rb
│   ├── price_formatter.rb
│   └── inventory_manager.rb
└── extensions/
    ├── string_extensions.rb
    └── numeric_extensions.rb
```

### Service Objects
Consider placing service objects in lib/ for:
- Complex business logic
- Third-party API integrations
- Multi-step operations
- Cross-cutting concerns

## 🛠 Rake Tasks

### Creating Custom Tasks
```bash
# Generate new task file
rails generate task maintenance cleanup_carts
```

### Common Task Categories

#### Database Tasks
- Data cleanup and maintenance
- Migration utilities
- Backup and restore operations
- Data validation and integrity checks

#### Deployment Tasks
- Asset precompilation
- Cache warming
- Health checks
- Environment setup

#### Administrative Tasks
- User management
- Report generation
- System monitoring
- Performance analysis

### Running Tasks
```bash
# List all available tasks
rake -T

# Run specific task
rake maintenance:cleanup_carts

# Run with environment
RAILS_ENV=production rake maintenance:cleanup_carts
```

## 📝 Templates and Generators

### Custom Templates
Override default Rails templates to:
- Match application styling
- Include standard form elements
- Add consistent navigation
- Include required JavaScript/CSS

### Generator Customization
```bash
# Generate custom template
rails generate controller Products --template-engine=erb
```

### Template Locations
- `lib/templates/erb/controller/` - Controller view templates
- `lib/templates/erb/scaffold/` - Scaffold templates
- `lib/templates/rails/` - Rails generator templates

## 🔄 Autoloading

### Rails Autoloading
Files in lib/ are not automatically loaded by Rails. To include them:

#### Option 1: Explicit Require
```ruby
# In application.rb or initializer
require Rails.root.join('lib', 'shop', 'cart_calculator')
```

#### Option 2: Add to Autoload Paths
```ruby
# In config/application.rb
config.autoload_paths << Rails.root.join('lib')
```

#### Option 3: Eager Loading
```ruby
# In config/application.rb
config.eager_load_paths << Rails.root.join('lib')
```

## 🧪 Testing Library Code

### Test Organization
```
test/
├── lib/
│   ├── shop/
│   │   └── cart_calculator_test.rb
│   └── extensions/
│       └── string_extensions_test.rb
```

### Testing Best Practices
- Unit test all library code
- Mock external dependencies
- Test edge cases and error conditions
- Maintain high test coverage

## 📚 Common Use Cases

### Utility Classes
```ruby
# lib/shop/price_formatter.rb
module Shop
  class PriceFormatter
    def self.format_currency(amount)
      "$#{sprintf('%.2f', amount)}"
    end
  end
end
```

### Service Objects
```ruby
# lib/shop/cart_calculator.rb
module Shop
  class CartCalculator
    def initialize(cart)
      @cart = cart
    end

    def total_with_tax(tax_rate = 0.08)
      subtotal = @cart.total_price
      subtotal + (subtotal * tax_rate)
    end
  end
end
```

### Extensions
```ruby
# lib/extensions/string_extensions.rb
class String
  def to_currency
    "$#{self}"
  end
end
```

## 🔒 Security Considerations

### Code Organization
- Keep sensitive logic in appropriate locations
- Don't expose internal APIs publicly
- Validate inputs in library methods
- Handle errors gracefully

### Access Control
- Library code should respect application permissions
- Don't bypass model validations
- Maintain audit trails for administrative tasks

## 📈 Performance

### Optimization Tips
- Lazy load heavy dependencies
- Cache expensive calculations
- Use database queries efficiently
- Profile and benchmark custom code

### Memory Management
- Avoid memory leaks in long-running tasks
- Clean up resources properly
- Use appropriate data structures
- Monitor memory usage in production

## 🔧 Maintenance

### Code Quality
- Follow Rails conventions
- Write comprehensive tests
- Document complex algorithms
- Use consistent naming patterns

### Refactoring
- Extract common patterns into libraries
- Remove duplicate code
- Simplify complex methods
- Improve error handling

### Monitoring
- Log important operations
- Track performance metrics
- Monitor error rates
- Set up alerts for failures

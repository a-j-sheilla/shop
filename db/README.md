# Database Directory

This directory contains all database-related files including migrations, schema, seeds, and the SQLite database files.

## 📁 Directory Structure

### `migrate/`
Contains database migration files that define changes to the database schema over time.

**Migration Files:**
- `*_devise_create_users.rb` - Creates users table with Devise authentication
- `*_create_products.rb` - Creates products table with all product attributes
- `*_create_carts.rb` - Creates carts table for shopping cart functionality
- `*_create_cart_items.rb` - Creates cart_items table linking carts and products

### `schema.rb`
Auto-generated file that represents the current state of the database schema.
- **DO NOT EDIT MANUALLY** - This file is automatically updated by Rails
- Contains all table definitions, indexes, and constraints
- Used for setting up new database instances

### `seeds.rb`
Contains sample data for populating the database during development and testing.

**Seeded Data:**
- Sample user account (user@example.com / password)
- Sample products with various categories
- Demonstrates proper data relationships

## 🗄️ Database Schema

### Users Table
Stores user authentication and profile information:
```sql
- id (primary key)
- email (unique, not null)
- encrypted_password (not null)
- name (user's display name)
- reset_password_token
- reset_password_sent_at
- remember_created_at
- created_at, updated_at
```

### Products Table
Stores product listings and details:
```sql
- id (primary key)
- brand (product brand)
- model (product model)
- description (detailed description)
- condition (New, Used, etc.)
- finish (color/finish)
- title (product title)
- price (decimal)
- image (uploaded image path)
- user_id (foreign key to users)
- created_at, updated_at
```

### Carts Table
Stores shopping cart instances:
```sql
- id (primary key)
- created_at, updated_at
```

### Cart Items Table
Links products to carts with quantities:
```sql
- id (primary key)
- cart_id (foreign key to carts)
- product_id (foreign key to products)
- quantity (integer, default: 1)
- created_at, updated_at
```

## 🔄 Migration Management

### Running Migrations
```bash
# Run all pending migrations
rails db:migrate

# Rollback last migration
rails db:rollback

# Rollback specific number of migrations
rails db:rollback STEP=3

# Reset database (drop, create, migrate)
rails db:reset

# Setup database (create, migrate, seed)
rails db:setup
```

### Creating Migrations
```bash
# Create new migration
rails generate migration MigrationName

# Create model with migration
rails generate model ModelName attribute:type

# Add column to existing table
rails generate migration AddColumnToTable column:type

# Remove column from table
rails generate migration RemoveColumnFromTable column:type
```

## 🌱 Database Seeding

### Running Seeds
```bash
# Load seed data
rails db:seed

# Reset and seed
rails db:reset
```

### Seed Data Includes
- **Test User**: Email: user@example.com, Password: password
- **Sample Products**: Various watches and electronics
- **Proper Associations**: Products linked to users

## 🔍 Database Relationships

### User → Products (One-to-Many)
- Users can create multiple products
- Products belong to a single user
- Cascade delete: User deletion removes their products

### Cart → Cart Items (One-to-Many)
- Carts contain multiple cart items
- Cart items belong to a single cart
- Cascade delete: Cart deletion removes all items

### Product → Cart Items (One-to-Many)
- Products can be in multiple carts
- Cart items reference a single product
- Protected delete: Products with cart items cannot be deleted

### Cart Items → Product & Cart (Many-to-One)
- Cart items link carts and products
- Includes quantity for each product in cart

## 🔒 Data Integrity

### Constraints
- Foreign key constraints ensure referential integrity
- Unique constraints on user emails
- Not null constraints on required fields

### Validations
- Model-level validations in addition to database constraints
- Price format validation
- Description length limits
- Required field validation

### Indexes
- Primary keys automatically indexed
- Foreign keys indexed for performance
- Email field indexed for authentication queries

## 🧪 Database Testing

### Test Database
- Separate SQLite database for testing
- Automatically reset between test runs
- Uses same schema as development

### Fixtures vs Factories
- Can use Rails fixtures for simple test data
- Consider FactoryBot for complex test scenarios
- Seed data available for manual testing

## 🔧 Database Configuration

### Development
- SQLite3 database stored in `db/development.sqlite3`
- Simple file-based database for easy development
- No additional setup required

### Production
- Configurable for PostgreSQL, MySQL, or other databases
- Environment variables for connection settings
- Connection pooling and optimization settings

### Backup and Maintenance
```bash
# Backup SQLite database
cp db/production.sqlite3 db/backup_$(date +%Y%m%d).sqlite3

# Database console
rails db

# Check database status
rails db:version
```

## 📊 Performance Considerations

### Indexing Strategy
- Primary keys automatically indexed
- Foreign keys indexed for join performance
- Consider adding indexes for frequently queried columns

### Query Optimization
- Use includes() to avoid N+1 queries
- Select only needed columns with select()
- Use database-level constraints when possible

### Scaling Considerations
- SQLite suitable for development and small applications
- Consider PostgreSQL or MySQL for production
- Implement database connection pooling
- Monitor query performance and add indexes as needed

## 🚨 Important Notes

### Schema.rb
- Never edit `schema.rb` directly
- Always use migrations to change database structure
- Commit `schema.rb` changes to version control

### Migration Best Practices
- Write reversible migrations when possible
- Test migrations on copy of production data
- Use appropriate column types and constraints
- Add indexes for foreign keys and frequently queried columns

### Data Safety
- Always backup before running migrations in production
- Test migrations in staging environment first
- Use transactions for complex data migrations
- Consider maintenance windows for large schema changes

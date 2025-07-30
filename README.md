# Shop - E-Commerce Application

A modern e-commerce web application built with Ruby on Rails, featuring user authentication, product management, and a complete shopping cart system.

## 🚀 Features

### Core Functionality
- **User Authentication**: Secure user registration and login with Devise
- **Product Management**: Create, read, update, and delete products
- **Shopping Cart**: Full-featured cart with add/remove items and quantity management
- **Session Persistence**: Cart persists across login/logout sessions
- **User Permissions**: Only product owners can edit/delete their listings

### User Interface
- **Modern Design**: Professional UI built with Bulma CSS framework
- **Responsive Layout**: Works seamlessly on desktop and mobile devices
- **Font Awesome Icons**: Enhanced visual experience with professional icons
- **Flash Messages**: Real-time feedback for user actions
- **Dynamic Cart Counter**: Live updates of cart item count in navigation

### Technical Features
- **Image Upload**: Product images with CarrierWave and MiniMagick
- **Form Validation**: Comprehensive validation for all user inputs
- **Database Integrity**: Foreign key constraints and proper associations
- **Security**: Protected routes and secure parameter handling

## 🛠 Technology Stack

- **Backend**: Ruby 3.0.0, Rails 6.1.1
- **Database**: SQLite3 (development), easily configurable for PostgreSQL/MySQL
- **Frontend**: HTML5, CSS3 (Bulma), JavaScript (ES6+)
- **Authentication**: Devise gem
- **File Upload**: CarrierWave with MiniMagick
- **Asset Pipeline**: Webpacker for JavaScript bundling
- **Styling**: Bulma CSS framework with Font Awesome icons

## 📋 Prerequisites

Before running this application, make sure you have:

- Ruby 3.0.0 or higher
- Rails 6.1.1 or higher
- SQLite3
- Node.js and Yarn (for JavaScript dependencies)
- ImageMagick (for image processing)

## 🚀 Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd shop
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Install JavaScript dependencies**
   ```bash
   yarn install
   ```

4. **Setup the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Start the development servers**
   ```bash
   # Terminal 1: Rails server
   rails server
   
   # Terminal 2: Webpack dev server (for JavaScript)
   bin/webpack-dev-server
   ```

6. **Visit the application**
   Open your browser and navigate to `http://localhost:3000`

## 📖 Usage

### Getting Started
1. **Register**: Create a new account or use the seeded user (user@example.com / password)
2. **Browse Products**: View available products on the shop page
3. **Add to Cart**: Click "Add to Cart" on any product
4. **Manage Cart**: View cart, update quantities, or remove items
5. **Create Products**: Logged-in users can create their own product listings

### User Roles
- **Visitors**: Can browse products and use the cart
- **Registered Users**: Can create, edit, and delete their own products
- **Product Owners**: Full control over their product listings

## 🏗 Project Structure

```
shop/
├── app/
│   ├── controllers/     # Application controllers
│   ├── models/         # Data models and business logic
│   ├── views/          # HTML templates
│   ├── helpers/        # View helper methods
│   ├── javascript/     # JavaScript files
│   └── assets/         # Images, stylesheets
├── config/             # Application configuration
├── db/                 # Database files and migrations
├── public/             # Static files
└── test/              # Test files
```

## 🧪 Testing

The application includes comprehensive testing:

```bash
# Run all tests
rails test

# Run specific test files
rails test test/models/
rails test test/controllers/
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file for environment-specific configurations:

```env
SECRET_KEY_BASE=your_secret_key_here
DATABASE_URL=your_database_url_here
```

### Image Upload
Configure CarrierWave settings in `config/initializers/carrierwave.rb` for different storage options (local, AWS S3, etc.).

## 📚 API Documentation

The application provides JSON API endpoints:

- `GET /products.json` - List all products
- `GET /products/:id.json` - Get specific product
- `POST /products.json` - Create new product (authenticated)
- `PUT /products/:id.json` - Update product (owner only)
- `DELETE /products/:id.json` - Delete product (owner only)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page for existing solutions
2. Create a new issue with detailed information
3. Include error messages, screenshots, and steps to reproduce

## 🎯 Roadmap

Future enhancements planned:
- [ ] Payment integration (Stripe/PayPal)
- [ ] Order management system
- [ ] Product reviews and ratings
- [ ] Advanced search and filtering
- [ ] Email notifications
- [ ] Admin dashboard
- [ ] Multi-vendor support

## 📊 Status

✅ **Production Ready** - All core features implemented and tested

---

Built with ❤️ using Ruby on Rails

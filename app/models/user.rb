# User Model
#
# Represents a user account in the e-commerce application.
# Users can register, authenticate, and create product listings.
# Authentication is handled by the Devise gem with standard modules.
#
# Database Table: users
# Primary Key: id
# Key Fields: email (unique), encrypted_password, name
#
# Key Features:
# - Email/password authentication via Devise
# - User registration and account management
# - Password reset functionality
# - Remember me functionality for persistent sessions
# - Product ownership (users can create and manage products)
# - Comprehensive validation for email format and password strength
#
# Devise Modules Enabled:
# - :database_authenticatable - Login with email/password
# - :registerable - User registration
# - :recoverable - Password reset via email
# - :rememberable - "Remember me" checkbox functionality
# - :validatable - Email and password validation
#
# Available but not enabled:
# - :confirmable - Email confirmation before account activation
# - :lockable - Account locking after failed login attempts
# - :timeoutable - Session timeout after inactivity
# - :trackable - Track sign in count, timestamps, and IP addresses
# - :omniauthable - OAuth integration (Google, Facebook, etc.)
#
class User < ApplicationRecord

  # === DEVISE CONFIGURATION ===

  # Configure Devise authentication modules
  # These modules provide the core authentication functionality
  devise :database_authenticatable,  # Enable login with email/password
         :registerable,              # Allow user registration
         :recoverable,               # Password reset functionality
         :rememberable,              # "Remember me" persistent sessions
         :validatable                # Email and password validation

  # === ASSOCIATIONS ===

  # Users can create multiple product listings
  # dependent: :destroy ensures all user's products are removed when user is deleted
  # This maintains data integrity and prevents orphaned products
  has_many :products, dependent: :destroy
end

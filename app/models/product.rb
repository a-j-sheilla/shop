# Product Model
#
# Represents a product listing in the e-commerce application.
# Products are created by users and can be added to shopping carts.
# Each product has details like title, brand, model, price, and an optional image.
#
# Database Table: products
# Primary Key: id
# Foreign Keys: user_id (references users table)
#
# Key Features:
# - User ownership (products belong to users)
# - Shopping cart integration (products can be added to carts)
# - Image upload functionality with CarrierWave
# - Comprehensive validation for all attributes
# - Protection against deletion when product is in active carts
#
class Product < ApplicationRecord

  # === ASSOCIATIONS ===

  # Each product belongs to a user (the seller/creator)
  # Optional: true allows products to exist without a user (for system/admin products)
  belongs_to :user, optional: true

  # Products can be in multiple shopping carts through cart_items
  # dependent: :destroy ensures cart items are removed when product is deleted
  has_many :cart_items, dependent: :destroy

  # === CALLBACKS ===

  # Prevent deletion of products that are currently in shopping carts
  # This maintains data integrity and prevents broken cart references
  before_destroy :not_referenced_by_any_line_item

  # === FILE UPLOADS ===

  # Enable image upload functionality using CarrierWave gem
  # Images are processed and stored according to ImageUploader configuration
  mount_uploader :image, ImageUploader

  # Serialize image data as JSON for SQLite compatibility
  # This handles the image metadata storage in the database
  serialize :image, JSON # If you use SQLite, add this line

  # === VALIDATIONS ===

  # Required fields validation - these fields must be present
  validates :title, :brand, :price, :model, presence: true

  # Length validations to prevent excessively long content
  # Description: Maximum 1000 characters for detailed product information
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed." }

  # Title: Maximum 140 characters for concise product titles
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum allowed." }

  # Price: Maximum 10 characters to handle reasonable price ranges
  validates :price, length: { maximum: 10 }, presence: true

  # === CONSTANTS ===
  # Predefined options for dropdown selections in forms
  # These can be extended as needed for additional product categories

  # Available product brands - can be expanded for different product types
  BRAND = %w{ Ferrari Opel Lenovo Fossil}

  # Available finish/color options for products
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }

  # Product condition options from best to worst
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

  private

  # === PRIVATE METHODS ===

  # Callback method to prevent deletion of products that are in active carts
  # This ensures data integrity by preventing orphaned cart items
  #
  # @return [void] Adds error and aborts deletion if cart items exist
  # @raises [ActiveRecord::RecordNotDestroyed] When deletion is prevented
  def not_referenced_by_any_line_item
    unless cart_items.empty?
      errors.add(:base, 'Cannot delete product: it is currently in one or more shopping carts')
      throw :abort
    end
  end
end

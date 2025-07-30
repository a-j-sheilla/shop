# RegistrationsController
#
# Custom Devise registrations controller that extends the default Devise functionality
# to handle additional user attributes during registration and account updates.
# This controller customizes the strong parameters to include the user's name field.
#
# Inherits from: Devise::RegistrationsController
#
# Key Customizations:
# - Allows 'name' parameter during user registration
# - Allows 'name' parameter during account updates
# - Maintains all default Devise functionality for user management
#
# Routes handled by Devise:
# - GET    /users/sign_up      => new (registration form)
# - POST   /users              => create (process registration)
# - GET    /users/edit         => edit (account settings form)
# - PATCH  /users              => update (process account updates)
# - DELETE /users              => destroy (delete account)
#
# Usage:
# This controller is automatically used by Devise when specified in routes.rb:
# devise_for :users, controllers: { registrations: 'registrations' }
#
class RegistrationsController < Devise::RegistrationsController

  private

  # === STRONG PARAMETERS ===

  # Define permitted parameters for user registration
  # Extends default Devise parameters to include the user's name
  #
  # Default Devise parameters: email, password, password_confirmation
  # Added parameters: name
  #
  # @return [ActionController::Parameters] Permitted parameters for sign up
  #
  # Called automatically by Devise during user registration process
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Define permitted parameters for account updates
  # Extends default Devise parameters to include the user's name
  # Includes current_password for security verification during updates
  #
  # Default Devise parameters: email, password, password_confirmation, current_password
  # Added parameters: name
  #
  # @return [ActionController::Parameters] Permitted parameters for account updates
  #
  # Called automatically by Devise during account update process
  # Requires current_password for sensitive changes like email or password updates
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
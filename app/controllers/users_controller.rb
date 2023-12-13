# app/controllers/users_controller.rb
class UsersController < ApplicationController
  # The create action is responsible for creating a new user
  def create
    # Create a new user instance with the parameters from the form
    user = User.new(user_params)

    # If the user is saved successfully, redirect to the login page with a success notice
    if user.save
      redirect_to login_path, notice: 'Registration successful. You can now log in.'
    else
      # If the user is not saved successfully, show an error message and render the registration form again
      flash.now[:alert] = 'Registration failed. Please check the form and try again.'
      render 'register'
    end
  end

  private

  # Strong parameters to prevent mass assignment vulnerability
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

=begin
This code is part of the UsersController in a Rails application. 
The create action is responsible for creating a new user.
 It first creates a new User instance with the parameters from the form. 
 If the user is saved successfully, it redirects to the login page with a success notice. 
 If the user is not saved successfully, it shows an error message and renders the registration form again. 
 The user_params method is a private method that uses strong parameters to prevent mass assignment vulnerability. 
 It requires the parameters to have a :user key and permits the :username, :password, and :password_confirmation keys.
=end
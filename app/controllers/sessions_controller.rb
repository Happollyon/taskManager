# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController 
    def create # This method creates a new session
      user = User.find_by(username: params[:username])
  
      if user && user.authenticate(params[:password]) # This line checks if the user exists and if the password is correct
        session[:user_id] = user.id # This line sets the session user id to the user id
        redirect_to main_path, notice: 'Login successful.' # This line redirects the user to the main page
      else
        flash.now[:alert] = 'Invalid username or password. Please try again.' # This line sets the flash alert message
        redirect_to login_path # This line redirects the user to the login page
      end
    end
    
    def destroy # This method destroys the session
      session[:user_id] = nil # This line sets the session user id to nil
      redirect_to login_path, notice: 'Logged out successfully.' # This line redirects the user to the login page
    end
  end
  
=begin
this code is part of the SessionsController in a Rails application.
The create action is responsible for creating a new session.
It first finds the user with the username from the params.
If the user exists and the password is correct, it sets the session user id to the user id and redirects to the main page.
If the user does not exist or the password is incorrect, it sets the flash alert message and redirects to the login page.
The destroy action is responsible for destroying the session.
It sets the session user id to nil and redirects to the login page.
=end
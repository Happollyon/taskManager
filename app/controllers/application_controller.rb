#app/controllers/application_controller.rb
# This is the application controller
# The application controller is the parent controller for all other controllers
# It contains methods that are used by all other controllers

class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception # This line protects against cross-site request forgery (CSRF) attacks

  helper_method :current_user # This line makes the current_user method available to the views
  
  private

  def current_user # This method finds the current user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]# This line finds the current user
  rescue ActiveRecord::RecordNotFound # This line rescues the ActiveRecord::RecordNotFound error
    session[:user_id] = nil # This line sets the session user id to nil
  end
  def logged_in? # This method checks if the user is logged in
    !!current_user # This line returns true if the user is logged in
  end
end

=begin
This code is part of the ApplicationController in a Rails application.
The current_user method finds the current user.
The logged_in? method checks if the user is logged in.
=end
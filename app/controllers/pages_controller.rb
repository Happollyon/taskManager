# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :redirect_if_logged_in, only: [:login, :home, :register] # This line redirects the user to the main page if they are logged in

  

  private

  def redirect_if_logged_in # This method redirects the user to the main page if they are logged in
    if logged_in? # This line checks if the user is logged in
      redirect_to main_path # This line redirects the user to the main page
    end
  end
end

=begin
This code is part of the PagesController in a Rails application.
The redirect_if_logged_in method redirects the user to the main page if they are logged in.
=end
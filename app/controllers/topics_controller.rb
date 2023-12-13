# app/controllers/topics_controller.rb
class TopicsController < ApplicationController # This line sets the TopicsController class to inherit from the ApplicationController class
    # Skip CSRF verification for create action
    skip_before_action :verify_authenticity_token, only: [:create]
    before_action :no_cache # This line calls the no_cache method before any action
    
    def create # This method creates a new topic
    
      @topic = Topic.new(topic_params) # This line sets the @topic variable to a new topic with the topic_params
  
      if @topic.save # This line checks if the topic was saved
        render json: { success: true,topic: { id: @topic.id } } # This line renders a json object with the success status and topic id
      else #  This line runs if the topic was not saved
        render json: { success: false } # This line renders a json object with the success status
      end
    end
    def index # This method gets all the topics for a user
        @topics = current_user.topics # This line sets the @topics variable to the topics for the current user
        render json: @topics # This line renders a json object with the topics
    end 
     def show # This method gets all the tasks for a topic
        @topic = Topic.find(params[:id]) # This line sets the @topic variable to the topic with the id from the params
        render json: @topic.tasks # This line renders a json object with the tasks for the topic
    end
    def destroy # This method destroys a topic
        @topic = Topic.find(params[:id]) # This line sets the @topic variable to the topic with the id from the params
        @topic.tasks.destroy_all # This line destroys all the tasks for the topic
        @topic.destroy # This line destroys the topic
        if @topic.destroy# This line checks if the topic was destroyed
          render json: { success: true } #  This line renders a json object with the success status
        else 
          render json: { success: false } # This line renders a json object with the success status
        end
    end
    private
    def no_cache
      response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
    def topic_params # This method sets the topic params
        params.require(:topic).permit(:topic_name, :user_id) # This line sets the topic params
      end
  end

=begin
This code is part of the TopicsController in a Rails application.
  The create action is responsible for creating a new topic.
  It first creates a new Topic instance with the parameters from the form.
  If the topic is saved successfully, it renders a json object with the success status and topic id.
  If the topic is not saved successfully, it renders a json object with the success status.
  The index action is responsible for getting all the topics for a user.
  It sets the @topics variable to the topics for the current user and renders a json object with the topics.
  The show action is responsible for getting all the tasks for a topic.
  It sets the @topic variable to the topic with the id from the params and renders a json object with the tasks for the topic.
  The destroy action is responsible for destroying a topic.
  It sets the @topic variable to the topic with the id from the params and destroys all the tasks for the topic.
  It then destroys the topic and renders a json object with the success status.
=end


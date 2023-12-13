# app/controllers.rb
class TasksController < ApplicationController # This line sets the TasksController class to inherit from the ApplicationController class
  before_action :no_cache # This line calls the no_cache method before any action
  def create # This method creates a new task
    @task = Task.new(task_params) # This line sets the @task variable to a new task with the task_params
    if @task.save # This line checks if the task was saved
      render json: { status: 'success',task: { id: @task.id } } # This line renders a json object with the status and task id
    else # This line runs if the task was not saved
      render json: { status: 'error' } # This line renders a json object with the status
    end
  end
  def destroy # This method destroys a task
    @task = Task.find(params[:id])# This line sets the @task variable to the task with the id from the params
    @task.destroy # This line destroys the task
    head :no_content # This line sends a no content status
  end

  def index # This method gets all the tasks for a topic
    @topic = Topic.find(params[:topic_id]) # This line sets the @topic variable to the topic with the id from the params
    render json: @topic.tasks # This line renders a json object with the tasks for the topic
  end

  def toggle # This method toggles the completed status of a task
    @task = Task.find(params[:id]) # This line sets the @task variable to the task with the id from the params
    @task.update(completed: !@task.completed) # This line updates the completed status of the task
    render json: @task # This line renders a json object with the task
  end
  private
  def no_cache
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  def task_params # This method sets the task params
    params.require(:task).permit(:topic_id, :task_name, :completed) # This line sets the task params
  end
end
=begin
This code is part of the TasksController in a Rails application.
The create action is responsible for creating a new task.
It first creates a new Task instance with the parameters from the form.
If the task is saved successfully, it renders a json object with the status and task id.
If the task is not saved successfully, it renders a json object with the status.
The destroy action is responsible for destroying a task.
It sets the @task variable to the task with the id from the params and destroys the task.
It then sends a no content status.
The index action is responsible for getting all the tasks for a topic.
It sets the @topic variable to the topic with the id from the params and renders a json object with the tasks for the topic.
The toggle action is responsible for toggling the completed status of a task.
It sets the @task variable to the task with the id from the params and updates the completed status of the task.
It then renders a json object with the task.
=end
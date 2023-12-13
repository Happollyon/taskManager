# app/models/task.rb
class Task < ApplicationRecord
  belongs_to :topic
end

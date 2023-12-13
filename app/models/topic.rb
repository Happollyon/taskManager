# app/models/topic.rb
class Topic < ApplicationRecord
  belongs_to :user
  has_many :tasks
end

# app/models/user.rb
class User < ApplicationRecord
    has_secure_password
    has_many :topics
    has_many :tasks, through: :topics
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
end

  
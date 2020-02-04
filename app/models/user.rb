class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password
end
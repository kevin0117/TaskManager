class User < ApplicationRecord
  has_many :tasks, dependent: :destroy # 刪除使用者後，也會一併刪除該使用者的任務
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password
end
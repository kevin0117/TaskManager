class User < ApplicationRecord
  before_destroy :last_admin_check
  has_many :tasks, dependent: :destroy # 刪除使用者後，也會一併刪除該使用者的任務
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password

  private

  # 如果admin剩最後一個 無法被刪除
  def last_admin_check
    if User.where(admin: true).count == 1
      errors.add(:base, '無法刪除唯一管理者')
      throw(:abort)
    end
  end
end
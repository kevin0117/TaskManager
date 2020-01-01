class Task < ApplicationRecord
  enum priority: { low: 1, normal: 2, urgent:3 }
  enum status: { pending: 1, proceeding: 2, done:3 }
  validates :title, presence: true
  validates :content, length: {maximum: 500}, presence: true
  validates :task_begin, presence: true  #基本驗證，步驟12要改為 task_begin < task_end
  validates :task_end, presence: true    #基本驗證，步驟12要改為 task_begin < task_end
  validates :priority, presence: true
  validates :status, presence: true
end
  
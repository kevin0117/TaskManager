class Task < ApplicationRecord
  enum priority: { low: 1, normal: 2, urgent:3 }
  enum status: { pending: 1, proceeding: 2, done:3 }
  validates :title, presence: true
  validates :content, length: {maximum: 500}, presence: true
  validates :task_begin, presence: true  
  validates :task_end, presence: true    
  validates :priority, presence: true
  validates :status, presence: true
  # 驗證日期合理性
  validate :date_validator

  def date_validator
    if (self.task_begin == nil) || (self.task_end == nil)
      errors.add(:task, " begin 不能為空白")
    elsif self.task_begin >= self.task_end
      # puts "-------------------------"
      # puts self.task_begin.inspect
      # puts self.task_end.inspect
      # puts "--------------------------"
      errors.add(:task, "任務結束日期不能比開始日期早")
    end
  end

end
  
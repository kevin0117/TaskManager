# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
# Your comment
class Task < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :delete_all
  belongs_to :user
  enum priority: { low: 1, normal: 2, urgent: 3 }
  enum status: { pending: 1, proceeding: 2, done: 3 }
  validates :title, presence: true
  validates :content, length: { maximum: 500 }, presence: true
  validates :task_begin, presence: true
  validates :task_end, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validate :date_validator
  paginates_per 10
  include AASM
  # aasm 狀態機
  aasm column: 'status', enum: true do # , no_direct_assignment: true do
    # 定義狀況 state
    state :pending, initial: true
    state :proceeding
    state :done
    # 定義事件 event
    event :proceed do
      transitions from: :pending, to: :proceeding
    end
    event :act do
      transitions from: :proceeding, to: :done
    end
  end
  # 驗證日期合理性
  def date_validator
    if task_begin.nil? || task_end.nil?
      errors.add(:task, ': begin 不能為空白')
    elsif task_begin >= task_end
      # puts "-------------------------"
      # puts self.task_begin.inspect
      # puts self.task_end.inspect
      # puts "--------------------------"
      errors.add(:task, '任務結束日期不能比開始日期早')
    end
  end
  # Getter
  def all_tags
    # tags.map{|t| t.name}.join(',')
    tags.map(&:name).join(', ')
  end
  # Setter
  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create
    end
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end
end
# rubocop:enable Style/AsciiComments

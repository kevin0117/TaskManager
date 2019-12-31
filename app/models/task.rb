class Task < ApplicationRecord
    enum priority: { low: 1, normal: 2, urgent:3 }
    enum status: { pending: 1, proceeding: 2, done:3 }
  end
  
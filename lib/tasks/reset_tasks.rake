# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
namespace :db do
  desc 'Map Tasks with user'
  puts 'resetting tasks...'
  task reset_tasks: :environment do
    Task.all.each do |t|
      t.update(user_id: rand(1..3))
    end
  end
  puts 'done'
end
# rubocop:enable Style/AsciiComments

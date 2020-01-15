# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
namespace :task do
  desc '產生 500 筆樣本任務'
  task generate: :environment do
    puts 'generating tasks...'
    500.times { FactoryBot.create(:task) }
    puts 'done'
  end
end

# 終端機指令
# rails task:generate
# 約5000筆資料後，在 rails console 裡，用explain指令會看出建立 search index 的差別
# rubocop:enable Style/AsciiComments

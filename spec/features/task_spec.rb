# frozen_string_literal: true

# rubocop:disable Style/AsciiComments

require 'rails_helper'

RSpec.feature 'Task', type: :feature do
  describe 'Feature spec/功能測試' do
    scenario '建立任務成功' do
      visit '/tasks/new'
      fill_in 'task_title', with: 'Shopping'
      fill_in 'task_content', with: 'buy milk'
      select '2018', from: 'task_task_begin_1i'
      select '2019', from: 'task_task_end_1i'
      select '還好', from: 'task_priority'
      select '未進行', from: 'task_status'
      click_button '送出'
      expect(page).to have_text('建立成功')
    end
    scenario '建立任務失敗' do
      visit '/'

      click_link '新增任務'
      expect(current_path).to eq(new_task_path)

      fill_in 'task_title', with: ''
      fill_in 'task_content', with: 'buy milk'
      select '2018', from: 'task_task_begin_1i'
      select '2019', from: 'task_task_end_1i'
      select '超急', from: 'task_priority'
      select '進行中', from: 'task_status'

      click_button '送出'

      expect(page).to have_text('建立失敗')
    end

    scenario '編輯任務成功' do
      task1 = FactoryBot.create(:task, content: 'buy apple')
      task2 = FactoryBot.create(:task, content: 'buy orange')

      visit '/'
      within 'tr:nth-child(2)' do
        click_on '編輯'
      end
      fill_in 'task_content', with: 'apple'
      click_button '送出'
      expect(page).to have_text('更新成功')
    end

    scenario '刪除任務成功' do
      task1 = FactoryBot.create(:task, content: 'task1')
      task2 = FactoryBot.create(:task, content: 'tFactoryBot')
      visit '/'
      within 'tr:nth-child(2)' do
        click_link '刪除'
      end

      expect(page).not_to have_content('task1')
      expect(page).to have_text('刪除成功')
    end

    scenario '任務列表以建立時間排序' do
      task1 = FactoryBot.create(:task, title: 'task1')
      task2 = FactoryBot.create(:task, title: 'task2')
      visit '/'
      within 'tr:nth-child(2)' do
        expect(page).to have_content('task2')
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content('task1')
      end
    end

    scenario "任務列表以結束時間排序" do
      task1 = FactoryBot.create(:task,
                                title: 'task1',
                                task_begin: 'Tue, 26 Nov 2019 01:13:00 CST +08:00',
                                task_end: 'Wed, 27 Nov 2019 01:13:00 CST +08:00')
      task2 = FactoryBot.create(:task,
                                 title: 'task2',
                                 task_begin: 'Tue, 9 Nov 2019 01:13:00 CST +08:00',
                                 task_end: 'Fri, 29 Nov 2019 01:13:00 CST +08:00')
      visit '/'
      click_link '任務結束'

      within 'tr:nth-child(2)' do
        expect(page).to have_content('task1') 
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content('task2') 
      end
    end
    scenario '查詢功能搜尋成功' do
      task1 = FactoryBot.create(:task, title: 'title_A')
      task2 = FactoryBot.create(:task, title: 'title_A')
      visit '/'
      fill_in 'q_title_or_content_cont', with: 'title_A'
      click_button '搜尋'

      expect(page).to have_content('title_A')
      expect(page).to have_text('搜尋結果共: 2 筆')
    end
    scenario '任務列表以優先順序排序' do
      task_1 = FactoryBot.create(:task, title: 'task_1', priority: 'low')
      task_2 = FactoryBot.create(:task, title: 'task_2', priority: 'normal')
      task_3 = FactoryBot.create(:task, title: 'task_3', priority: 'urgent')

      visit '/'
      click_link '優先順序'

      within 'tr:nth-child(2)' do
        expect(page).to have_content('task_3')
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content('task_2')
      end
      within 'tr:nth-child(4)' do
        expect(page).to have_content('task_1')
      end
    end
  end
end

# rubocop:enable Style/AsciiComments

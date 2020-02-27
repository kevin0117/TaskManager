# frozen_string_literal: true

# rubocop:disable Style/AsciiComments

require 'rails_helper'

RSpec.feature 'Task', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user_id: user.id) }

  describe 'Feature spec/功能測試' do
    scenario '建立任務成功' do
      login_user
      click_button '新增任務'
      fill_in_task_info
      click_button '送出'
      expect(page).to have_text('建立成功')
    end

    scenario '建立任務失敗' do
      visit '/tasks'
      login_user
      click_button '新增任務'
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
      login_user
      click_button '新增任務'
      fill_in_task_info
      click_button '送出'
      within 'tr:nth-child(2)' do
        click_link '編輯'
      end
      fill_in 'task_title', with: 'apple'
      click_button '送出'
      expect(page).to have_text('更新成功')
    end

    scenario '刪除任務成功' do
      FactoryBot.create(:task, title: 'task1')
      FactoryBot.create(:task, title: 'task2')
      login_user
      visit '/tasks'
      within 'tr:nth-child(2)' do
        click_link '刪除'
      end

      expect(page).not_to have_title('task1')
      expect(page).to have_text('刪除成功')
    end

    scenario '任務列表以建立時間排序' do
      FactoryBot.create(:task, title: 'task1')
      FactoryBot.create(:task, title: 'task2')
      login_user
      visit '/tasks'
      within 'tr:nth-child(2)' do
        expect(page).to have_content('task2')
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content('task1')
      end
    end

    scenario '任務列表以結束時間排序' do
      FactoryBot.create(:task,
                        title: 'task1',
                        task_begin: 'Tue, 26 Nov 2019 01:13:00 CST +08:00',
                        task_end: 'Wed, 27 Nov 2019 01:13:00 CST +08:00')
      FactoryBot.create(:task,
                        title: 'task2',
                        task_begin: 'Tue, 9 Nov 2019 01:13:00 CST +08:00',
                        task_end: 'Fri, 29 Nov 2019 01:13:00 CST +08:00')
      login_user
      visit '/tasks'
      click_link '任務結束'

      within 'tr:nth-child(2)' do
        expect(page).to have_content('task1') 
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content('task2') 
      end
    end
    scenario '查詢功能搜尋成功' do
      FactoryBot.create(:task, title: 'title_A')
      FactoryBot.create(:task, title: 'title_A')
      login_user
      visit '/tasks'
      fill_in 'q_title_or_content_cont', with: 'title_A'
      click_button '搜尋'

      expect(page).to have_content('title_A')
      expect(page).to have_text('搜尋結果共: 2 筆')
    end
    scenario '任務列表以優先順序排序' do
      FactoryBot.create(:task, title: 'task_1', priority: 'low')
      FactoryBot.create(:task, title: 'task_2', priority: 'normal')
      FactoryBot.create(:task, title: 'task_3', priority: 'urgent')
      login_user
      visit '/tasks'
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

    scenario '新增標籤與建立任務成功', tags_feature: true do
      login_user
      click_button '新增任務'
      fill_in_task_info
      fill_in 'task_all_tags', with: 'coding, rails'
      click_button '送出'
      within 'tr:nth-child(2)' do
        expect(page).to have_content('coding')
        expect(page).to have_content('rails')
      end
      expect(page).to have_text('建立成功')
    end

    scenario '從導覽列進行標籤搜尋任務', tags_feature: true do
      login_user
      click_button '新增任務'
      fill_in_task_info
      fill_in 'task_all_tags', with: 'coding, ruby'
      click_button '送出'
      select 'ruby', from: 'q_tags_name_eq'
      click_button '搜尋'
      within 'tr:nth-child(2)' do
        expect(page).to have_content('ruby')
      end
      expect(page).to have_content('搜尋結果共: 1 筆')
    end

    scenario '從任務首頁進行標籤搜尋任務', tags_feature: true do
      login_user
      click_button '新增任務'
      fill_in_task_info
      fill_in 'task_all_tags', with: 'ruby'
      click_button '送出'
      click_button '新增任務'
      fill_in_task_info
      fill_in 'task_all_tags', with: 'coding, ruby'
      click_button '送出'
      within 'tr:nth-child(2)' do
        click_link 'ruby'
      end      
      expect(page).to have_content('ruby')
      expect(page).to have_content('ruby coding')
      within 'tr:nth-child(3)' do
        click_link 'coding'
      end 
      expect(page).to have_content('ruby coding')
    end

    private

    def login_user
      visit login_path
      fill_in('session[email]', with: user.email)
      fill_in('session[password]', with: user.password)
      click_button '送出'
    end
    def fill_in_task_info
      fill_in 'task_title', with: 'shopping'
      fill_in 'task_content', with: 'buy milk'
      select '2018', from: 'task_task_begin_1i'
      select '2019', from: 'task_task_end_1i'
      select '還好', from: 'task_priority'
      select '未進行', from: 'task_status'
    end
  end
end

# rubocop:enable Style/AsciiComments

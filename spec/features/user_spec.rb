require 'rails_helper'

RSpec.feature 'User', type: :feature do
  let(:normal_user) { FactoryBot.create(:user, :normal_user) }
  let(:admin_user) { FactoryBot.create(:user, :admin_user) }
  let(:task) { FactoryBot.create(:task, user_id: user.id) }

  describe 'Feature spec/功能測試' do
    scenario '建立使用者成功' do
      visit '/tasks'
      click_link '註冊'
      expect(current_path).to eq(sign_up_path)
      fill_in 'user_username', with: 'admin'
      fill_in 'user_email', with: 'admin@gmail.com'
      fill_in 'user_password', with: '123456'
      click_button '新增User'
      expect(page).to have_text('admin 已註冊成功！')
    end
    scenario '建立使用者失敗' do
      visit '/tasks'
      click_link '註冊'
      expect(current_path).to eq(sign_up_path)
      fill_in 'user_username', with: 'admin'
      fill_in 'user_email', with: 'admin@gmail.com'
      fill_in 'user_password', with: ''
      click_button '新增User'
      expect(page).to have_text('密碼不能為空白')
    end
    scenario '管理員新增使用者帳戶成功' do
      login_admin_user
      visit admin_sign_up_path
      fill_in_admin_user_info
      expect(page).to have_text('admin 已註冊成功！')
    end
    scenario '管理員編輯使用者帳戶成功' do
      login_admin_user
      visit admin_sign_up_path
      fill_in_admin_user_info
      click_link '使用者列表'
      within 'tr:nth-child(2)' do
        click_link '編輯'
      end
      fill_in 'user_username', with: 'anyone'
      click_button '更新User'
      expect(page).to have_text('更新帳戶成功')
    end
    scenario '管理員刪除使用者帳戶成功' do
      login_admin_user
      visit admin_sign_up_path
      fill_in_admin_user_info
      click_link '使用者列表'
      # expect(current_path).to eq(admin_users_path)
      within 'tr:nth-child(2)' do
        click_link '刪除'
      end
      expect(page).to have_text('刪除帳戶成功')
    end
    # scenario '管理員只剩下1個人時，不能再被刪除' do
    #   login_admin_user
    #   # visit admin_sign_up_path
    #   # fill_in_admin_user_info
    #   click_link '使用者列表'
    #   # expect(current_path).to eq(admin_users_path)
    #   within 'tr:nth-child(2)' do
    #     click_link '刪除'
    #   end
    #   expect(page).to have_text('無法刪除唯一管理者')
    # end
    scenario '管理員編輯任務成功' do
      login_admin_user
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
    scenario '一般使用者無法登入後台系統' do
      visit admin_login_path
      fill_in('session[email]', with: normal_user.email)
      fill_in('session[password]', with: normal_user.password)
      click_button '登入'      
      expect(page).to have_text('權限不足')
    end
  end

  private

  def login_normal_user
    visit login_path
    fill_in('session[email]', with: normal_user.email)
    fill_in('session[password]', with: normal_user.password)
    click_button '登入'
  end

  def login_admin_user
    visit admin_login_path
    fill_in('session[email]', with: admin_user.email)
    fill_in('session[password]', with: admin_user.password)
    click_button '登入'
  end

  def fill_in_admin_user_info
    fill_in 'user_username', with: 'admin'
    fill_in 'user_email', with: 'admin@gmail.com'
    fill_in 'user_password', with: '123456'
    check 'user_admin'
    click_button '新增User'
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
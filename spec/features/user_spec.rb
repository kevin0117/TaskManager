require 'rails_helper'

RSpec.feature 'User', type: :feature do
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
  end
end
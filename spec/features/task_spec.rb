require 'rails_helper'

RSpec.feature "Task", type: :feature do
  describe "Feature spec/功能測試" do

    scenario "建立任務成功" do
      visit '/tasks/new'
    
      fill_in "task_title", with: "Shopping"
      fill_in "task_content", with: "buy milk"
      select '2018', from: 'task_task_begin_1i'
      select '2019', from: 'task_task_end_1i'
      select '還好', from: 'task_priority'
      select '未進行', from: 'task_status'
  
      click_button "送出"
  
      expect(page).to have_text("建立成功")
    end 
    
    scenario "建立任務失敗" do
      visit '/'
    
      click_link "新增任務"
      expect(current_path).to eq(new_task_path)
  
      fill_in "task_title", with: ""
      fill_in "task_content", with: "buy milk"
      select '2018', from: 'task_task_begin_1i'
      select '2019', from: 'task_task_end_1i'
      select '超急', from: 'task_priority'
      select '進行中', from: 'task_status'
  
      click_button "送出"
  
      expect(page).to have_text("建立失敗")
    end

    scenario "編輯任務成功" do
      task1 = Task.create(title: "Shopping", 
          content: "buy apple", 
          task_begin: "2018-11-01 09:00:00",
          task_end: "2019-11-01 00:00:00",
          priority: "urgent",
          status: "pending")

      task2 = Task.create(title: "Shopping", 
          content: "buy apple", 
          task_begin: "2018-11-01 09:00:00",
          task_end: "2019-11-01 00:00:00",
          priority: "urgent",
          status: "pending")

      visit '/'
      within 'tr:nth-child(2)' do
        click_on "編輯"
      end
      fill_in "task_content", with: "apple"
      click_button "送出"
      
      expect(page).to have_text("更新成功")
    end

    scenario "刪除任務成功" do
      task1 = Task.create(title: "Shopping", 
          content: "buy apple", 
          task_begin: "2018-11-01 09:00:00",
          task_end: "2019-11-01 00:00:00",
          priority: "urgent",
          status: "pending")

      task2 = Task.create(title: "Shopping", 
          content: "buy apple", 
          task_begin: "2018-11-01 09:00:00",
          task_end: "2019-11-01 00:00:00",
          priority: "urgent",
          status: "pending")
        
      visit '/'
  
      within 'tr:nth-child(2)' do
        click_link "刪除"
      end

      expect(page).not_to have_content("task2")
      expect(page).to have_text("刪除成功")
    end

    scenario "任務列表以建立時間排序" do
      task1 = Task.create(title: "task1", 
        content: "buy apple", 
        task_begin: "2018-10-01 09:00:00",
        task_end: "2019-11-01 00:00:00",
        priority: "low",
        status: "pending")
  
      task2 = Task.create(title: "task2", 
        content: "buy apple", 
        task_begin: "2018-10-01 09:00:00",
        task_end: "2019-11-01 00:00:00",
        priority: "low",
        status: "pending")

      task3 = Task.create(title: "task3", 
        content: "buy apple", 
        task_begin: "2018-10-01 09:00:00",
        task_end: "2019-11-01 00:00:00",
        priority: "low",
        status: "pending")
    
      visit '/'
  
      within 'tr:nth-child(2)' do
        expect(page).to have_content("task2") 
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content("task1") 
      end
    end

    scenario "任務列表以結束時間排序" do
      task1 = Task.create(title: "task1", 
        content: "buy apple", 
        task_begin: "2018-10-01 09:00:00",
        task_end: "2020-01-10 00:00:00",
        priority: "low",
        status: "pending")
  
      task2 = Task.create(title: "task2", 
        content: "buy apple", 
        task_begin: "2018-10-01 09:00:00",
        task_end: "2020-01-11 00:00:00",
        priority: "low",
        status: "pending")

      task3 = Task.create(title: "task3", 
        content: "buy apple", 
        task_begin: "2018-10-01 09:00:00",
        task_end: "2020-01-12 00:00:00",
        priority: "low",
        status: "pending")

      visit '/'

      click_link "任務結束"

      within 'tr:nth-child(2)' do
        expect(page).to have_content("task2") 
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content("task3") 
      end
    end
  end
end
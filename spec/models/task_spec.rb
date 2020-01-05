require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Model spec/單元測試" do 
    it "任務建立成功當全部欄位正確填寫完成" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "2018-11-01 09:00:00",
                      task_end: "2019-11-01 00:00:00",
                      priority: "urgent",
                      status: "pending")
      expect(task).to be_valid
    end

    it "名稱欄位不能是空白，如果成功任務建立" do
      task = Task.new(title: "", 
                      content: "buy apple", 
                      task_begin: "2019-11-01 09:00:00",
                      task_end: "2019-11-01 00:00:00",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Title 不能為空白/)
    end
    
    it "內容不能是空白，如果成功任務建立" do
      task = Task.new(title: "Shopping", 
                      content: "", 
                      task_begin: "2019-11-01 09:00:00",
                      task_end: "2019-11-01 00:00:00",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Content 不能為空白/)
    end
    
    it "任務開始日期不能是空白，如果成功任務建立" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "",
                      task_end: "2019-11-01 00:00:00",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Task begin 不能為空白/)
    end
    
    it "任務結束日期不能是空白，如果成功任務建立" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "2019-11-01 09:00:00",
                      task_end: "",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Task end 不能為空白/)
    end
    
    it "任務優先順序不能是空白，如果成功任務建立" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "2019-11-01 09:00:00",
                      task_end: "2019-11-01 00:00:00",
                      priority: "",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Priority 不能為空白/)
    end
    
    it "任務狀態不能是空白，如果成功任務建立" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "2019-11-01 09:00:00",
                      task_end: "2019-11-01 00:00:00",
                      priority: "urgent",
                      status: "")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Status 不能為空白/)
    end 

    it "任務建立失敗當結束時間設定錯誤" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "Wed, 25 Nov 2019 19:06:00 CST +08:00",
                      task_end: "Wed, 21 Nov 2019 19:06:00 CST +08:00",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Task 任務結束日期不能比開始日期早/)
    end
  end
end

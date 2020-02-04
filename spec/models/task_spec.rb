# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Model spec/單元測試' do
    context '如果任務建立成功時...' do
      it '全部欄位正確填寫完成' do
        task = FactoryBot.build(:task)
        user = FactoryBot.build(:user)
        expect(task).to be_valid
      end
      it '狀態欄位可以是空白，因為預設是pending' do
        task = FactoryBot.build(:task, status: '')
        expect { expect(task).to be_valid }
      end
      it '任務開始日期不能是空白' do
        task = FactoryBot.build(:task, task_begin: '')
        expect { expect(task).to be_valid }.to raise_exception(/Task begin 不能為空白/)
      end
      it '任務結束日期不能是空白' do
        task = FactoryBot.build(:task, task_end: '')
        expect { expect(task).to be_valid }.to raise_exception(/Task end 不能為空白/)
      end
      it '任務優先順序不能是空白' do
        task = FactoryBot.build(:task, priority: '')
        expect{ expect(task).to be_valid }.to raise_exception(/Priority 不能為空白/)
      end
      it '名稱欄位不能是空白' do
        task = FactoryBot.build(:task, title: '')
        expect { expect(task).to be_valid }.to raise_exception(/Title 不能為空白/)
      end
      it '內容不能是空白' do
        task = FactoryBot.build(:task, content: '')
        expect { expect(task).to be_valid }.to raise_exception(/Content 不能為空白/)
      end
    end
    context '如果任務建立失敗...' do
      it '當結束時間設定錯誤' do
        task = FactoryBot.build(:task,
                                task_begin: 'Wed, 25 Nov 2019 19:06:00',
                                task_end: 'Wed, 21 Nov 2019 19:06:00')
        expect { expect(task).to be_valid }.to raise_exception(/Task 任務結束日期不能比開始日期早/)
      end
    end
  end
end
# rubocop:enable Style/AsciiComments

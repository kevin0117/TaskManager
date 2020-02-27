require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Model spec/單元測試' do
    context '如果標籤建立成功時...' do
      it '欄位正確填寫完成', tags: true do
        tag = FactoryBot.build(:tag)
        expect(tag).to be_valid
      end
      it '標籤名字不能是空白', tags: true do
        tag = FactoryBot.build(:tag, name: '')
        expect { expect(tag).to be_valid }.to raise_exception(/Name 不能為空白/)
      end
      it '標籤名字必須是獨一無二的', tags: true do
        tag1 = FactoryBot.create(:tag, name: 'shopping')
        tag2 = FactoryBot.build(:tag, name: 'shopping')

        expect { expect(tag2).to be_valid }.to raise_exception(/Name 已經被使用/)
      end
      it '標籤名字不能太長', tags: true do
        tag = FactoryBot.build(:tag, name: 'k'*26)
        expect(tag).not_to be_valid
      end
      it '標籤名字不能太短', tags: true do
        tag = FactoryBot.build(:tag, name: 'k'*2)
        expect(tag).not_to be_valid
      end
    end
  end
end
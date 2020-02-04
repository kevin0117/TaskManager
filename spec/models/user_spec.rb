require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model spec/單元測試' do
    context '如果使用者建立成功時...' do
      it '全部欄位正確填寫完成' do
        user = FactoryBot.build(:user)
        expect { expect(user).to be_valid }
      end
      it '使用者名稱不能是空白' do
        user = FactoryBot.build(:user, username: '')
        expect { expect(user).to be_valid }.to raise_exception(/Username 不能為空白/)
      end
      it '電子信箱不能是空白' do
        user = FactoryBot.build(:user, email: '')
        expect { expect(user).to be_valid }.to raise_exception(/Email 不能為空白/)
      end
      it '密碼不能是空白' do
        user = FactoryBot.build(:user, password: '')
        expect { expect(user).to be_valid }.to raise_exception(/Password 不能為空白/)
      end
    end
  end
end

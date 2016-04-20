require 'rails_helper'

describe Admin::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならtrueをかえす' do
      m = FactoryGirl.build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '正しくないパスワードならfalseをかえす' do
      m = FactoryGirl.build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワードが未設定ならfalseをかえす' do
      m = FactoryGirl.build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '停止フラグが立っていてもtrueを返す' do
      m = FactoryGirl.build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
  end
end
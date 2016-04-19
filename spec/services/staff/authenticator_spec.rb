require 'rails_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならtrueをかえす' do
      m = FactoryGirl.build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '正しいパスワードならfalseをかえす' do
      m = FactoryGirl.build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワードが未設定ならfalseをかえす' do
      m = FactoryGirl.build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '停止フラグが立っていればfalseをかえす' do
      m = FactoryGirl.build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '開始前ならfalseをかえす' do
      m = FactoryGirl.build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '終了後ならfalseをかえす' do
      m = FactoryGirl.build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end
  end
end
require 'rails_helper'

describe User, type: :model do
  context 'Email is not valid' do
    context 'Email is empty' do
      it 'should not save the user' do
        expect(build :user, email: '').not_to be_valid
      end
    end
    context 'Email is not unique' do
      it 'should not save the user' do
        create(:user, email: 'dummy@example.com')
        expect(build :user, email: 'dummy@example.com').not_to be_valid
      end
    end
  end

  context 'Name is not valid' do
    context 'Name is empty' do
      it 'should not save the user' do
        expect(build :user, name: '').not_to be_valid
      end
    end
    context 'Name is not unique' do
      it 'should not save the email' do
        create(:user, name: 'Dummy')
        expect(build :user, name: 'Dummy').not_to be_valid
      end
    end
  end
  context 'Password is empty' do
    it 'should not save the email' do
      expect(build :user, password: '').not_to be_valid
    end
  end
  context 'Email, Name and password are valid' do
    it 'should save the user' do
      expect(build(:user)).to be_valid
      expect{create(:user)}.to change { User.count }.by(1)
    end
  end
end

require 'rails_helper'

describe UserRepository, type: :model do
  let(:user_repo) {UserRepository.new(User)}
  context 'user gets created' do
    context 'Getting user by his name' do
      it 'should return created user' do
        user = create(:user)
        user_repo = UserRepository.new(User)
        expect(user_repo.get_user(user.name)).to eq(user)
      end
    end
    context 'Getting user by another name' do
      it 'should return nil' do
        user = create(:user)
        expect(user_repo.get_user("Dummy")).not_to eq(user)
        expect(user_repo.get_user("Dummy")).to be_nil
      end
    end
  end
end

require 'rails_helper'

describe Invitation, type: :model do
  context 'Email is not valid' do
    context 'Email is empty' do
      it 'should not save the invitation' do
        expect(build :invitation, email: '').not_to be_valid
      end
      context 'Email is not in its right format' do
        it 'should not save the invitation' do
          expect(build :invitation, email: 'Dummy').not_to be_valid
        end
      end
    end
    context 'Invitation is sent again to same person' do
      it 'should not save the invitation' do
        create(:invitation, email: 'dummy@example.com')
        expect(build :invitation, email: 'dummy@example.com').not_to be_valid
      end
    end
    context 'No inviter user found' do
      it 'should not save the invitation' do
        expect(build :invitation, inviter_user_id: '').not_to be_valid
      end
    end
  end
  context 'Invitee already joined' do
    it 'should not be able to invite him' do
      user = create(:user)
      expect(build :invitation, email: user.email).not_to be_valid
    end
  end
  context 'Invitation attributes are valid' do
    it 'should save the invitation' do
      expect(build(:invitation)).to be_valid
      expect{create(:invitation)}.to change { Invitation.count }.by(1)
    end
  end
end

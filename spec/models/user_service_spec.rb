require 'rails_helper'

describe UserService do
  context 'User A invites B and B accepts' do
    let(:user_a) {create(:user)}
    let(:user_b) {create(:user, parent_id: user_a.id)}
    let(:compute_service_b) {
      UserService.new(user_b).compute_points
    }
    it 'User A should have points of 1' do
      compute_service_b
      expect(user_a.points(category: 'Recommend points')).to eq(1)
    end
    it 'User B should have points of 0' do
      compute_service_b
      expect(user_b.points(category: 'Recommend points')).to eq(0)
    end
    context 'User B invites C, C accepts' do
      let(:user_c) {create(:user, parent_id: user_b.id)}
      let(:compute_service_c) {
        UserService.new(user_c).compute_points
      }
      it 'User A should have points of 1.5' do
        compute_service_b
        compute_service_c
        expect(user_a.points(category: 'Recommend points')).to eq(1.5)
      end
      it 'User B should have points of 1' do
        compute_service_b
        compute_service_c
        expect(user_b.points(category: 'Recommend points')).to eq(1)
      end
      it 'User C should have points of 0' do
        compute_service_b
        compute_service_c
        expect(user_c.points(category: 'Recommend points')).to eq(0)
      end
      context 'User C invites D, D accepts' do
        let(:user_d) {create(:user, parent_id: user_c.id)}
        let(:compute_service_d) {
          UserService.new(user_d).compute_points
        }
        it 'User A should have points of 1.75' do
          compute_service_b
          compute_service_c
          compute_service_d
          expect(user_a.points(category: 'Recommend points')).to eq(1.75)
        end
        it 'User B should have points of 1.5' do
          compute_service_b
          compute_service_c
          compute_service_d
          expect(user_b.points(category: 'Recommend points')).to eq(1.5)
        end
        it 'User C should have points of 1' do
          compute_service_b
          compute_service_c
          compute_service_d
          expect(user_c.points(category: 'Recommend points')).to eq(1)
        end
        it 'User D should have points of 0' do
          compute_service_b
          compute_service_c
          compute_service_d
          expect(user_d.points(category: 'Recommend points')).to eq(0)
        end
      end
    end
  end
  context "Increase invitation tree to 20" do
    it 'Number of points should be 2 at the most parent' do
      user_a = create(:user, parent_id: nil)
      parent_id = user_a.id
      20.times.each do
        user = create(:user, parent_id: parent_id)
        UserService.new(user).compute_points
        parent_id = user.id
      end
      expect(user_a.points(category: 'Recommend points')).to eq(2)
    end
  end
end

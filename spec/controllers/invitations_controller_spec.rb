require 'rails_helper'

describe InvitationsController, type: :controller do
  context 'User signed in' do
    before :each do
      @me = create :user
      sign_in @me
    end
    describe "GET new" do
      it "has a 200 status code" do
        get :new
        expect(response.status).to eq(200)
      end
    end
    describe "POST create" do
      context "If user was not invited before" do
        it "should create a new invitation" do
          expect{
            post :create, params: {invitation: {email: Faker::Internet.email}}
          }.to change(Invitation, :count).by 1
          expect(response).to redirect_to root_path
        end
      end
      context 'If user was invited before' do
        it 'should not create a new invitation' do
          invitation = create(:invitation)
          expect{
            post :create, params: {invitation: {email: invitation.email}}
          }.to change(Invitation, :count).by 0
          expect(response).to render_template :new
        end
      end
    end
  end
  context 'No user signed in' do
    describe "GET new" do
      it "redirects to login path with 302" do
        get :new
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe "POST create" do
      it "redirects to login path with 302" do
        post :create, params: {invitation: {email: Faker::Internet.email}}
        expect(response).to redirect_to new_user_session_path
        expect(response.status).to eq(302)
      end
      it 'Should not save the invitation' do
        expect{
          post :create, params: {invitation: {email: Faker::Internet.email}}
        }.to change(Invitation, :count).by 0
      end
    end
  end
end

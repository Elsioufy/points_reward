require 'rails_helper'

describe DashboardController, type: :controller do
  context 'User signed in' do
    before :each do
      @me = create :user
      sign_in @me
    end
    describe "GET new" do
      it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
  context 'No user signed in' do
    describe "GET new" do
      it "redirects to login path with 302" do
        get :index
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

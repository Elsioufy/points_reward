require "rails_helper"

# This feature spec is used to test our invitation spec

feature Invitation, :type => :feature do
  feature "As signed in user" do
    before(:each) do
      @user = create(:user)
      visit new_user_session_path
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password
      click_on 'Log in'
    end
    scenario 'goes to new invitation' do
      click_link("invite_new_user")
      expect(current_path).to eq new_invitation_path
    end
    scenario 'creates a new invitation successfully' do
      visit new_invitation_path
      fill_in :invitation_email, with: 'test@points_reward.com'
      click_on 'Send'
      expect(current_path).to eq root_path
      page.should have_selector ".alert-info", text: "User successfully invited"
    end

    scenario 'creating the invitation twice should fail' do
      invitation = create(:invitation, inviter_user: @user)
      visit new_invitation_path
      fill_in :invitation_email, with: invitation.email
      click_on 'Send'
      expect(current_path).to eq invitations_path
      page.should have_selector ".alert-danger"
    end
  end
  feature "As a non authorized user" do
    scenario 'can not initiate a new invitation' do
      visit new_invitation_path
      expect(current_path).to eq new_user_session_path
    end
  end
end
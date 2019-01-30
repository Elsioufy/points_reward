# Invitations controller, used to initiate and create invitations to users.
class InvitationsController < ApplicationController
  # GET /invitations/new
  # Initialize a new invitation
  def new
    @invitation = Invitation.new
  end
  # POST /invitations
  # It creates a new invitation for a specific email
  def create
    @invitation = Invitation.new(invitation_params)
    # Sets the inviter to current user
    @invitation.inviter_user = current_user
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to root_path, notice: t('invitation.success') }
      else
        format.html { render :new }
      end
    end
  end


  private
    def invitation_params
      params.require(:invitation).permit(:email)
    end
end

class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.inviter_user = current_user
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to root_path, notice: 'User successfully invited' }
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

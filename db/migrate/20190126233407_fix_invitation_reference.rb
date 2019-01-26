class FixInvitationReference < ActiveRecord::Migration[5.2]
  def up
    remove_column :invitations, :inviter_user_id
    add_reference :invitations, :inviter_user, index: true, foreign_key: {to_table: :users}
  end

  def down
    add_reference :invitations, :inviter_user, index: true, foreign_key: {to_table: :invitations}
  end
end

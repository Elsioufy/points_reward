class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :inviter_user, index: true, foreign_key: {to_table: :invitations}
      t.string :email
      t.timestamps
    end
  end
end

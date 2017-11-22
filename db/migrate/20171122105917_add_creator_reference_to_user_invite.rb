class AddCreatorReferenceToUserInvite < ActiveRecord::Migration[5.1]
  def change
    add_column :user_invites, :creator_id, :integer
    add_foreign_key :user_invites, :users, column: :creator_id
  end
end

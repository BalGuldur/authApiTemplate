class FixNameUserFieldInUserInvites < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_invites, :user, :employee
  end
end

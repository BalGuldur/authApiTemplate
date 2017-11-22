class CreateUserInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :user_invites do |t|
      t.datetime :deleted_at
      t.json :user
      t.string :token

      t.timestamps
    end
    add_index :user_invites, :deleted_at
  end
end

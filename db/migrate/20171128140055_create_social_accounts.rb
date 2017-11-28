class CreateSocialAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :social_accounts do |t|
      t.integer :socialUserId
      t.string :platform
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :title
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :companies, :deleted_at
  end
end

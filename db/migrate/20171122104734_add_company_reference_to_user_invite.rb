class AddCompanyReferenceToUserInvite < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_invites, :company, foreign_key: true
  end
end

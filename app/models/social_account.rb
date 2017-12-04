class SocialAccount < ApplicationRecord
  include FrontView

  # TODO: Check need acts_as_tenant for social_account
  validates :socialUserId, uniqueness: :true

  belongs_to :user

  # Model links for generate front veiw
  # { model: '', type: 'many/one', rev_type: 'many/one', index_inc: true/false }
  def self.refs
    []
  end
end

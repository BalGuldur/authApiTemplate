class SocialAccount < ApplicationRecord
  # TODO: Check need acts_as_tenant for social_account
  validates :socialUserId, uniqueness: :true

  belongs_to :user
end

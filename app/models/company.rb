# Model for multi-tenancy
class Company < ApplicationRecord
  acts_as_paranoid

  has_many :users, dependent: :destroy
end

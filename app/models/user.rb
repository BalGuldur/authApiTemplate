# Model for store user's account
class User < ApplicationRecord
  acts_as_paranoid
  acts_as_tenant :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # remove :registrable, :recoverable
  # TODO: Change jwt_revocation_strategy to Blacklist
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  belongs_to :company

  before_save :set_fullname

  # TODO: Изменить validates email для multi-tenancy
  validates :email, uniqueness: { case_sensitive: false }

  def is_admin?
    admin
  end

  private

  def set_fullname
    self.fullname = name + ' ' + surname
  end
end

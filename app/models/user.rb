# Model for store user's account
class User < ApplicationRecord
  include FrontView
  acts_as_paranoid
  acts_as_tenant :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # remove :registerable, :recoverable
  # TODO: Change jwt_revocation_strategy to Blacklist
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  belongs_to :company

  before_save :set_fullname

  # TODO: Изменить validates email для multi-tenancy
  validates :email, uniqueness: { case_sensitive: false }

  # Model links for generate front veiw
  # { model: '', type: 'many/one', rev_type: 'many/one', index_inc: true/false }
  def self.refs
    []
  end

  def is_admin?
    admin
  end

  private

  def set_fullname
    self.fullname = "#{name} #{surname}"
  end
end

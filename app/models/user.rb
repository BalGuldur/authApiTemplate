# Model for store user's account
class User < ApplicationRecord
  # TODO: Add FrontView test
  include FrontView
  acts_as_paranoid
  acts_as_tenant :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # remove :registerable, :recoverable
  # TODO: Change jwt_revocation_strategy to Blacklist
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :user_invites, dependent: :destroy
  has_many :social_accounts, dependent: :destroy
  belongs_to :company

  before_save :set_fullname

  # TODO: Изменить validates email для multi-tenancy
  validates :email, uniqueness: { case_sensitive: false }

  # Model links for generate front veiw
  # { model: '', type: 'many/one', rev_type: 'many/one', index_inc: true/false }
  def self.refs
    [ model: 'social_accounts', type: 'many', rev_type: 'one', index_inc: true]
  end

  def is_admin?
    admin
  end

  # rewrite destroy, becourse before_destroy rollback don't work with acts_as_paranoid
  def destroy
    if last_user?
      # TODO: Change error str to i18n str
      errors[:error] << 'Невозможно удалить последнего пользователя'
      false
    else
      super
    end
  end

  private

  def last_user?
    company.users.count < 2
  end

  def set_fullname
    self.fullname = "#{name} #{surname}"
  end
end

# TODO: Remove token from front view
class UserInvite < ApplicationRecord
  include FrontView
  acts_as_paranoid
  acts_as_tenant :company

  after_create :set_token

  belongs_to :company
  belongs_to :creator, class_name: 'User'

  validates :employee, presence: :true
  validate :email_must_be_presence_and_uniq

  def email_must_be_presence_and_uniq
    # TODO: User Add multi-tenancy on one user
    # TODO: User check on User.invite work only with one tenant
    # TODO: User change error str to i18n str
    errors.add(:employee, 'Email обязательное поле') unless
      employee['email'].present?
    errors.add(:employee, 'Пользователь с email уже существует') if
      User.find_by('lower(email) = ?', employee['email'].downcase)
    errors.add(:employee, 'Приглашение с email уже существует') if
      UserInvite.where(
        "lower(employee->>'email') = ?",
        employee['email'].downcase
      ).present?
  end

  # Model links for generate front veiw
  # { model: '', type: 'many/one', rev_type: 'many/one', index_inc: true/false }
  def self.refs
    []
  end

  def send_invite
    if save
      # TODO: Add send email with invite
      # send_invite_email
      true
    else
      false
    end
  end

  def reg reg_params
    # TODO: FIRST Remove UserInvite
    ActsAsTenant.current_tenant = company
    @user = User.new(employee)
    @user.attributes = reg_params
    return @user
  end

  private

  def set_token
    # self.token = Token.gen user_invite: self.as_json
    update_column :token, Token.gen(
      user_invite: as_json(only: :id)
    )
  end
end

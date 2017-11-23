# TODO: Remove token from front view
class UserInvite < ApplicationRecord
  include FrontView
  acts_as_paranoid
  acts_as_tenant :company

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
    set_token
    # TODO: Add send email with invite
    save
  end

  private

  def set_token
    # TODO: UserInvite - generate token, add check user not empty
    self.token = Token.gen_invite self
  end
end

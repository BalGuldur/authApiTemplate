# TODO: Add creator for UserInvite
# TODO: Remove token from front view
class UserInvite < ApplicationRecord
  include FrontView
  acts_as_paranoid
  acts_as_tenant :company

  belongs_to :company
  belongs_to :creator, class_name: 'User'

  # Model links for generate front veiw
  # { model: '', type: 'many/one', rev_type: 'many/one', index_inc: true/false }
  def self.refs
    []
  end

  def send_invite
    # TODO: User Add multi-tenancy on one user
    # TODO: User check on User.invite work only with one tenant
    if User.find_by(email: user['email'])
      # TODO: User change error str to i18n str
      errors.add(:error, 'Пользователь уже существует')
      false
    else
      gen_token
      save!
    end
  end

  private

  def gen_token
    # TODO: UserInvite - generate token, add check user not empty
    self.token = 'test'
  end
end

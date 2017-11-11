# Model for store user's account
class User < ApplicationRecord
  acts_as_paranoid
  acts_as_tenant :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company

  before_save :set_fullname

  # TODO: Изменить validates email для multi-tenancy
  validates :email, uniqueness: { case_sensitive: false }

  private

  def set_fullname
    self.fullname = name + ' ' + surname
  end
end

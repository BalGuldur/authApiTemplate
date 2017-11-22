require 'test_helper'

class UserInviteTest < ActiveSupport::TestCase
  test 'test user created' do
    user_invite = UserInvite.new test_user_invite_params
    assert user_invite.save, 'test user_invite not save'
  end

  test 'user_invite_test without company don\'t create' do
    user_invite = UserInvite.new test_user_invite_params
    user_invite.company = nil
    assert_not user_invite.save, 'created user_invite without company'
  end

  test 'check uniq with user email case insensivity' do
    user_invite = UserInvite.new test_user_invite_params
    user_invite.employee['email'] = users(:krulov).email.upcase
    assert_not user_invite.save, 'create user_invite with not uniq email (with user)'
  end

  test 'check uniq with user_invite email case insensivity' do
    user_invite = UserInvite.new test_user_invite_params
    user_invite.employee['email'] = user_invites(:first).employee['email'].upcase
    assert_not(
        user_invite.save,
        'create user_invite with not uniq email (with user_invite)'
    )
  end

  test 'soft delete correct' do
    puts user_invites(:first).as_json
    user_invites(:first).delete
    assert_not_nil(
      UserInvite.with_deleted.find(user_invites(:first).id),
      'soft delete don\'t work'
    )
  end

  test 'filter by company tenant' do
    ActsAsTenant.current_tenant = companies(:one)
    assert_not_nil UserInvite.find_by(id: user_invites(:first).id), 'user_invite in company not found'
    ActsAsTenant.current_tenant = companies(:two)
    assert_nil UserInvite.find_by(id: user_invites(:first).id), 'user_invite found in not his company'
    ActsAsTenant.current_tenant = nil
  end

  private

  def test_user_invite_params
    {
      employee: {
        email: 'uniq_test2@test.com',
        name: 'Aleksandr',
        surname: 'Krulov'
      },
      company: companies(:one),
      creator: users(:krulov)
    }
  end
end

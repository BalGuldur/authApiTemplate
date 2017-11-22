require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'test user created' do
    user = User.new test_user_params
    assert user.save, 'test user not save'
  end

  test 'user without company don\'t create' do
    user = User.new test_user_params
    user.company = nil
    assert_not user.save, 'created user without company'
  end

  test 'set fullname on create user' do
    user = User.new test_user_params
    if user.save
      assert_equal user.name + ' ' + user.surname, user.fullname, 'incorrect fullname on create user'
    end
  end

  test 'set fullname on update user' do
    user = users(:krulov)
    if user.save
      assert_equal user.name + ' ' + user.surname, user.fullname, 'incorrect fullname on update user'
    end
  end

  test 'check uniq user email case insensivity' do
    user = User.new test_user_params
    user.email = users(:krulov).email.upcase
    assert_not user.save
  end

  test 'soft delete correct' do
    users(:krulov).delete
    assert_not_nil User.with_deleted.find_by(users(:krulov).as_json), 'soft delete don\'t work'
  end

  test 'users filter by company tenant' do
    ActsAsTenant.current_tenant = companies(:one)
    assert_not_nil User.find_by(users(:krulov).as_json), 'user in company not found'
    ActsAsTenant.current_tenant = companies(:two)
    assert_nil User.find_by(users(:krulov).as_json), 'user found in not his company'
    ActsAsTenant.current_tenant = nil
  end

  private

  def test_user_params
    { email: 'uniq_test@test.com', name: 'Aleksandr', surname: 'Krulov', password: 'qwerty123', company: companies(:one)}
  end
end

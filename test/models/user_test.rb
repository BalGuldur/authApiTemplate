require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'test user created' do
    user = User.new test_user_params
    assert user.save, 'test user not save'
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

  test 'check uniq user email without case sensivity' do
    user = User.new test_user_params
    user.email = users(:krulov).email.upcase
    assert_not user.save
  end

  private

  def test_user_params
    { email: 'uniq_test@test.com', name: 'Aleksandr', surname: 'Krulov', password: 'qwerty123'}
  end
end

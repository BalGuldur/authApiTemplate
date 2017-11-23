require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test 'must gen token from payload' do
    payload = 'test'
    assert_instance_of String, Token.gen(payload), 'gen token return not string'
  end

  test 'decode token must equal gen payload' do
    payload = 'test'
    token = Token.gen(payload)
    assert_equal Token.decode(token), payload, 'decode token not equal gen payload'
  end
end
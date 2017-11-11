require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'soft delete correct' do
    companies(:one).delete
    assert_not_nil Company.with_deleted.find_by(companies(:one).as_json), 'soft delete don\'t work'
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:ringo)
    @user2 = users(:paul)
  end

  test "ringo user must be valid" do
    assert @user.valid?
  end

  test "must have username" do
    @user.username = nil
    assert @user.invalid?
  end

  test "must have email" do
    user = User.new
    user.username = "username"
    user.role = 0
    assert user.invalid?
  end

  test "must have role" do
    user = User.new
    user.username = "user"
    user.email = "u@ser.com"
    assert user.invalid?
  end

  test "role 1 is valid" do
    assert @user2.valid?
  end

end

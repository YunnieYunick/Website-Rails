require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    @ringo = users(:ringo)
    sign_in(@ringo)
  end

  test "signup is valid" do
    get new_staff_user_registration_path
    @user = User.new(username: 'John', email:'yunnie@gmail.com', role: 0)
    @user.encrypted_password = Devise::Encryptor.digest(User, 'password')
    @user.skip_confirmation!
    sign_in(@user)
    assert_redirected_to root_path
  end

  test "login is valid" do
    get new_staff_user_session_path
    @ringo = users(:ringo)
    sign_in(@ringo)
    assert_redirected_to root_path
  end

  test "sending confirmation instructions mail sentence is" do
    get new_staff_user_registration_path
    @user = User.new(username: 'John', email:'john@john.com', role: 0)
    @user.encrypted_password = Devise::Encryptor.digest(User, 'password')
    @user.confirm
    sign_in(@user)

    assert_redirected_to root_path
  end

end

require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    @mick = members(:Mick)
    sign_in(@mick)
  end

  test "signup is valid" do
    get new_account_member_registration_path
    @member = Member.new(username: 'John', email:'yunnie@gmail.com')
    @member.encrypted_password = Devise::Encryptor.digest(Member, 'password')
    @member.skip_confirmation!
    sign_in(@member)
    assert_redirected_to root_path
  end

end

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  setup do
    @validMember = members(:Mick)
    @invalidMember = members(:Nick)
  end

  test "member has to email" do
    @member = Member.new(email: nil)
    assert @member.invalid?
  end

  test "member has to username" do
    @no_user_name = Member.new(email: "yunnie@yunick.com", username: nil)
    assert @no_user_name.invalid?
  end

  test "username invalid length minimum 2" do
    @invalidMember.username = "y"
    assert @invalidMember.invalid?
  end

  test "username valid length minimum 2" do
    assert @validMember.valid?
  end

  test "address maxmum 20 valid" do
    @validMember.address = "sample"
    assert @validMember.valid?
  end

  test "address maxmum 20" do
    @validMember.address = "samplesamplesamplesamplesamplesample"
    assert @validMember.invalid?
  end

  test "phone maxmum 11 invalid" do
    @validMember.phone = "0900987654321"
    assert @validMember.invalid?
  end

  test "phone maxmum 11" do
    @validMember.phone = "09009876543"
    assert @validMember.valid?
  end
end

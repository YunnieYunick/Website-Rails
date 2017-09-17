require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @contact = Contact.new(message: "メッセージ")
    @email = UserMailer.contact_form(@contact).deliver_now
  end

  test "contact_form deliver" do
    assert_not ActionMailer::Base.deliveries.empty?
  end

  test "contact_form title" do
    assert_equal 'SiteNameからお問い合わせがありました', @email.subject
  end

  test "contact_form from" do
    assert_equal ['from@example.com'], @email.from
  end

  test "contact_form to" do
    assert_equal ['to@example.com'], @email.to
  end

  test "contact_form body" do
    assert_match(/メッセージ/, @email.body.to_s)
  end
end

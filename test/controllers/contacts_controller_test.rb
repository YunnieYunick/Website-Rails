require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get contacts_index_url
    assert_response :success
  end

  test "should post confirm" do
    post "/contacts/confirm", params: { contact: { name: 'name', message: 'message' } }
    assert_response :success
  end

  test "should post create" do
    post "/contacts/create", params: { contact: { name: 'テストネーム', email: 'test@example.com', message: 'メッセージ' } }
    assert_response :success

    contact_form = ActionMailer::Base.deliveries.last
 
    assert_equal "SiteNameからお問い合わせがありました", contact_form.subject
    assert_equal 'to@example.com', contact_form.to[0]
    assert_match(/テストネーム/, contact_form.body.to_s)
    assert_match(/test@example.com/, contact_form.body.to_s)
    assert_match(/メッセージ/, contact_form.body.to_s)
  end

end

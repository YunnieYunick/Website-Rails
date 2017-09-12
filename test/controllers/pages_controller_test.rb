require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Site Name"
  end

  test "should get index" do
    get root_path
    assert_response :success
    assert_select "title","Home | #{@base_title}"
  end

  test "should get about" do
    get pages_about_url
    assert_response :success
    assert_select "title","Site Nameについて | #{@base_title}"
  end

end

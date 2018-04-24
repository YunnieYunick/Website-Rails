require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in users(:ringo)
    get dashboards_index_url
    assert_response :success
  end

end

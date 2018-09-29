require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @category = categories(:TestCategory)
  end

  test "should get index" do
    get categories_url
    assert_redirected_to new_staff_user_session_path
  end

  test "should get new" do
    sign_in users(:ringo)
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in users(:ringo)
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: "Rock" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: "Jazz", slug: "jazz" } }
    assert_redirected_to category_url(@category.reload)
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end
end

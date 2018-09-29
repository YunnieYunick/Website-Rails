require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @tag = tags(:TestTag)
  end

  test "should get index" do
    sign_in users(:ringo)
    get tags_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_url
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      post tags_url, params: { tag: { name: "Summer" } }
    end

    assert_redirected_to tag_url(Tag.last)
  end

  test "should show tag" do
    get tag_url(@tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_url(@tag)
    assert_response :success
  end

  test "should update tag" do
    patch tag_url(@tag), params: { tag: { name: "Winter" } }
    assert_redirected_to tag_url(@tag.reload)
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete tag_url(@tag.reload)
    end

    assert_redirected_to tags_url
  end
end

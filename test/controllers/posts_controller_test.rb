require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_redirected_to new_staff_user_session_path
  end

  test "should get new" do
    sign_in users(:ringo)
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    sign_in users(:ringo)
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: "MyStringCreate",body: "MyText2Create",slug: "MyStringCreate" } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    sign_in users(:ringo)
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:ringo)
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    sign_in users(:ringo)
    patch post_url(@post), params: { post: { title: "Change Title", body: "MyTextEdit" } }
    assert_redirected_to post_url(@post.reload)
  end

  test "should destroy post" do
    sign_in users(:ringo)
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end

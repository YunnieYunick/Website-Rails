require 'test_helper'

class BlogControllerTest < ActionDispatch::IntegrationTest
  include Blog

  setup do
    @blog = posts(:one)
  end

  test "should get index" do
    get "/blog"
    assert_response :success
  end

  test "should show post" do
    get "/blog/MyString"
    assert_response :success
  end

  test "published_post count is 1" do
    Post.first.published
    Post.last.unpublished
    published_items
    assert_equal @published_post.count, 1
  end

  test "categories is test_category" do
    published_items
    assert_equal @categories.to_a.last.name, "test_category"
  end

  test "tags is test_category" do
    published_items
    assert_equal @tags.to_a.last.name, "test_tag2"
  end

  test "Any posts don't have tag" do
    Post.first.tag_list = ''
    Post.last.tag_list = ''
    published_items
    assert_equal @tags.empty?, true
  end

  test "Post one has one tag" do
    Post.first.tag_list = 'TestTag'
    published_items
    assert_equal @tags.pluck(:name), ["TestTag"]
  end

  test "Post one has one tag but Post two is not unpublished" do
    Post.first.tag_list = 'TestTag,TestTag2'
    Post.first.unpublished
    published_items
    assert_equal @tags.empty?, true
  end

  test "Post one has two tag" do
    Post.first.tag_list = 'TestTag,TestTag2'
    published_items
    assert_equal @tags.pluck(:name), ["TestTag","TestTag2"]
  end

  test "Post one and Post two has one same tag but Post two is not published" do
    Post.first.tag_list = 'TestTag'
    Post.last.tag_list = 'TestTag2'
    published_items
    assert_equal @tags.pluck(:name), ["TestTag"]
  end

  test "Post one and Post two has one same tag" do
    Post.first.tag_list = 'TestTag'
    Post.last.tag_list = 'TestTag'
    Post.last.published
    published_items
    assert_equal @tags.pluck(:name), ["TestTag"]
  end

  test "Post one and Post two has one different tag" do
    Post.first.tag_list = 'TestTag'
    Post.last.tag_list = 'TestTag2'
    Post.last.published
    published_items
    assert_equal @tags.pluck(:name), ["TestTag","TestTag2"]
  end

  test "Post one and Post two has two tag" do
    Post.first.tag_list = 'TestTag,TestTag2'
    Post.last.tag_list = 'TestTag,TestTag3'
    Post.last.published
    published_items
    assert_equal @tags.pluck(:name), ["TestTag","TestTag2","TestTag3"]
  end

end

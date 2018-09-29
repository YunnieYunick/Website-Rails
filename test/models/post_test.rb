require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
  end

  test "post one is valid" do
    assert @post.valid?
  end

  test "must have title" do
    new_post = Post.new(
      title: nil,
      body: "Test Body",
      slug: "slug")
    assert new_post.invalid?
  end

  test "post one category is test_category" do
    assert_equal categories(:TestCategory).name, @post.category.name
  end

  test "published post" do
    @post.published
    assert_equal true, @post.published
  end

  test "unpublished post display_day_published is Not yet" do
    @post.unpublished
    assert_includes "Not yet", @post.display_day_published
  end

  test "post one tag is test_tag" do
    assert_equal "test_tag", @post.tag_list
  end

  test "add new tag" do
    @post.tag_list = "test"
    assert_includes "test", Tag.last.name
  end

  test "tag_counts" do
    @post.tag_list = "count"
    post_tag_counts = Post.tag_counts
    assert_includes "count", post_tag_counts.last.name
  end

end

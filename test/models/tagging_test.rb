require 'test_helper'

class TaggingTest < ActiveSupport::TestCase

  setup do
    @tagging = taggings(:one)
  end

  test "one.tag.name is TestTag" do
    assert_equal tags(:TestTag).name, @tagging.tag.name
  end

  test "one.post.title is TestTag" do
    assert_equal posts(:one).title, @tagging.post.title
  end
end

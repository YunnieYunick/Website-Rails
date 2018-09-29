require 'test_helper'

class TagTest < ActiveSupport::TestCase

  setup do
    @tag = tags(:TestTag)
  end

  test "TestTag is valid" do
    assert @tag.valid?
  end

  test "invalid without name" do
    tag_test = Tag.new(name: "")
    assert tag_test.invalid?
  end
end

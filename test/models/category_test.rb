require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:TestCategory)
  end

  test "TestCategory is valid" do
    assert @category.valid?
  end

  test "invalid without name" do
    category_test = Category.new(name: "")
    assert category_test.invalid?
  end
end

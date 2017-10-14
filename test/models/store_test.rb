require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "applestore must be valid" do
    assert true
  end

  test "store has not name be invalid" do
    @store = Store.new()
    @store.name = nil
    assert @store.invalid?
  end
end

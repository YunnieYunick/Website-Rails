require 'test_helper'

class WorkTest < ActiveSupport::TestCase

  setup do
    @work = works(:one)
  end

  test "one be valid" do
    assert @work.valid?
  end

  test "work has to have start_datetime" do
    @test_work = Work.new(end_datetime: DateTime.now,store_id: 1)
    assert @test_work.invalid?
  end

  test "work has to have end_datetime" do
    @test_work = Work.new(start_datetime: DateTime.now,store_id: 1)
    assert @test_work.invalid?
  end

end

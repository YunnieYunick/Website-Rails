require 'rails_helper'

RSpec.describe Work, type: :model do
  it "is valid with start_datetime, end_datetime" do
    work = create(:work)
    work.valid?
    expect(work).to be_valid
  end

  it "is invalid without start_datetime" do
    work = build(:work, start_datetime: nil)
    work.valid?
    expect(work).to be_invalid
  end

  it "is invalid without end_datetime" do
    work = build(:work, end_datetime: nil)
    work.valid?
    expect(work).to be_invalid
  end

end

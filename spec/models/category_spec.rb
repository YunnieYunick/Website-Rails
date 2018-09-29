require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with name" do
    expect(build(:category)).to be_valid
  end

  it "is invalid without name" do
    category = build(:category, name: nil)
    expect(category).to be_invalid
  end
end

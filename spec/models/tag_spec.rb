require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "is valid with name" do
    expect(build(:tag)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:invalid_tag)).to be_invalid
  end
end

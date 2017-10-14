require 'rails_helper'

RSpec.describe Store, type: :model do
  it "is valid with name" do
    expect(build(:store)).to be_valid
  end
  it "is invalid without name" do
    store = build(:store, name: nil)
    store.valid?
    expect(store).to be_invalid
  end
end

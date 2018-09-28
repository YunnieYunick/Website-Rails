require 'rails_helper'

RSpec.describe Topic, type: :model do
  it "is a valid with title, body, slug" do
    expect(build(:topic)).to be_valid
  end

  it "is a invalid without title" do
    info = build(:topic, title: nil)
    info.valid?
    expect(info).to be_invalid
  end

  it "is a invalid without body" do
    info = build(:topic, body: nil)
    info.valid?
    expect(info).to be_invalid
  end
end

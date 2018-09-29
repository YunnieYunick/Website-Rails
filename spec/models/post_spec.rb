require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with title, body" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without title" do
    expect(build(:post, title: nil)).to be_invalid
  end
  
  it "is invalid without body" do
    expect(build(:post, body: nil)).to be_invalid
  end

  it "is valid with title length 5" do
    expect(build(:post, title: '12345')).to be_valid
  end

  it "is invalid with title length 4" do
    post = build(:post, title: '1234')
    post.valid?
    expect(post.errors[:title]).to include("は5文字以上に設定して下さい。")
  end

  it "update post attribute published true" do
    post = build(:unpublished)
    post.published(Time.now)
    expect(post.published(Time.now)).to eq(true)
  end

  it "update post attribute published false" do
    post = build(:post)
    post.unpublished
    expect(post.published_at).to eq(nil)
  end

  it "return day published" do
    post = build(:post)
    post.published(Time.now)
    expect(post.display_day_published).to eq("Published #{post.published_at.strftime('%-b %-d, %Y')}")
  end

  it "return not yet" do
    post = build(:post)
    post.unpublished
    expect(post.display_day_published).to eq("Not yet")
  end
  
end

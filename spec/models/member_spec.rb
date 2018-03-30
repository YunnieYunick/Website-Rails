require 'rails_helper'

RSpec.describe Member, type: :model do

  it "is valid with a username, email, password, password_confirmation" do
    expect(build(:member)).to be_valid
  end

  it "is invalid without username" do
    member = build(:member, username: nil)
    member.valid?
    expect(member.errors[:username]).to include("が入力されていません。")
  end

  it "is valid username length 50" do
    expect(build(:member, username: 12345678901234567890123456789012345678901234567890)).to be_valid
  end

  it "is invalid username length 51" do
    member = build(:member, username: 123456789012345678901234567890123456789012345678901)
    member.valid?
    expect(member.errors[:username]).to include("は50文字以下に設定して下さい。")
  end

  it "is invalid without email" do
    member = build(:member, email: nil)
    member.valid?
    expect(member.errors[:email]).to include("が入力されていません。")
  end

  it "is invalid with a duplicate email address" do
    member = create(:member)
    member2 = build(:member)
    member2.valid?
    expect(member2.errors[:email]).to include("は既に使用されています。")
  end

  it "is invalid without password" do
    member = build(:member, password: nil)
    member.valid?
    expect(member.errors[:password]).to include("が入力されていません。")
  end

  it "is valid password length 6" do
    expect(build(:member, password: 123456, password_confirmation: 123456)).to be_valid
  end

  it "is invalid password length 5" do
    member = build(:member, password: 12345, password_confirmation: 12345)
    member.valid?
    expect(member.errors[:password]).to include("は6文字以上に設定して下さい。")
  end

  it "is invalid with different password password_confirmation" do
    member = build(:member, password_confirmation: 123)
    member.valid?
    expect(member.errors[:password_confirmation]).to include("が内容とあっていません。")
  end

  it "is valid address length 30" do
    expect(build(:member, address: 123456789012345678901234567890)).to be_valid
  end

  it "is invalid address length 31" do
    member = build(:member, address: 1234567890123456789012345678901)
    member.valid?
    expect(member.errors[:address]).to include("は30文字以下に設定して下さい。")
  end

  it "is valid phone length 11" do
    expect(build(:member, phone: 12345678901)).to be_valid
  end

  it "is invalid phone length 12" do
    member = build(:member, phone: 123456789012)
    member.valid?
    expect(member.errors[:phone]).to include("は11文字以下に設定して下さい。")
  end

  it "is invalid with duplicate phone number" do
    member = create(:member, phone: 12345678901)
    member2 = build(:member, phone: 12345678901)
    member2.valid?
    expect(member2.errors[:phone]).to include("は既に使用されています。")
  end
end

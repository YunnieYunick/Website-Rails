require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a username, email, password, password_confirmation, role" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("が入力されていません。")
  end

  it "is valid username length 50" do
    expect(build(:user, username: 12345678901234567890123456789012345678901234567890)).to be_valid
  end

  it "is invalid username length 51" do
    user = build(:user, username: 123456789012345678901234567890123456789012345678901)
    user.valid?
    expect(user.errors[:username]).to include("は50文字以下に設定して下さい。")
  end

  it "is invalid without email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "is invalid without password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  it "is valid password length 6" do
    expect(build(:user, password: 123456, password_confirmation: 123456)).to be_valid
  end

  it "is invalid password length 5" do
    user = build(:user, password: 12345, password_confirmation: 12345)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
  end

  it "is invalid with different password password_confirmation" do
    user = build(:user, password_confirmation: 123)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("が内容とあっていません。")
  end

  it "is invalid without role" do
    user = build(:user, role: nil)
    user.valid?
    expect(user.errors[:role]).to include("が入力されていません。")
  end
end

require 'rails_helper'

feature 'User management' do
  scenario "if login user don't have any avator, display missing.png" do
    signin(:user)
    login(:user)

    visit edit_staff_user_registration_path
    within 'h1' do
      expect(page).to have_content 'アカウント設定'
    end

    expect(page).to have_xpath("//img[contains(@src,'missing.png')]")
  end

  scenario "if login user has a avator, display user avator" do
    signin(:avator)
    login(:avator)
    visit edit_staff_user_registration_path
    within 'h1' do
      expect(page).to have_content 'アカウント設定'
    end

    expect(page).to have_xpath("//img[contains(@src,'user.png')]")
  end

  scenario "if user logout, don't show logout and account link" do
    visit root_path

    expect(page).to_not have_link 'ログアウト' and 'アカウント'

    signin(:user)
    login(:user)

    expect(page).to have_link 'ログアウト' and 'アカウント'
  end
end
require 'rails_helper'

feature 'Member management' do
  scenario "if user login, don't show login link" do
    visit root_path

    expect(page).to have_link 'ログイン'

    signin_member(:member)
    login_member(:member)

    expect(page).to_not have_link 'ログイン'
  end

  scenario "if user logout, don't show logout and account link" do
    visit root_path

    expect(page).to_not have_link 'ログアウト' and 'アカウント'

    signin_member(:member)
    login_member(:member)

    expect(page).to have_link 'ログアウト' and 'アカウント'
  end
end
require 'rails_helper'

feature 'Work management' do
  scenario "show index page" do
    signin(:user)
    login(:user)

    visit works_path
    find '.h5' do
      expect(page).to have_content 'Works'
    end

    find '.h3' do
      expect(page).to have_content Date.today.month
    end

  end

  scenario "show index page without user avator" do
    signin(:user)
    login(:user)
    User.first.works << create(:work)

    visit works_path
    find '.job' do
      expect(page).to have_selector 'a', text: /^Ringo/
    end

  end

  scenario "show index page with user avator" do
    signin(:avator)
    login(:avator)
    User.first.works << create(:work)

    visit works_path
    find('.job > img') do
      expect(page).to have_css(".user_thumb")
    end

  end

  scenario "add new work on today" do
    signin(:user)
    login(:user)

    visit works_path

    find('.today > a').click

    find '.h5' do
      expect(page).to have_content '追加'
    end

    find '.h3' do
      today = Date.today
      expect(page).to have_content today.year and today.month and today.day
    end

    select '12', from:'work[start_datetime(4i)]'
    select '00', from:'work[start_datetime(5i)]'
    select '16', from:'work[end_datetime(4i)]'
    select '00', from:'work[end_datetime(5i)]'

    click_on "登録する"

    find '.alert-success' do
      expect(page).to have_content "作成しました"
    end

    find '.h5' do
      expect(page).to have_content User.first.username
    end

    find '.h3' do
      today = Date.today
      expect(page).to have_content today.year and today.month and today.day
    end

    page.all('li').first do
      expect(page).to have_content '12:00'
    end

    click_on "戻る"

    find('.today > .user') do
      expect(page).to have_content User.first.username and '12:00'
    end

  end

  scenario "show and edit" do
    signin(:user)
    login(:user)
    User.first.works << create(:work)


    visit works_path

    find('.today > .user') do
      expect(page).to have_content User.first.username
    end

    click_on(User.first.username)

    find '.h3' do
      today = Date.today
      expect(page).to have_content today.year and today.month and today.day
    end

    click_on('編集')

    find '.h5' do
      expect(page).to have_content '編集'
    end

    find '.h3' do
      today = Date.today
      expect(page).to have_content today.year and today.month and today.day
    end

    select '12', from:'work[start_datetime(4i)]'
    select '00', from:'work[start_datetime(5i)]'
    select '16', from:'work[end_datetime(4i)]'
    select '00', from:'work[end_datetime(5i)]'

    click_on "登録する"

    find '.alert-success' do
      expect(page).to have_content "更新しました"
    end

  end

  scenario "there are other user's job,can't edit" do
    signin(:user)
    login(:user)
    User.last.works << create(:work)

    user = User.create(username:'Paul', email:'paul@starr.com' , password:'secret', password_confirmation:'secret')
    user.confirm
    user.works << create(:work, start_datetime: Time.now, end_datetime: Time.now + 2)

    visit works_path

    expect(page).to have_selector 'a', text: /^Ringo/
    expect(page).to have_selector 'span', text: /^Paul/

  end

end
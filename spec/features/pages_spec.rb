require 'rails_helper'

feature 'Page management' do
  scenario "access index without create dashboard" do
    visit root_path
    
    expect(page).to have_title 'Home'

    find('.navbar-brand') do
      expect(page).to have_content 'Home'
    end

    expect(page).to have_content 'About Us'
  end

  scenario "access index with create dashboard" do
    create(:dashboard)
    visit root_path

    find('h1') do
      expect(page).to have_content 'MySiteName'
    end

    find('.lead') do
      expect(page).to have_content 'MyText'
    end

    find('.navbar-brand') do
      expect(page).to have_content 'MySiteName'
    end

    find('.footer') do
      expect(page).to have_content 'MySiteName'
    end

    expect(page).to have_content 'MySiteNameについて'
  end

  scenario "access index without create topic" do
    visit root_path

    expect(page).not_to have_content 'News'
  end

  scenario "access index with create topic" do
    signin(:user)
    login(:user)
    5.times { create(:topic) }
    
    visit root_path

    expect(page).to have_content 'New Topic'
  end

  scenario "access about without create about text" do
    visit pages_about_path

    expect(page).to have_title 'About Us'
  end

  scenario "access about without create about text" do
    visit pages_about_path

    expect(page).not_to have_content 'MySiteNameについて'

  end

  scenario "access about with create about text" do
    create(:dashboard)
    visit pages_about_path

    find('.h5') do
      expect(page).to have_content 'MySiteNameについて'
    end

    expect(page).to have_content 'About text'
  end
end
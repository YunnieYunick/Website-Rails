require 'rails_helper'

feature 'Dashboard management' do
  scenario "show index page with Dashboard empty" do
    signin(:user)
    login(:user)

    visit dashboards_path

    first '.btn' do
      expect(page).to have_css(".new")
    end
  end

  scenario "show index page with Dashboard" do
    signin(:user)
    login(:user)

    create(:dashboard)

    visit dashboards_path
    first '.btn' do
      expect(page).to have_css(".edit")
    end
  end

  scenario "show index page with Dashboard" do
    signin(:user)
    login(:user)

    create(:dashboard)

    visit dashboards_path
    expect(page).to have_content "Blog"
  end
end
require 'rails_helper'

feature 'Post management' do
  background do
  end

  scenario "user acccess index page some published post" do
    signin(:user)
    login(:user)

    visit posts_path

    within('table') do
      expect(page).to have_content 'Ringo'
    end
  end
end
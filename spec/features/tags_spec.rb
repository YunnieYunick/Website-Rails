require 'rails_helper'

feature 'Tag management' do
  background do
  end

  scenario "user acccess index page some published post" do
    @user = create(:user)
    @tag = create(:tag, name: 'Music')
    @tag.post << @user.posts

    visit root_path
    click_link 'Blog'

    find('.tag-list') do
      expect(page).to have_content 'Music'
    end

    visit tag_path(@tag.name)

    all('.blog-post-meta').last do
      expect(page).to have_content 'Music'
    end
  end
end
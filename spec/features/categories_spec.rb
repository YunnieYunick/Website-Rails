require 'rails_helper'

feature 'Category management' do
  background do
  end

  scenario "user acccess index page some published post" do
    @user = create(:user)
    create(:category, name: 'Music')
    @user.posts[0].update(category_id: Category.first.id)

    visit root_path
    click_link 'Blog'

    find('.category-list') do
      expect(page).to have_content 'Music'
    end

    visit category_path(Category.first.id)

    all('.blog-post-meta').last do
      expect(page).to have_content 'Music'
    end
  end
end
require 'rails_helper'

feature 'Blog management' do
  background do
  end

  scenario "user acccess index page some published post" do
    create(:user)

    visit root_path
    click_link 'Blog'

    first('.blog-post-meta') do
      expect(page).to have_content 'Ringo'
    end

  end

  scenario "show blog detail page" do
    create(:user)
    visit root_path
    click_link 'Blog'
    click_link '続きを読む'

    first('.blog-post-meta') do
      expect(page).to have_content 'Ringo'
    end

    first('.btn-outline-primary') do
      expect(page).to have_content '戻る'
    end

  end

  scenario "show blog archive page" do
    create(:user)
    visit root_path
    click_link 'Blog'

    first('.archives-list') do
      expect(page).to have_content Time.now.strftime('%Y-%m')
      expect(page).to have_selector("a[href='/blog/archives/#{Time.now.strftime('%Y-%m')}']")
    end
  end

  pending "hit some article when input some words on search form" do
    create(:user)
    visit root_path
    click_link 'Blog'

    @title = Post.first.title

    find('#search') do
      expect(page).to have_content "Search"
      fill_in 'search', with: @title
      click_button 'Search'
    end

    find('.blog-post-title') do
      expect(page).to have_content @title
    end
  end

  scenario "don't hit some article when input some words on search form" do
    create(:user)
    visit root_path
    click_link 'Blog'

    find('#search') do
      expect(page).to have_content "Search"
      fill_in 'search', with: 'some text'
      click_button 'Search'
    end

    expect {
      find('.blog-post-title').to raise_error(Capybara::ElementNotFound)
    }
  end

  scenario "sidebar recent post" do
    create(:user)
    visit root_path
    click_link 'Blog'

    expect {
      find('.recentposts-list li').to have_content(Post.first.title)
    }
  end

  scenario "sidebar archives post" do
    create(:user)
    visit root_path
    click_link 'Blog'

    expect {
      find('.archives-list li').to have_content(Post.first.published_at.strftime('%Y-%m'))
    }
  end
end
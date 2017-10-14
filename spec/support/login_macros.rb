include Warden::Test::Helpers

module LoginMacros
  def login_user(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    user.confirm
    sign_in user
  end
  
  def signin(user)
    user = create(user)
    login user
    user = User.first
    user.confirm
  end

  def login(user)
    visit new_staff_user_session_path
    within 'h1' do
      expect(page).to have_content 'ログイン'
    end

    fill_in '名前', with: 'Ringo'
    fill_in 'メールアドレス', with: 'ringo@starr.com'
    fill_in 'パスワード', with: 'secret'
    click_button 'ログイン'
  end
end
module LoginHelpers
  def login_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'foobar'
    click_button 'ログインする'
    expect(page).to have_content 'ログインしました'
  end
end

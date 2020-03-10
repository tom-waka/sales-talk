module LoginMacros
  def login(user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "foobar"
    click_button "ログインする"
    expect(page).to have_content "ログインしました"
  end
end
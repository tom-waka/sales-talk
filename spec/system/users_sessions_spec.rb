require 'rails_helper'

RSpec.describe "UsersSessions", type: :system do

  describe 'ログイン・ログアウト機能の確認' do
    let (:user_1) {create(:user, name: 'ユーザー1', email: 'user1@sample.com')}
    let (:admin_user) {create(:user, name: 'アドミン', email: 'admin@sample.com', admin: 'true')}

    describe 'ログイン前' do
      it 'ログイン成功' do
        visit login_path
        fill_in 'メールアドレス', with: user_1.email
        fill_in 'パスワード', with: 'foobar'
        click_button 'ログインする'
        expect(page).to have_content 'ログインしました'
      end

      it 'ログイン失敗' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'foobar'
        click_button 'ログインする'
        expect(page).to have_content 'メールアドレスかパスワードが間違っています'
      end

      it 'adminでログインしたら、ユーザー一覧のリンク有' do
        login_as(admin_user)
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq(root_path)
        expect(page).to have_link 'ユーザー一覧'
      end
    end

    describe 'ログイン後' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user_1.email
        fill_in 'パスワード', with: 'foobar'
        click_button 'ログインする'
        expect(page).to have_content 'ログインしました'          
      end
      it 'ログアウト成功' do
        click_link('ログアウト')
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(root_path)
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
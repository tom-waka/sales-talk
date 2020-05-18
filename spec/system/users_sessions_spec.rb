require 'rails_helper'

RSpec.describe "UsersSessions", type: :system do

  describe 'ログイン・ログアウト機能の確認' do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, name: 'アドミン', email: 'admin@sample.com', admin: 'true') }

    describe 'ログイン前' do
      it 'ログイン成功' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'foobar'
        click_button 'ログインする'
        find("[data-testid='flash_message']")
      end

      it 'ログイン失敗' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'foobar'
        click_button 'ログインする'
        find("[data-testid='flash_message']")
      end

      it 'adminでログインしたら、ユーザー一覧のリンク有' do
        login_as(admin_user)
        find("[data-testid='flash_message']")
        expect(current_path).to eq(root_path)
        expect(page).to have_link 'ユーザー一覧'
      end
    end

    describe 'ログイン後' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'foobar'
        click_button 'ログインする'
        find("[data-testid='flash_message']")        
      end
      it 'ログアウト成功' do
        visit user_path(user)
        click_link('ログアウト')
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(root_path)
        find("[data-testid='flash_message']")
      end
    end
  end
end

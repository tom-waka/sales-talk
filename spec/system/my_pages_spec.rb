require 'rails_helper'

RSpec.describe "MyPages", type: :system do
  describe 'マイページの挙動' do
    let(:user_1) {create(:user, name: 'ユーザー1', email: 'user1@sample.com')}
    let(:user_2) {create(:user, name: 'ユーザー2', email: 'user2@sample.com')}
    describe 'マイページの表示' do
      it '表示成功' do
        login_as(user_1)
        visit user_path(user_1)
        expect(current_path).to eq(user_path(user_1))
      end
    end

    describe '登録情報の編集' do
      it '編集成功' do
        login_as(user_1)
        visit edit_user_path(user_1)
        fill_in 'メールアドレス', with: 'edit@sample.com'
        click_button '更新する'
        expect(page).to have_content 'ユーザー情報を更新しました'
        expect(current_path).to eq(user_path(user_1))
      end

      it '別ユーザーは編集不可' do
        login_as(user_2)
        visit edit_user_path(user_1)
        expect(page).to have_content 'このURLにはアクセスできません'
        expect(current_path).to eq(root_path)
      end
    end

    describe '退会' do
      it '退会成功' do
        login_as(user_1)
        visit user_path(user_1)
        click_link '退会する'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(root_path)
        expect(page).to have_content 'ユーザー「ユーザー1」は削除されました'
        expect(User.count).to eq 0
      end
    end
  end
end

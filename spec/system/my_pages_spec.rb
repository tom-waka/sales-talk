require 'rails_helper'

RSpec.describe "MyPages", type: :system do
  describe 'マイページの挙動' do
    let (:user_1) {create(:user)}
    let (:user_2) {create(:user)}
    let (:admin_user) {create(:user, name: 'アドミン', email: 'admin@sample.com', admin: 'true')}
    let (:tester) {create(:user, name: 'テストユーザー', email: 'test@sample.com', test_user: 'true')}
    
    context 'マイページの表示' do
      it '表示成功' do
        login_as(user_1)
        visit user_path(user_1)
        expect(current_path).to eq(user_path(user_1))
      end
    end

    describe '登録情報の編集' do
      context '自分の登録情報を編集' do
        it '編集成功' do
          login_as(user_1)
          visit edit_user_path(user_1)
          fill_in 'メールアドレス', with: 'edit@sample.com'
          click_button '更新する'
          expect(page).to have_content 'ユーザー情報を更新しました'
          expect(current_path).to eq(user_path(user_1))
        end
      end

      context '別ユーザーを編集しようとした時' do
        it '編集リンクの表示なし' do
          login_as(user_2)
          visit user_path(user_1)
          expect(current_path).to eq(user_path(user_1))
          expect(page).to have_no_link '登録情報を編集する'
        end

        it '編集ページへアクセス不可' do
          login_as(user_2)
          visit edit_user_path(user_1)
          expect(page).to have_content 'このURLにはアクセスできません'
          expect(current_path).to eq(root_path)
        end
      end

      context 'adminでログインした時' do
        it '編集成功' do
          login_as(admin_user)
          visit edit_user_path(user_1)
          fill_in 'メールアドレス', with: 'edit@sample.com'
          click_button '更新する'
          expect(page).to have_content 'ユーザー情報を更新しました'
          expect(current_path).to eq(user_path(user_1))
        end
      end

      context 'テストユーザーでログインした時' do
        it '編集リンクの表示なし' do
          login_as(tester)
          visit user_path(tester)
          expect(current_path).to eq(user_path(tester))
          expect(page).to have_no_link '登録情報を編集する'
        end

        it '編集ページへアクセス不可' do
          login_as(tester)
          visit edit_user_path(tester)
          expect(page).to have_content 'テストユーザーの情報は編集できません'
          expect(current_path).to eq(user_path(tester))
        end
      end

    end

    describe 'ユーザーの削除' do
      context '退会しようとした時' do
        it '退会成功' do
          login_as(user_1)
          visit user_path(user_1)
          click_link '退会する'
          page.driver.browser.switch_to.alert.accept
          expect(current_path).to eq(root_path)
          expect(page).to have_content 'は削除されました'
          expect(User.count).to eq 0
        end
      end

      context '別ユーザーを退会させようとした時' do
        it '退会リンクの表示なし' do
          login_as(user_2)
          visit user_path(user_1)
          expect(current_path).to eq(user_path(user_1))
          expect(page).to have_no_button '退会する'
        end
      end

      context 'adminでログインした時' do
        it '削除成功' do
          login_as(admin_user)
          visit user_path(user_1)
          click_link 'ユーザーを削除する'
          page.driver.browser.switch_to.alert.accept
          expect(current_path).to eq(users_path)
          expect(page).to have_content 'は削除されました'
          expect(User.count).to eq 1
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Follow', type: :system do
  describe 'フォロー機能のテスト' do
    let (:user_1) {create(:user)}
    let (:user_2) {create(:user)}

    context 'ログイン時の挙動' do
      before do
        login_as(user_1)
        visit user_path(user_2)
        click_button 'フォローする'
        visit user_path(user_2)
      end

      it 'フォロー成功' do
        expect(user_1.following.count).to eq 1
      end

      it 'フォロー解除成功' do
        click_button 'フォロー中'
        visit user_path(user_2)
        expect(user_1.following.count).to eq 0
      end

      context 'フォローユーザーの表示' do
        it 'フォロー中のユーザーを表示' do
          visit following_user_path(user_1)
          expect(page).to have_link "#{user_2.name}"
        end

        it 'フォロワー一覧を表示' do
          visit followers_user_path(user_2)
          expect(page).to have_link "#{user_1.name}"
        end

        context 'フォローユーザーがいない場合' do
          it 'フォロー中のユーザーが表示されない' do
            visit following_user_path(user_2)
            expect(page).to have_css '.no_following'
          end

          it 'フォロワーが表示されない' do
            visit followers_user_path(user_1)
            expect(page).to have_css '.no_following'
          end          
        end
      end
    end

    context 'ログアウト時の挙動' do
      it '「フォローするボタン」が非表示' do
        visit user_path(user_1)
        have_no_button 'フォローする'
      end

      it '「フォロー中ボタン」が非表示' do
        visit user_path(user_1)
        have_no_button 'フォロー中'
      end
    end
  end
end
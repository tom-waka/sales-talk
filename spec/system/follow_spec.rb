require 'rails_helper'

RSpec.describe 'Follow', type: :system do
  describe 'フォロー機能のテスト' do
    let (:user_1) {create(:user)}
    let (:user_2) {create(:user)}

    context 'ログイン時の挙動' do
      it 'フォロー成功' do
        login_as(user_1)
        visit user_path(user_2)
        click_button 'フォローする'
        visit user_path(user_2)
        expect(user_1.following.count).to eq 1
      end

      it 'フォロー解除成功' do
        login_as(user_1)
        visit user_path(user_2)
        click_button 'フォローする'
        visit user_path(user_2)
        click_button 'フォロー中'
        visit user_path(user_2)
        expect(user_1.following.count).to eq 0
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
require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe '記事関連の挙動' do
    let (:user_1) {create(:user, name: 'ユーザー1', email: 'user1@sample.com')}
    let (:user_2) {create(:user, name: 'ユーザー2', email: 'user2@sample.com')}
    let (:article_1) {create(:article, title: 'タイトル1', user: user_1)}

    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: 'foobar'
      click_button 'ログインする'
      expect(page).to have_content 'ログインしました'
    end

    describe '記事の新規投稿' do
      let(:login_user){ user_1 }
      context 'フォームが正しい場合' do
        it '投稿成功' do
          visit new_article_path
          fill_in 'article[title]', with: 'タイトルを入力'
          fill_in 'article[content]', with: '内容を入力'
          click_button '投稿する'
          expect(page).to have_content '記事を投稿しました'
        end
      end

      context 'フォームが正しくない場合' do
        it 'タイトル未入力のため投稿失敗' do
          visit new_article_path
          fill_in 'article[title]', with: ''
          fill_in 'article[content]', with: '内容を入力'
          click_button '投稿する'
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end

    describe '記事の詳細表示' do
      let(:login_user){ user_1 }
      context '記事が存在する場合' do
        it '表示成功' do
          visit article_path(article_1)
          expect(page).to have_content 'タイトル1'
        end
      end
    end
      
    describe '記事の編集' do
      context 'ユーザーがログインしている場合' do
        let(:login_user){ user_1 }
        it '編集成功' do
          visit edit_article_path(article_1)
          fill_in 'article[title]', with: 'タイトルを編集'
          fill_in 'article[content]', with: '内容を編集'
          click_button '更新する'
          expect(page).to have_content '記事を更新しました'
        end
      end

    end
  end
end

require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe '記事のCRUD' do
    let (:user_1) {create(:user, name: 'ユーザー1', email: 'user1@sample.com')}
    let (:user_2) {create(:user, name: 'ユーザー2', email: 'user2@sample.com')}
    let (:admin_user) {create(:user, name: 'アドミン', email: 'admin@sample.com', admin: 'true')}
    let (:article_1) {create(:article, title: 'タイトル1', user: user_1)}


    describe '記事の新規投稿' do
      context '成功時の挙動' do
        it '投稿成功' do
          login_as(user_1)
          visit new_article_path
          fill_in 'article[title]', with: 'タイトルを入力'
          fill_in 'article[content]', with: '内容を入力'
          click_button '投稿する'
          expect(page).to have_content '記事を投稿しました'
          expect(Article.count).to eq 1
        end
      end

      context '失敗時の挙動' do
        it 'タイトル未入力のため投稿失敗' do
          login_as(user_1)
          visit new_article_path
          fill_in 'article[title]', with: ''
          fill_in 'article[content]', with: '内容を入力'
          click_button '投稿する'
          expect(page).to have_content 'タイトルを入力してください'
        end

        it 'ログイン前のため失敗' do
          visit new_article_path
          expect(current_path).to eq(login_path)
          expect(page).to have_content 'ログインをしてください'
        end
      end
    end

    describe '記事の詳細表示' do
      context '記事が存在する場合' do
        it '表示成功' do
          visit article_path(article_1)
          expect(page).to have_content 'タイトル1'
        end
      end

      context '「一覧へ戻る」の変遷確認' do
        it 'root_pathへ戻る' do
          visit root_path
          visit article_path(article_1)
          click_link('一覧へ戻る')
          expect(current_path).to eq(root_path)
        end

        it 'ユーザーページへ戻る' do
          visit user_path(user_1)
          visit article_path(article_1)
          click_link('一覧へ戻る')
          expect(current_path).to eq(user_path(user_1))
        end
      end
    end
      
    describe '記事の編集' do
      context 'ログインしている場合' do
        it '編集成功' do
          login_as(user_1)
          visit edit_article_path(article_1)
          fill_in 'article[title]', with: 'タイトルを編集'
          fill_in 'article[content]', with: '内容を編集'
          click_button '更新する'
          expect(page).to have_content '記事を更新しました'
        end

        it '他ユーザーの記事は編集不可' do
          login_as(user_2)
          visit edit_article_path(article_1)
          expect(current_path).to eq(root_path)
          expect(page).to have_content 'このURLにはアクセスできません'
        end
      end

      context 'adminとしてログインした場合' do
        it 'adminユーザーは編集リンクが表示される' do
          login_as(admin_user)
          visit article_path(article_1)
          expect(page).to have_link '編集'
        end

        it 'adminユーザーは他ユーザー記事の編集可能' do
          login_as(admin_user)
          visit edit_article_path(article_1)
          fill_in 'article[title]', with: 'タイトルを編集'
          fill_in 'article[content]', with: '内容を編集'
          click_button '更新する'
          expect(page).to have_content '記事を更新しました'
        end
      end

      context 'ログイン前' do
        it '編集リンクが表示されない' do
          visit article_path(article_1)
          expect(page).to have_no_link '編集'
        end

        it '編集ページへアクセス不可' do
          visit edit_article_path(article_1)
          expect(current_path).to eq(login_path)
          expect(page).to have_content 'ログインをしてください'
        end
      end
    end

    describe '記事の削除' do
      context 'ログインしている場合' do
        it '削除成功' do
          login_as(user_1)
          visit article_path(article_1)
          click_link('削除')
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '記事を削除しました'
          expect(Article.count).to eq 0 
        end
      end

      context 'adminとしてログインしている場合' do
        it 'adminユーザーは編集リンクが表示される' do
          login_as(admin_user)
          visit article_path(article_1)
          expect(page).to have_link '削除'
        end

        it 'adminユーザーは他ユーザーの記事を削除可能' do
          login_as(admin_user)
          visit article_path(article_1)
          click_link('削除')
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '記事を削除しました'
          expect(Article.count).to eq 0 
        end
      end

      context 'ログイン前' do
        it '削除リンクが表示されない' do
          visit article_path(article_1)
          expect(page).to have_no_link '削除'
        end
      end
    end

  end
end

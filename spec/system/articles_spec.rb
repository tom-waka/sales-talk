require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe '記事関連の検証' do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:admin_user) { create(:user, name: 'アドミン', email: 'admin@sample.com', admin: 'true') }
    let(:tester) { create(:user, name: 'テストユーザー', email: 'test@sample.com', test_user: 'true') }
    let(:article_1) { create(:article, title: 'タイトル1', user: user_1, category: category_1) }
    let(:article_2) { create(:article, title: 'タイトル2', user: user_1, category: category_1) }
    let(:article_3) { create(:article, title: 'タイトル3', user: user_1, category: category_2) }
    let(:article_test) { create(:article, title: 'テストユーザーの投稿', user: tester) }
    let!(:category_1) { create(:category) }
    let!(:category_2) { create(:category, name: '映像') }
    let!(:category_3) { create(:category, name: '音楽') }

    describe '記事の新規投稿' do
      context '成功時の挙動' do
        it '投稿成功' do
          login_as(user_1)
          visit new_article_path
          fill_in 'article[title]', with: 'タイトルを入力'
          fill_in 'article[content]', with: '内容を入力'
          choose '本'
          click_button '投稿する'
          find("[data-testid='flash_message']")
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
          find("[data-testid='flash_message']")
        end

        it '他ユーザーの記事は編集不可' do
          login_as(user_2)
          visit edit_article_path(article_1)
          expect(current_path).to eq(root_path)
          find("[data-testid='flash_message']")
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
          find("[data-testid='flash_message']")
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
          find("[data-testid='flash_message']")
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
          find("[data-testid='flash_message']")
          expect(Article.count).to eq 0
        end
      end

      context 'adminとしてログインしている場合' do
        it 'adminユーザーは削除リンクが表示される' do
          login_as(admin_user)
          visit article_path(article_1)
          expect(page).to have_link '削除'
        end

        it 'adminユーザーは他ユーザーの記事を削除可能' do
          login_as(admin_user)
          visit article_path(article_1)
          click_link('削除')
          page.driver.browser.switch_to.alert.accept
          find("[data-testid='flash_message']")
          expect(Article.count).to eq 0
        end
      end

      context 'テストユーザーとしてログインしている場合' do
        it 'テストユーザーは削除リンクが表示されない' do
          login_as(tester)
          visit article_path(article_test)
          expect(page).to have_no_link '削除'
        end
      end

      context 'ログイン前' do
        it '削除リンクが表示されない' do
          visit article_path(article_1)
          expect(page).to have_no_link '削除'
        end
      end
    end

    describe '検索機能の検証' do
      before do
        article_1
        article_2
        article_3
        visit articles_path
      end

      context 'キーワード検索' do
        it '合致した記事だけ表示' do
          fill_in 'q[title_or_content_cont]', with: 'タイトル1'
          click_button '検索'
          expect(page).to have_link 'タイトル1'
          expect(page).to have_no_link 'タイトル2'
        end

        it '記事が見つからない時、メッセージを表示' do
          fill_in 'q[title_or_content_cont]', with: 'タイトル4'
          click_button '検索'
          expect(page).to have_no_selector '.article-item'
          find("[data-testid='no_articles']")
        end
      end

      context 'カテゴリー検索' do
        it '合致した記事だけ表示' do
          select '本', from: 'カテゴリー', match: :first
          click_button '検索'
          expect(page).to have_link 'タイトル1'
          expect(page).to have_no_link 'タイトル3'
        end

        it '記事が見つからない時、メッセージを表示' do
          select '音楽', from: 'カテゴリー', match: :first
          click_button '検索'
          expect(page).to have_no_selector '.article-item'
          find("[data-testid='no_articles']")
        end
      end

      context 'キーワード×カテゴリー検索' do
        it '合致した記事だけ表示' do
          fill_in 'q[title_or_content_cont]', with: 'タイトル1'
          select '本', from: 'カテゴリー', match: :first
          click_button '検索'
          expect(page).to have_link 'タイトル1'
          expect(page).to have_no_link 'タイトル2'
        end

        it '記事が見つからない時、メッセージを表示' do
          fill_in 'q[title_or_content_cont]', with: '不一致'
          select '本', from: 'カテゴリー', match: :first
          click_button '検索'
          expect(page).to have_no_selector '.article-item'
          find("[data-testid='no_articles']")
        end
      end
    end
  end
end

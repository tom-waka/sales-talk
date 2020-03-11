require 'rails_helper'

RSpec.describe "Articles", type: :system do

  let(:user) {create(:user)}
  let(:article) {build(:article)}

  it "ユーザーが新しい記事を投稿" do
    login(user)
    visit new_article_path
    fill_in 'article[title]', with: article.title
    fill_in "article[content]", with: article.content
    click_button "投稿する"
    expect(page).to have_content "記事を投稿しました" 
    expect(Article.count).to eq 1
  end

  it "ユーザーが記事を編集" do
    login(user)
    visit edit_article_path(article)
    fill_in 'article[title]', with: "編集後のタイトル"
    fill_in "article[content]", with: "編集後のコンテント"
    click_button "更新する"
    expect(page).to have_content "記事を更新しました" 
    expect(current_path).to eq article_path(article)
    expect(Article.count).to eq 1
  end

end

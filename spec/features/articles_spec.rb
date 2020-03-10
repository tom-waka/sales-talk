require 'rails_helper'

RSpec.feature "Articles", type: :feature do

  let(:user) {create(:user)}
  let(:article) {build(:article)}

  scenario "ユーザーが新しい記事を投稿" do
    login(user)
    visit new_article_path
    fill_in 'article[title]', with: article.title
    fill_in "article[content]", with: article.content
    click_button "投稿する"
    expect(page).to have_content "記事を投稿しました" 
    expect(Article.count).to eq 1
  end

end

require 'rails_helper'

RSpec.describe "Likes", type: :system do
  describe 'いいねのテスト' do
    let (:user){create(:user)}
    let (:article){create(:article)}
    context 'ログイン時' do
      it 'いいね成功' do
        login_as(user)
        visit article_path(article)
        find('.fa-heart').click
        expect(page).to have_selector '.counter', text: '1'
      end
    end
  end
end

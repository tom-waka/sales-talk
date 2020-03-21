require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'バリデーション' do

    context '記事が有効な場合' do
      it "投稿成功" do
        article = create(:article)
        expect(article).to be_valid
      end
    end

    context '記事が無効な場合' do
      it "タイトルが未入力のため無効" do
        article = build(:article, title: '')
        expect(article.valid?).to eq(false)
        expect(article.errors[:title]).to include("を入力してください")
      end

      it "タイトルが50文字以上のため無効" do
        article = build(:article, title: "a"*51)
        expect(article.valid?).to eq(false)
        expect(article.errors[:title]).to include("は50文字以内で入力してください")
      end

      it "カテゴリが未選択のため無効" do
        article = build(:article, category: nil)
        expect(article.valid?).to eq(false)
        expect(article.errors[:category]).to include("を入力してください")
      end
    end

  end

end

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "バリデーション" do
    context "有効な場合" do
      it "登録成功" do
        category = create(:category)
        expect(category).to be_valid
      end
    end

    context "無効な場合" do
      it "登録失敗" do
        category = build(:category, name: '')
        expect(category.valid?).to eq(false)
      end
    end
  end
end

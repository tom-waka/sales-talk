require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "バリデーション" do
    let! (:user_1) {create(:user)}
    let! (:user_2) {create(:user)}
    context "有効な場合" do
      it "登録成功" do
        relationship = build(:relationship ,follower_id: user_1.id, followed_id: user_2.id)
        expect(relationship).to be_valid
      end
    end

    context "無効な場合" do
      it "follower_idがnilのため登録失敗" do
        relationship = build(:relationship ,follower_id: nil, followed_id: user_2.id)
        expect(relationship.valid?).to eq(false)
      end

      it "followed_idがnilのため登録失敗" do
        relationship = build(:relationship ,follower_id: user_1.id, followed_id: nil)
        expect(relationship.valid?).to eq(false)
      end
    end
  end
end

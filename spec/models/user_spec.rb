require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'バリデーション' do

    context '登録情報が有効な場合' do
      it "登録成功" do
        user = build(:user)
        expect(user).to be_valid
      end
    end
      
    context '登録情報が無効な場合' do
      it "名前が未入力のため無効" do
        user = build(:user, name: '')
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "名前が31文字以上のため無効" do
        user = build(:user, name: "a"*31)
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("は30文字以内で入力してください")
      end

      it "メールアドレスが未入力のため無効" do
        user = build(:user, email: '')
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "メールアドレスが重複のため無効" do
        user1 = create(:user)
        user2 = build(:user, email: user1.email)
        expect(user2.valid?).to eq(false)
        expect(user2.errors[:email]).to include("がすでに使用されています")
      end

      it "パスワードが未入力のため無効" do
        user = build(:user, password: '')
        expect(user.valid?).to eq(false)
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "パスワードが６文字未満のため無効" do
        user = build(:user, password: "fooba")
        expect(user.valid?).to eq(false)
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "パスワードの再入力が合致しないため無効" do
        user = build(:user, password_confirmation: "hogehoge" )
        expect(user.valid?).to eq(false)
        expect(user.errors[:password_confirmation]).to include("が再入力されたものと一致しません")
      end
    end
  end
end

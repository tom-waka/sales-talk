require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do

    context '登録情報が有効な場合' do
      it "登録成功" do
        user = User.new(
          name:     "tom",
          email:    "foobar@sample.com",
          password: "foobar",
        )
        expect(user).to be_valid
      end
    end
      
    context '登録情報が無効な場合' do
      it "名前が未入力" do
        user = User.new(name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "メールアドレスが重複" do
        User.create(
          name:     "tom",
          email:    "foobar@sample.com",
          password: "foobar",
        )

        user = User.new(
          name:     "kevin",
          email:    "foobar@sample.com",
          password: "hogehoge",
        )
        user.valid?
        expect(user.errors[:email]).to include("がすでに使用されています")
      end
    end
  end
end

FactoryBot.define do
  factory :user do
    sequence(:name)  { 'テストユーザー' }
    sequence(:email) { 'test@sample.com' }
    password {"foobar"}
    password_confirmation {"foobar"}
  end
end

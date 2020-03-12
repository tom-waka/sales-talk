FactoryBot.define do
  factory :user do
    sequence(:name)  { 'テストユーザー' }
    sequence(:email) { 'user@sample.com' }
    password {"foobar"}
    password_confirmation {"foobar"}
  end
end

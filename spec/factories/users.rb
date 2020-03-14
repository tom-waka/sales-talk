FactoryBot.define do
  factory :user do
    name  { 'テストユーザー' }
    email { 'user@sample.com' }
    password {"foobar"}
    password_confirmation {"foobar"}
    admin { 'false' }
  end
end

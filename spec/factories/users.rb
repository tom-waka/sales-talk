FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "user#{n}"}
    sequence(:email) { |n| "foobar#{n}@sample.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
  end
end

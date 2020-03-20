FactoryBot.define do
  factory :user do
    sequence(:name){|n| "user_#{n}"}
    sequence(:email){|n| "mail_#{n}@sample.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
    admin { 'false' }
    test_user {'false'}
  end
end

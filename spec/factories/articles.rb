FactoryBot.define do
  factory :article do
    sequence(:id)  { |n| "#{n}"}
    title {"title"}
    content {"content"}
    user
  end
end

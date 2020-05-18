FactoryBot.define do
  factory :article do
    title { "title" }
    content { "content" }
    category
    user
  end
end

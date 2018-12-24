FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "khoerodin #{n}" }
    name { "Khoerodin" }
    url { "http://example.com" }
    avatar_url { "http://example.com" }
    provider { "github" }
  end
end

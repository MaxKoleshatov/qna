FactoryBot.define do
  factory :question do
    title { "MyStringQuestion" }
    body { "MyText" }
    association :user, factory: :user

    trait :invalid do
      title {nil}
    end
  end
end

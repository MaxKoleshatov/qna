FactoryBot.define do
  factory :answer do
    text { "MyStringAnswer" }
    question { nil }
    association :user, factory: :user

    trait :invalid do
      text {nil}
    end
  end
end

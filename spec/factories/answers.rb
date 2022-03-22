FactoryBot.define do
  factory :answer do
    text { "MyStringAnswer" }
    question
    user

    trait :invalid do
      text {nil}
    end
  end
end

FactoryBot.define do
  factory :answer do
    text { "MyString" }
    question { nil }

    trait :invalid do
      text {nil}
    end
  end
end

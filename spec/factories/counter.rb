FactoryBot.define do
  factory :counter_question, class: Counter do
    association :user, factory: :user
    counterable { |obj| obj.association(:question) }
    value { 0 }
  end
  
  factory :counter_answer, class: Counter do
    association :user, factory: :user
    counterable { |obj| obj.association(:answer) }
    value { 0 }
  end
end
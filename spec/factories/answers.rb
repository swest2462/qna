FactoryGirl.define do
  factory :answer do
    body "MyText"
    question ""
    association :question
  end
end

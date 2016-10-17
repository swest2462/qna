FactoryGirl.define do
  factory :answer do
    association(:question)
    body 'Answer body'
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
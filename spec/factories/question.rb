FactoryGirl.define do
  sequence :title do |n|
     "Test title #{n}"
   end

 factory :question do
   user
   title
   body 'Good question body'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@mail.com"
  end

  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
  end

  factory :another_user, class: 'User' do
    email
    password '12345678'
    password_confirmation '12345678'
  end
end
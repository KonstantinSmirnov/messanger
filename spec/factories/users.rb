# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'User'
    email 'user@user.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :recipient, class: 'User' do
    name 'User recipient'
    email 'user@recipient.com'
    password 'password'
    password_confirmation 'password'
  end
end

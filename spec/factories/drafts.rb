# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :draft do
    recipient_email "MyString"
    topic "MyString"
    text "MyText"
    association :user, factory: :user
  end
end

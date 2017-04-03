# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    association :sender, factory: :user 
    association :recipient, factory: :recipient
    topic "MyString"
    text "MyText"
  end
end

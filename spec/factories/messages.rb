# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user 
    topic "MyString"
    text "MyText"
  end
end

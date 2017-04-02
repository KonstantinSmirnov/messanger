require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has a valid factory' do
    message = FactoryGirl.create(:message)

    expect(message).to be_valid
  end

  it 'is invalid without user' do
    message = FactoryGirl.build(:message, user: nil)

    expect(message).not_to be_valid
    expect(message.errors[:user]).to include("can't be blank")
  end

  it 'is invalid without topic' do
    message = FactoryGirl.build(:message, topic: nil)

    expect(message).not_to be_valid
    expect(message.errors[:topic]).to include("can't be blank")
  end

  it 'is invalid without message' do
    message = FactoryGirl.build(:message, text: nil)

    expect(message).not_to be_valid
    expect(message.errors[:text]).to include("can't be blank")
  end
end

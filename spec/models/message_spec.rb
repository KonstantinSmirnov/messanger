require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:recipient) { FactoryGirl.create(:recipient, email: 'recipient_message_spec@test.com') }

  it 'has a valid factory' do
    message = FactoryGirl.build(:message)
    message.recipient_email = recipient.email

    expect(message).to be_valid
  end

  it 'is invalid without user' do
    message = FactoryGirl.build(:message, sender: nil)
    message.recipient_email = recipient.email

    expect(message).not_to be_valid
    expect(message.errors[:sender]).to include("can't be blank")
  end

  it 'is invalid without topic' do
    message = FactoryGirl.build(:message, topic: nil)
    message.recipient_email = recipient.email

    expect(message).not_to be_valid
    expect(message.errors[:topic]).to include("can't be blank")
  end

  it 'is invalid without message' do
    message = FactoryGirl.build(:message, text: nil)
    message.recipient_email = recipient.email

    expect(message).not_to be_valid
    expect(message.errors[:text]).to include("can't be blank")
  end

  it 'has is_read? = false by default' do
    message = FactoryGirl.build(:message)
    message.recipient_email = recipient.email

    expect(message.is_read?).to eq(false)
  end

  it 'has is_read?  = true after when message is open' do
    message = FactoryGirl.build(:message)
    message.recipient_email = recipient.email

    message.read!

    expect(message.is_read?).to eq(true)
  end
end

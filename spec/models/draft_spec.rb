require 'rails_helper'

RSpec.describe Draft, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it 'has a valid factory' do
    draft = FactoryGirl.create(:draft, user: user)

    expect(draft).to be_valid
  end

  it 'is invalid with all fields empty' do
    draft = Draft.new(user: user)

    expect(draft).not_to be_valid
    expect(draft.errors[:base]).to include('At least one field should contain text')
  end

  it 'is valid without recipient_email' do
    draft = FactoryGirl.create(:draft, user: user, recipient_email: nil)
    
    expect(draft).to be_valid
  end

  it 'is valid without topic' do
    draft = FactoryGirl.create(:draft, user: user, topic: nil)
    
    expect(draft).to be_valid
  end

  it 'is valid without text' do
    draft = FactoryGirl.create(:draft, user: user, text: nil)

    expect(draft).to be_valid
  end

  it 'is invalid without user' do
    draft = FactoryGirl.build(:draft, user: nil)

    expect(draft).not_to be_valid
    expect(draft.errors[:user]).to include("can't be blank")
  end
end

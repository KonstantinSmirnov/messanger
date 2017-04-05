require 'rails_helper'
include UserAuthentication

feature 'DRAFT MESSAGE' do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_user_with(user.email, 'password')
  end

  scenario 'unable to create empty draft' do
    visit new_user_message_path(user)

    click_button 'Save as a draft'
    
    expect(page).to have_selector('.alert', text: "Can't save empty draft")
    expect(current_path).to eq(new_user_message_path(user))
  end

  scenario 'create draft' do
    visit new_user_message_path(user)

    fill_in 'message_text', with: 'test text'
    click_button 'Save as a draft'

    expect(page).to have_selector('.alert', text: 'Draft has been saved')
  end

  scenario 'see draft on drafts page'

  scenario 'can delete draft'

  scenario 'can send draft as a message'

  scenario 'after sending draft as a message, draft to be removed'
end

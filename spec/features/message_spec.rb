require 'rails_helper'
include UserAuthentication

feature 'MESSAGE' do
  let(:user) { FactoryGirl.create(:user, password: 'password', password_confirmation: 'password') }
  let!(:recipient) { FactoryGirl.create(:recipient) }

  context 'form validation' do
    before(:each) do
      login_user_with(user.email, 'password')
      visit new_user_message_path(user)
    end  

    scenario 'fails without recipient email' do
      fill_in 'message_topic', with: 'test topic'
      fill_in 'message_text', with: 'test text'
      click_button 'Send'

      expect(page).to have_selector('.message_recipient_email.has-error span.help-block', text: "can't be blank")
    end

    scenario 'fails if recipient does not exist' do
      fill_in 'message_recipient_email', with: 'not@existing.email'
      fill_in 'message_topic', with: 'test topic'
      fill_in 'message_text', with: 'test text'
      click_button 'Send'

      expect(page).to have_selector('.message_recipient_email.has-error span.help-block', text: "User with email not@existing.email does not exist")
    end

    scenario 'fails without topic' do
      fill_in 'message_recipient_email', with: 'test@test.com'
      fill_in 'message_text', with: 'test text'
      click_button 'Send'

      expect(page).to have_selector('.message_topic.has-error span.help-block', text: "can't be blank")
    end

    scenario 'fails without text' do
      fill_in 'message_recipient_email', with: 'test@test.com'
      fill_in 'message_topic', with: 'test topic'
      click_button 'Send'

      expect(page).to have_selector('.message_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'created with valid data' do
      fill_in 'message_recipient_email', with: recipient.email
      fill_in 'message_topic', with: 'test topic'
      fill_in 'message_text', with: 'test text'
      click_button 'Send'

      expect(page).to have_selector('.alert.alert-success', text: "Message was successfully sent")
    end

  end
end

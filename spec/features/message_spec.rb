require 'rails_helper'
include UserAuthentication

feature 'MESSAGE' do
  let(:user) { FactoryGirl.create(:user, password: 'password', password_confirmation: 'password') }

  context 'form validation' do
    before(:each) do
      login_user_with(user.email, 'password')
      visit new_user_message_path(user)
    end  

    scenario 'fails without topic' do
      fill_in 'message_text', with: 'test text'
      click_button 'Send'

      expect(page).to have_selector('.message_topic.has-error span.help-block', text: "can't be blank")
    end

    scenario 'fails without text' do
      fill_in 'message_topic', with: 'test topic'
      click_button 'Send'

      expect(page).to have_selector('.message_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'created with valid data' do
      fill_in 'message_topic', with: 'test topic'
      fill_in 'message_text', with: 'test text'
      click_button 'Send'

      expect(page).to have_selector('.alert.alert-success', text: "Message was successfully sent")
    end

  end
end

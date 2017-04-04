require 'rails_helper'
include UserAuthentication

feature 'INBOX MESSAGES' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:recipient) }  
  
  before(:each) do
    login_user_with(recipient.email, 'password')
  end

  context 'Navbar' do
    scenario 'inbox label shows unread messages count' do
      3.times do
        message = FactoryGirl.build(:message, sender: user, recipient: recipient)
        message.recipient_email = recipient.email
        message.save
      end

      visit user_messages_path(recipient)

      expect(page).to have_selector('li.nav-item a.nav-link', text: 'Inbox 3')
    end

    scenario 'inbox label shows messages count without read messages' do
      3.times do
        message = FactoryGirl.build(:message, sender: user, recipient: recipient)
        message.recipient_email = recipient.email
        message.save
      end
      recipient.received_messages.last.read!

      visit user_messages_path(recipient)

      expect(page).to have_selector('li.nav-item a.nav-link', text: 'Inbox 2')
    end
  end

  context 'index view' do
    before(:each) do
      @message = FactoryGirl.build(:message, sender: user, recipient: recipient)
      @message.recipient_email = recipient.email
      @message.save

      visit user_messages_path(recipient)
    end
      
    scenario 'can see inbox messages' do
      expect(page).to have_selector('tr td a', text: @message.topic)
    end

    scenario 'unread messages have unread icon' do
      expect(page).to have_selector('tr td i.fa.fa-circle')
    end

    scenario 'read messages have read icon' do
      @message.read!
      visit user_messages_path(recipient)

      expect(page).to have_selector('tr td i.fa.fa-circle-thin')
    end

    scenario 'can open message' do
      click_link @message.topic

      expect(page).to have_selector('h1', text: @message.topic)
    end

    scenario 'message is read when is open' do
      click_link @message.topic
      visit user_messages_path(recipient)

      expect(page).to have_selector('tr td i.fa.fa-circle-thin')
    end

    scenario 'can remove message'

  end
end

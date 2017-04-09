require 'rails_helper'
include UserAuthentication

feature 'SENT MESSAGES' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:recipient) }

  before(:each) do
    login_user_with(user.email, 'password')

    @message = FactoryGirl.build(:message, sender: user, recipient: recipient)
    @message.recipient_email = recipient.email
    @message.save

    visit user_messages_path(user, outbox: true)
  end

  context 'Navbar' do
    scenario 'outbox link is active when on outbox page' do
      visit user_messages_path(user, outbox: true)

      expect(page).to have_selector('.nav-item.active', text: 'Sent')
    end
  end

  context 'index view' do

    scenario 'can see outbox messages' do
      expect(page).to have_selector('tr td', text: @message.topic)
    end

    scenario 'unread by recipient messages have unread icon' do
      expect(page).to have_selector('tr td i.fa.fa-dot-circle-o')
    end

    scenario 'read by recipient messages have read icon' do
      @message.read!

      visit user_messages_path(user, outbox: true)
      expect(page).to have_selector('tr td i.fa.fa-circle-thin')
    end

    scenario 'can open message', js: true do
      first("tr[data-link=\"#{user_message_path(@message.sender, @message)}\"] td").click

      expect(page).to have_selector('h1', text: @message.topic)
    end

    scenario 'message is not read when is open', js: true do
      first("tr[data-link=\"#{user_message_path(@message.sender, @message)}\"] td").click
      visit user_messages_path(user, outbox: true)

      expect(page).to have_selector('tr td i.fa.fa-dot-circle-o')
      expect(page).not_to have_selector('tr td i.fa.fa-circle-thin')
    end

  end

  context 'remove message' do

      scenario 'can remove message', js: true do
        find('i.fa.fa-trash').click
        page.driver.browser.switch_to.alert.accept

        expect(page).not_to have_text(@message.topic)
        expect(current_path).to eq(user_messages_path(user))
      end

  end
end

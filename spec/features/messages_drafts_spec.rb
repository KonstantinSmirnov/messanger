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

  context 'drafts maintenance' do
    before(:each) do
      @draft = FactoryGirl.create(:draft, user: user)  
      visit user_drafts_path(user)
    end

    scenario 'see draft on drafts index page' do
      expect(page).to have_selector('table tbody tr td', text: @draft.topic)
      expect(page).to have_selector('table tbody tr td', text: @draft.recipient_email)
    end

    scenario 'can send draft as a message'

    scenario 'after sending draft as a message, draft to be removed'

    context 'remove draft' do

      before(:all) do
        Capybara.current_driver = :chrome
      end
      after(:all) do
        Capybara.use_default_driver
      end

      scenario 'can delete draft' do
        find(:css, 'i.fa.fa-trash').click
        page.driver.browser.switch_to.alert.accept

        expect(page).not_to have_text(@draft.topic)
        expect(current_path).to eq(user_drafts_path(user))
      end
    end
  end
end

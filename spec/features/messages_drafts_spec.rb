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

    scenario 'drafts link is active when on drafts page' do
      expect(page).to have_selector('.nav-item.active', text: 'Drafts')
    end

    scenario 'see draft on drafts index page' do
      expect(page).to have_selector('table tbody tr td', text: @draft.topic)
      expect(page).to have_selector('table tbody tr td', text: @draft.recipient_email)
    end

    scenario 'can send draft as a message', js: true do
      first("tr[data-link=\"#{new_user_message_path(@draft.user, draft_id: @draft.id)}\"] td").click

      expect(page).to have_selector('h1', text: 'New Message')
      expect(find_field('Recipient emails').value).to eq(@draft.recipient_email)
      expect(find_field('Topic').value).to eq(@draft.topic)
      expect(find_field('Text').value).to eq(@draft.text)
    end

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

  context 'pagination' do
    scenario 'does not show paginate if less than 10 letters' do
      9.times { FactoryGirl.create(:draft, user: user) }

      visit user_drafts_path(user)

      expect(page).not_to have_selector('.pagination')
    end

    scenario 'shows paginate if more than 10 letters' do
      11.times { FactoryGirl.create(:draft, user: user) }

      visit user_drafts_path(user)

      expect(page).to have_selector('.pagination')
    end
  end
end

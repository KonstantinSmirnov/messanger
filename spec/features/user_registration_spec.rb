require 'rails_helper'

feature 'USERS REGISTRATION' do
  
  before(:each) do
    visit new_user_path
  end

  feature 'form validation' do
    scenario 'fails without an email' do
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_selector('.user_email.has-error span.help-block', text: "can't be blank")
    end

    scenario 'fails if email is invalid' do
      fill_in 'user_email', with: 'invalid-email.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_selector('.user_email.has-error span.help-block', text: "is invalid")
    end

    scenario 'fails without password' do
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_selector('.user_password.has-error span.help-block', text: 'is too short (minimum is 6 characters)')
    end

    scenario 'fails without password confirmation' do
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      click_button 'Submit'

      expect(page).to have_selector('.user_password_confirmation.has-error span.help-block', text: "doesn't match Password")
    end

    scenario 'fails if password is shorter than 6 symbols' do
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: '123'
      fill_in 'user_password_confirmation', with: '123'
      click_button 'Submit'

      expect(page).to have_selector('.user_password.has-error span.help-block', text: 'is too short (minimum is 6 characters)')
    end

    scenario 'fails if password does not match password confirmation' do
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: '123'
      click_button 'Submit'

      expect(page).to have_selector('.user_password_confirmation.has-error span.help-block', text: "doesn't match Password")
    end
    
  end

  feature 'user exists' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'fails if user already exists' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_selector('.user_email.has-error span.help-block', text: 'has already been taken')   
    end
  end

  feature 'registration' do
    scenario 'a please login page is displayed after registration' do
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(current_path).to eq(login_path)
    end
  end
end

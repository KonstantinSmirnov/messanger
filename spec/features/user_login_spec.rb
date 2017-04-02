require 'rails_helper'

feature 'USER LOGS IN' do
  
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit login_path
  end

  scenario 'has login page' do
    expect(page).to have_selector('h1', text: 'Log in')
  end

  scenario 'fails without email' do
    fill_in 'user_password', with: 'password'
    click_button 'Log In'

    expect(page).to have_selector('.alert.alert-danger', text: 'Email or password is invalid')
  end

  scenario 'fails wihtout password' do
    fill_in 'user_email', with: 'test@test.com'
    click_button 'Log In'

    expect(page).to have_selector('.alert.alert-danger', text: 'Email or password is invalid')
  end

  scenario 'fails with valid email, but if user does not exist' do
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log In'

    expect(page).to have_selector('.alert.alert-danger', text: 'Email or password is invalid')
  end

  scenario 'logs in with valid email and pasword' do
    user = FactoryGirl.create(:user, 
                              email: 'test@test.com', 
                              password: 'password',
                              password_confirmation: 'password')
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log In'

    expect(page).to have_selector('.alert.alert-success', text: 'You logged in')
  end
end

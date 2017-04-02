require 'rails_helper'
include UserAuthentication

feature 'USER LOGS OUT' do
  let!(:user) { FactoryGirl.create(:user, 
                                 email: 'test@test.com',
                                 password: 'password',
                                 password_confirmation: 'password'
                                 ) }

  before(:each) do
    login_user_with('test@test.com', 'password') 
  end

  scenario 'logs out' do
    click_link 'Log Out'

    expect(page).to have_selector('.alert.alert-success', text: 'See you later!')
  end
end

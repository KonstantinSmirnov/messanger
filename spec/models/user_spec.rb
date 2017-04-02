require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'has a valid factory' do
    user = FactoryGirl.create(:user)

    expect(user).to be_valid
  end

  describe 'Create' do
    it 'is invalid without name' do
      user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user = User.create(
        name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a pasword' do
      user = User.create(
        name: 'User',
        email: 'test@test.com',
        password_confirmation: 'password'
      )

      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'is invalid without a password confirmation' do
      user = User.create(
        name: 'User',
        email: 'test@test.com',
        password: 'password'
      )

      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'is invalid with a password of spacebars' do
      user = User.create(
        name: 'User',
        email: 'test@test.com',
        password: '   ',
        password_confirmation: '   '
      )

      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'is invalid with password less than 6 symbols' do
      user = User.create(
        name: 'User',
        email: 'test@test.com',
        password: '123',
        password_confirmation: '123'  
      )

      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'is invalid with invalid email' do
      user = User.create(
        name: 'User',
        email: 'invalid-email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'is invalid with duplicated email' do
      user1 = FactoryGirl.create(:user)      

      user2 = User.create(
        name: 'User',
        email: user1.email,
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end

    it 'creates with valid data' do
      user = User.create(
        name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).to be_valid
    end
  end

  describe 'Update' do

    let(:user) { FactoryGirl.create(:user) }

    it 'fails with invalid email' do
      user.email = 'invalid-email.com'
      user.save

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'fails if new password is invalid' do
      user.password = '123'
      user.password_confirmation = '123'
      user.save

      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'updates with valid data' do
      user.name = 'User'
      user.email = 'another@email.com'
      user.password = 'password'
      user.password_confirmation = 'password'
      user.save

      expect(user).to be_valid
    end
  end 
end

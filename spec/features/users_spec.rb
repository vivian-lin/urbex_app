require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'Creating an account' do
    Steps 'Go to sign up page' do
      Given 'I am on the sign up page' do
        # part of sign_up command
      end
      Then 'I can enter my email and password' do
        sign_up('joe@joe.com', 'joejoe', 'joejoe')
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
    end
  end

  context 'Logging out of an account' do
    Steps 'Go to sign up page' do
      Given 'I am on the sign up page' do
        # part of sign_up command
      end
      Then 'I can enter my email and password' do
        sign_up('joe@joe.com', 'joejoe', 'joejoe')
        click_link 'Sign out'
        expect(page).to have_content('Signed out successfully')
      end
    end
  end

  context 'View my profile page' do
    Steps 'Go to sign up page' do
      Given 'I am an authenticated user' do
        sign_up('joe@joe.com', 'joejoe', 'joejoe')
      end
      Then 'I can see my information on a profile page' do
        expect(page).to have_content('Profile')
        expect(page).to have_content('Email: joe@joe.com')
      end
    end
  end

  context 'Add username and description on Sign Up' do
    Steps 'Go to Sign Up page' do
      Given 'I have filled out the Sign Up form' do
        sign_up('joe@joe.com', 'joejoe', 'joejoe')
      end
      Then 'I am welcomed by my username and description' do
        expect(page).to have_content('Welcome joejoe!')
        expect(page).to have_content('I love to visit haunted places with my dog. We get scared.')
      end
    end
  end

end

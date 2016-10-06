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
        click_link 'Sign Out'
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
        expect(page).to have_content('Welcome, @joejoe!')
        expect(page).to have_content('I love to visit haunted places with my dog. We get scared.')
      end
    end
  end

  context 'I can edit my user profile' do
    Steps 'To edit user profile' do
      Given 'I have signed up' do
        sign_up('joe@joe.com', 'password', 'joejoe')
      end
      Then 'I can see a link in the nav bar called Edit Profile, and edit my profile' do
        click_link 'Edit Profile'
        fill_in 'user[username]', with: 'AmazingTechnicolorDreamCoat'
        fill_in 'user[user_description]', with: 'I like musicals.'
        fill_in 'user[password]', with: 'amazing'
        fill_in 'user[password_confirmation]', with: 'amazing'
        fill_in 'user[current_password]', with: 'password'
        click_button 'Update'
        expect(page).to have_content('Your account has been updated successfully.')
        expect(page).to have_content('AmazingTechnicolorDreamCoat')
      end
    end
  end

  context 'I can search for users' do
    Steps 'To search for users' do
      Given 'There are many users signed up' do
        sign_up('1@test.com', 'password', 'Joe')
        sign_out
        sign_up('2@test.com', 'password', 'Bob')
        sign_out
        sign_up('3@test.com', 'password', 'Susan')
        sign_out
        sign_up('4@test.com', 'password', 'Bobby_Bob')
        sign_out
      end
      Then 'I visit the search page and search for users' do
        click_link 'Explorers'
        expect(page).to have_content('Bob')
        expect(page).to have_content('Bobby_Bob')
        expect(page).to have_content('Joe')
        expect(page).to have_content('Susan')
        fill_in 'search', with: 'Bob'
        click_button 'Search'
        expect(page).to have_content('Bob')
        expect(page).to have_content('Bobby_Bob')
      end
      Then 'I can click on a user and view their profile' do
        click_link 'Bobby_Bob'
        expect(page).to have_content("Bobby_Bob's Profile")
        expect(page).to have_content("4@test.com")
      end
    end
  end
end

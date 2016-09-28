require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'Creating an account' do
    Steps 'Go to sign up page' do
      Given 'I am on the sign up page' do
        visit '/users/sign_up'
      end
      Then 'I can enter my email and password' do
        fill_in 'user[email]', with: 'joe@joe.com'
        fill_in 'user[password]', with: 'joejoe'
        fill_in 'user[password_confirmation]', with: 'joejoe'
        click_button 'Sign up'
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
    end
  end

  context 'Logging out of an account' do
    Steps 'Go to sign up page' do
      Given 'I am on the sign up page' do
        visit '/users/sign_up'
      end
      Then 'I can enter my email and password' do
        fill_in 'user[email]', with: 'joe@joe.com'
        fill_in 'user[password]', with: 'joejoe'
        fill_in 'user[password_confirmation]', with: 'joejoe'
        click_button 'Sign up'
        click_link 'Sign out'
        expect(page).to have_content('Signed out successfully')
      end
    end
  end

  context 'View my profile page' do
    Steps 'Go to sign up page' do
      Given 'I am an authenticated user' do
        visit '/users/sign_up'
        fill_in 'user[email]', with: 'joe@joe.com'
        fill_in 'user[password]', with: 'joejoe'
        fill_in 'user[password_confirmation]', with: 'joejoe'
        click_button 'Sign up'
      end
      Then 'I can see my information on a profile page' do
        expect(page).to have_content('Profile')
        expect(page).to have_content('Email: joe@joe.com')
      end
    end
  end
end

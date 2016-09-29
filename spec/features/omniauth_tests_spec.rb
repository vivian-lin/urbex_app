require 'rails_helper'

RSpec.feature "OmniauthTests", type: :feature do
  context 'Signing in with Twitter' do
    Steps 'Go to index page to sign in with Twitter' do
      Given 'I am on the index page' do
        visit '/'
      end
      Then 'Click a link that say Sign in with Twitter' do
        click_link 'Sign in with Twitter'
      end # ends then
      And 'You will input you log in information' do
        fill_in 'Username or email', with: 'fakeurbex'
        fill_in 'Password', with: 'faketwitterpassword'
        click_button 'Sign In'
      end
      And 'You will be signed in' do
        expect(page).to have_content "Signed in!"
      end # ends and
      Then 'You can click sign out and your session will end' do
        click_link 'Sign out'
      end # ends then
      And 'You will be redirected to the home page and see a flash message' do
        expect(page).to have_content "Signed out successfully."
      end # ends and
    end # ends steps
  end # ends context

end # ends rspec

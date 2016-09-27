require 'rails_helper'

RSpec.feature "OmniauthTests", js:true, type: :feature do
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
    end # ends steps
  end # ends context

end # ends rspec

require 'rails_helper'

RSpec.feature "OmniauthTests", js:true, type: :feature do
  context 'Signing up, then signing in with Twitter' do
    Steps 'Go to index page to sign up with Twitter' do
      Given 'I am on the home page and click the Sign In with Twitter link' do
        visit '/'
        click_link 'sign in with twitter'
      end
      Then 'I am taken to the Twitter sign up page, and I sign in' do
        fill_in 'Username or email', with: 'fakeurbex'
        fill_in 'Password', with: 'faketwitterpassword'
        click_button 'Sign In'
      end
      Then 'I need to add a username and profile photo for my UrbEx' do
        fill_in 'user[username]', with: 'SampleTwitter'
        attach_file "user[image]", File.join(Rails.root, "spec/assets/marty.jpg")
        fill_in 'user[user_description]', with: 'Hello, this is a test for adding username, photo and description to my twitter login access.'
        click_button('main_menu_submit_button')
      end
      Then 'I expect to be signed up with my Twitter account' do
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
      Then 'I can sign out, then sign back in with my Twitter account' do
        sign_out
        click_link 'sign in with twitter'
        expect(page).to have_content('Signed in!')
      end
    end # ends steps
  end # ends context

end # ends rspec

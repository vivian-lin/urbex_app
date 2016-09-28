require 'rails_helper'

RSpec.feature "NavBars", js:true, type: :feature do
  context 'I am on the index page' do
    Steps 'When I am on the index page I can choose to sign up' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      And 'I can click on the Sign Up link on the nav bar' do
        click_link 'Sign Up'
      end # ends the and
      Then 'I am taken to the Sign Up page where I can fill in my information' do
        fill_in 'Email', with: 'test17@me.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end # end of then
      Then 'You click submit' do
        click_button 'Sign up'
      end # end of then
      And 'You will be signed up and be redirected to the home page' do
        expect(page).to have_content "Welcome! You have signed up successfully."
      end # end of and
      Then 'You can click sign out and your session will end' do
        click_link 'Sign out'
      end # ends then
      And 'You will be redirected to the home page and see a flash message' do
        expect(page).to have_content "Signed out successfully."
      end # ends and
    end # end of steps
  end # end of context

  context 'I can log in to my account through the nav bar' do
    Steps 'I click the Sign In link to log into my account' do
      Given 'I am signed up' do
        sign_up('whatever@email.com', 'whatever', 'username')
      end # ends Given
      Then 'I can sign out' do
        click_link 'Sign out'
      end
      And 'I can click the Sign In link on the nav bar to sign in' do
        click_link 'Sign In'
      end # ends And
      Then 'I will be sent to the sign in form and enter my information' do
        fill_in 'Email', with: 'whatever@email.com'
        fill_in 'Password', with: 'whatever'
      end # ends t hen
      Then 'Click the Log in button to sign in' do
        click_button 'Log in'
      end # ends then
      And 'I will be redirected to the profile page and see a flash message' do
        expect(page).to have_content "Signed in successfully."
      end # ends and
    end # ends steps
  end # ends context

end # end rspec

require 'rails_helper'


RSpec.feature "NavBars", type: :feature do
  context 'I am on the index page' do
    Steps 'When I am on the index page I can choose to sign up' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      And 'I can click on the Sign Up link on the nav bar' do
        click_link 'Sign Up'
      end # ends the and
      Then 'I am taken to the Sign Up page where I can fill in my information' do
        expect(page).to have_content "Sign up"
      end # end of and
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
      Then 'I will be sent to the sign in form ' do
        expect(page).to have_content "Log in"
      end # ends and
    end # ends steps
  end # ends context

end # end rspec

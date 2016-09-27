require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'Creating an account' do
    Steps 'Go to sign up page' do
      Given 'I am on the sign up page' do
        visit '/users/sign_up'
      end
      Then 'I can enter my email an password' do
        fill_in 'user[email]', with: 'joe@joe.com'
        fill_in 'user[password]', with: 'joejoe'
        fill_in 'user[password_confirmation]', with: 'joejoe'
        click_button 'Sign up'
        expect(page).to have_content("UrbEx")
      end
    end
  end
end

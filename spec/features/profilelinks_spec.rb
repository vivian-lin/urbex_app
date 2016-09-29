require 'rails_helper'

RSpec.feature "Profilelinks", type: :feature do
  context 'Once signed in you can access a profile page' do
    Steps 'When I am signed in I can click profile page link' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'We can sign up' do
        sign_up('whatever@email.com', 'whatever', 'Super Cool Person')
      end # ends Given
      Given 'I am on the profile page' do
        visit '/profile'
      end # ends given
      Then 'I can click Your Profile Page link and access my profile' do
        click_link "Your Profile Page"
      end # ends Then
      And 'I can see all my profile information' do
        expect(page).to have_content "Super Cool Person"
      end # ends and
    end # ends steps
  end #end context

  context 'Once signed in you can add a profile photo' do
    Steps 'When I am signed in I can click profile page link' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'We can sign up' do
        #sign_up('mom@mom.com', 'mommom',"SuperMom")
        visit '/users/sign_up'
        #fill_in 'Email', with: "email"
        click_button 'Sign up'
        save_and_open_page
      end # ends Given
      And 'I can see all my profile information' do
        expect(page).to have_selector('img')
      end # ends and
    end # ends steps
  end #end context
end # ends rspec

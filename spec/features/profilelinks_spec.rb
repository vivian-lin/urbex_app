require 'rails_helper'

RSpec.feature "Profilelinks", js:true, type: :feature do
  context 'Once signed in you can access a profile page' do
    Steps 'When I am signed in I can click profile page link' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'We can sign up' do
        sign_up('whatever@email.com', 'whatever')
      end # ends Given
      Given 'I am on the profile page' do
        visit '/profile'
      end # ends given
      Then 'I can click Your Profile Page link and access my profile' do
        click_link "Your Profile Page"
      end # ends Then
      And 'I can see all my profile information' do
        expect(page).to have_content "Your Profile"
      end # ends and
    end # ends steps
  end #end context
end # ends rspec

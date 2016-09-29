require 'rails_helper'

RSpec.feature "Profilelinks", type: :feature do
  context 'Once signed in you can access a profile page' do
    Steps 'When I am signed in I can click profile page link' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'We can sign up' do
        sign_up('joe@joe.com', 'joejoe', 'joejoe')
      end # ends Given
      Given 'I am on the profile page' do
        visit '/profile'
      end # ends given
      Then 'I can click Your Profile Page link and access my profile' do
        click_link "Profile"
      end # ends Then
      And 'I can see all my profile information' do
        expect(page).to have_content "joejoe"
      end # ends and
    end # ends steps
  end #end context

  context 'Once signed in you can add a profile photo' do
    Steps 'When I am signed in I can click profile page link' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'We can sign up' do
        sign_up('joe@joe.com', 'joejoe', 'joejoe')
      end # ends Given
      And 'I can see all my profile information' do
        expect(page).to have_selector('img')
      end # ends and
    end # ends steps
  end #end context

  context 'Once signed in you can add an adventure from your profile page' do
    Steps 'When I am signed in I am taken to profile page where I can choose to create a new adventure' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'We can sign up' do
        sign_up('cow@cow.com', 'cowcow', 'Holstein McMooFace')
      end # ends Given
      And 'I can click a button that takes me to the new adventure form' do
        click_link('Add New Adventure')
        expect(page).to have_content('New Adventure')
      end # ends and
    end # ends steps
  end #end context


end # ends rspec

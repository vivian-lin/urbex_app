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

  context 'I see a map on the adventure page with marker of the adventure' do
    Steps 'When I am signed in I am taken to profile page where I can choose to create a new adventure' do
      Given 'I start on the index page' do
        visit '/'
      end # ends given
      And 'I can sign up' do
        sign_up('cow@cow.com', 'cowcow', 'Holstein McMooFace')
      end # ends Given
      Then 'I can add a new category' do
        create_category('Urban Art')
      end
      Then 'I can create a new adventure' do
        create_adventure('Learn Academy', '3803 Ray St. San Diego, CA, 92104', 'corner of Ray and Northpark, just south of university', 'A haunted place of mystery and ghouls', 'option[1]')
      end # ends and
      Then 'I am taken to the adventure show page where I can see the map' do
        expect(page.find_by_id('adventureMap')).to_not eq nil
      end # ends Then
    end # ends steps
  end #end context


end # ends rspec

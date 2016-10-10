require 'rails_helper'

RSpec.feature "AddMorePhotosOnAdventurePosts", type: :feature do
  context 'I can add photos to a gallery on an adventrue' do
    Steps 'I have to sign up to I can create an account to create an adventrue' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      And 'I can create a user account' do
        sign_up('happycat@happy.com', 'happy1', 'HappyCat')
      end # end and
      Then 'I can create a category for an adventure' do
        create_categories
      end # ends then
      Then 'I can create a new Adventure and add an image' do
        click_link 'Adventures'
        click_link 'Add New Adventure'
        create_adventure('adventure_name', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
      end
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Abandoned'
        # needs to be 4 because of the logo img
        expect(page).to have_selector('img', :count => 4)
      end
      And 'I can edit my post by adding more photos' do
        click_link 'Edit'
        edit_adventure
      end
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Abandoned'
        # needs to be 7 because of the logo img
        expect(page).to have_selector('img', :count => 7)
      end
    end # ends steps
  end # ends context

  context 'I can add photos to a gallery on an adventrue' do
    Steps 'I have to sign up to I can create an account to create an adventrue' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      And 'I can create a user account' do
        sign_up('happycat@happy.com', 'happy1', 'HappyCat')
      end # end and
      Then 'I can create a category for an adventure' do
        create_categories
      end # ends then
      Then 'I can create a new Adventure and add an image' do
        click_link 'Adventures'
        click_link 'Add New Adventure'
        create_adventure('adventure_name', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
      end # ends then
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Abandoned'
        # needs to be 4 because of the logo img
        expect(page).to have_selector('img', :count => 4)
      end # ends then
      And 'I can edit my post by adding more photos' do
        click_link 'Edit'
      end # end and
      And 'I can see all the photos that I have uploaded on the edit page as well so I can edit them in the future' do
        # needs to be 4 because of the logo img
        expect(page).to have_selector('img', :count => 4)
        edit_adventure
      end # end and
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Abandoned'
        # needs to be 7 because of the logo img
        expect(page).to have_selector('img', :count => 7)
      end # ends then
      Then 'I can edit my post by adding more photos' do
        click_link 'Edit'
      end
      And 'I can see all the photos that I have uploaded on the edit page as well so I can edit them in the future' do
        # needs to be 7 because of the logo img
        expect(page).to have_selector('img', :count => 7)
      end # end and
    end # ends steps
  end # ends context

end

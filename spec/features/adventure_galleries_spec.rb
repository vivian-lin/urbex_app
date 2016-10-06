require 'rails_helper'

RSpec.feature "AdventureGalleries", type: :feature do
  context 'I can add photos to a gallery on an adventrue' do
    Steps 'I have to sign up to I can create an account to create an adventrue' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      And 'I can create a user account' do
        sign_up('happycat@happy.com', 'happy1', 'Happy Cat')
      end # end and
      Then 'I can create a category for an adventure' do
        create_category('Haunted')
        create_category('Tunnels')
      end # ends then
      Then 'I can create a new Adventure and add an image' do
        click_link 'Adventures'
        click_link 'New Adventure'
        create_adventure('adventure_name', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
      end
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Haunted'
        expect(page).to have_selector('img', :count => 4)
      end
    end # ends steps
  end # ends context
end # ends rspec

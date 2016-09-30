require 'rails_helper'

RSpec.feature "AdventurePages", type: :feature do
  context 'Creating a new Adventure' do
    Steps 'I can create a new Adventure' do
      Given 'I am signed up and there are Categories created' do
        sign_up('whatever@email.com', 'whatever', 'username')
        create_category('Haunted')
        create_category('Tunnels')
      end
      Then 'I can create a new Adventure' do
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
      end
    end # ends steps
  end # ends context

  context 'Searching for Adventures' do
    Steps 'Searching by category or keyword' do
      Given 'There are categories, adventures, and a user created' do
        sign_up('email@email.com', 'password', 'username')
        create_category('Tunnels')
        create_category('Buildings')
        create_adventure('adventure_name', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
        create_adventure('test_name', 'adventure_address2', 'adventure_directions2', 'adventure_description2', 'option[2]')
        sign_out
        click_link 'Adventures'
      end
      Then 'I can browse adventures by category' do
        click_link 'Tunnels'
        expect(page).to have_content 'Tunnels Adventures'
        expect(page).to have_content 'adventure_name'
      end
      Then 'I can also search adventures by keywords' do
        click_link 'Adventures'
        fill_in 'search', with: 'test_name'
        click_button 'Search'
        expect(page).to have_content 'test_name'
        expect(page).to have_no_content 'adventure_name'
      end
    end
  end
end # ends rspec

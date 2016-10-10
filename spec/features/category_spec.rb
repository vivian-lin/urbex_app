require 'rails_helper'


RSpec.feature "Categories", type: :feature do
  context 'Pre-seeded Categories' do
    Steps 'Selecting from a preset list of Categories' do
      Given 'I am signed up and categories seeded' do
        sign_up('email@me.com','password','username')
        create_categories
      end
      Then 'I can create an adventure based on a list of categories' do
        click_link 'Adventures'
        expect(page).to have_content 'Abandoned Arts & Culture Haunted Hiking Historical Kid-Friendly Scenic Miscellaneous'
        click_link 'Add New Adventure'
      end
    end
  end
end

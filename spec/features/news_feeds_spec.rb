require 'rails_helper'

RSpec.feature "NewsFeeds", type: :feature do
  context 'I can go to my profile and see how many people I am following and how many people are following me' do
    Steps 'I have to sign up' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      Given 'I can sign up' do
        sign_up('cat@me.com', 'catcat', 'catcat')
      end # ends given
      Given 'I am on the profile page' do
        visit '/profile'
      end # ends given
      And 'I can see all my profile information' do
        expect(page).to have_content "catcat"
      end # ends and
      And 'I can create a category' do
        create_categories
      end
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
        expect(page).to have_content 'Abandoned'
        expect(page).to have_selector('img')
      end
      Then 'I can click a button and create a new post' do
        click_link 'Add New Post'
        expect(page).to have_content 'New Post'
        fill_in 'Title', with: 'This is a Title.'
        fill_in 'Body', with: 'This paragraph is about my adventure.'
        click_button 'Create Post'
      end
      And 'I can click on news feed in the navagation bar to see the latest posts updates' do
        click_link 'news feed'
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'This is a Title.'
      end # ends and
    end # ends steps
  end # ends context
end # ends rspec

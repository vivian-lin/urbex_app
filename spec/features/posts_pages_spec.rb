require 'rails_helper'

RSpec.feature "Blog Posts", type: :feature do
  context 'Users and Posts', js:true  do
    Steps 'Deleting a post' do
      Given 'I am signed in and on my profile page' do
        sign_up('user@email.com', 'password', 'username')
      end
      And 'There are categories & adventures created' do
        create_categories
        create_adventure("adventure_name", "adventure_address", "adventure_directions", "adventure_description", "option[1]")
      end
      Then 'I can click a button and create a new post' do
        click_link 'Add New Post'
        expect(page).to have_content 'New Post'
        fill_in 'Title', with: 'This is a Title.'
        fill_in 'Body', with: 'This paragraph is about my adventure.'
        click_button 'Create Post'
      end
      Then 'I can see my post on my profile page' do
        click_link 'Delete'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Post was successfully destroyed.'
      end
    end
  end

  context 'Users and Posts - access' do
    Steps 'Creating posts that only I have access to' do
      Given 'I am signed in and on my profile page' do
        sign_up('user@email.com', 'password', 'username')
      end
      And 'There are categories & adventures created' do
        create_categories
        create_adventure("adventure_name", "adventure_address", "adventure_directions", "adventure_description", "option[1]")
      end
      And 'I can click a button and create a new post' do
        click_link 'Add New Post'
        fill_in 'Title', with: 'This is a Title.'
        fill_in 'Body', with: 'This paragraph is about my adventure.'
        click_button 'Create Post'
      end
      And 'I log out and another user logs in' do
        sign_out
        sign_up('user2@email.com', 'password', 'username2')
      end
      Then 'The new user cannot delete the blog post' do
        visit '/posts'
        expect(page).to have_content('Show')
        expect(page).to have_no_css('a', :text =>'Destroy')
      end
    end
  end
  context 'Users and Posts' do
    Steps 'Adventure Name shows up on posts' do
      Given 'I am signed in and on my profile page' do
        sign_up('user@email.com', 'password', 'username')
      end
      And 'There are categories & adventures created' do
        create_categories
        create_adventure("Haunted Forest", "adventure_address", "adventure_directions", "adventure_description", "option[1]")
      end
      Then 'I can click a button and create a new post' do
        click_link 'Add New Post'
        expect(page).to have_content 'New Post'
        fill_in 'Title', with: 'This is a Title.'
        fill_in 'Body', with: 'This paragraph is about my adventure.'
        click_button 'Create Post'
        expect(page).to have_content 'Post was successfully created.'
      end
      Then 'I can see the post adventure on the post show page' do
        expect(page).to have_content 'Adventure: Haunted Forest'
      end
      Then "I can click the back button and be taken back to that post's adventure" do
        click_link 'Back'
        expect(page).to have_content 'Category: Abandoned'
        expect(page).to have_content 'Adventure: Haunted Forest'
      end
    end
  end
end

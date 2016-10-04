require 'rails_helper'

RSpec.feature "Blog Posts", js:true, type: :feature do
  context 'Users and Posts' do
    Steps 'Deleting a post' do
      Given 'I am signed in and on my profile page' do
        sign_up('user@email.com', 'password', 'username')
      end
      And 'There are categories & adventures created' do
        create_category("category_name")
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
        create_category("category_name")
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

end

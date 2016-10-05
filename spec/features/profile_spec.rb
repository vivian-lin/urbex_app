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

  context 'Users and Posts' do
    Steps 'Adding a post' do
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
        expect(page).to have_content 'Post was successfully created.'
      end
      Then 'I can see my post on my profile page' do
        click_link 'Profile'
        expect(page).to have_content 'This is a Title.'
      end
    end
  end

  context 'Users and Posts' do
    Steps 'Updating a Post from another User' do
      Given 'There are users, categories, and adventures created' do
        sign_up('user@email.com', 'password', 'username')
        create_category("category_name")
        create_adventure("adventure_name", "adventure_address", "adventure_directions", "adventure_description", "option[1]")
        sign_out
        sign_up('user2@email.com', 'password', 'username2')
      end
      Then 'I can update a post' do
        click_link 'Adventures'
        click_link 'Edit'
        click_button 'Update Adventure'
        expect(page).to have_content 'username2'
      end
      Then 'Another user can update the post' do
        sign_out
        sign_up('user3@email.com', 'password', 'username3')
        click_link 'Adventures'
        click_link 'Edit'
        click_button 'Update Adventure'
        expect(page).to have_content 'username3'
      end
      Then 'The original user can update the post' do
        sign_out
        click_link 'Sign In'
      end
    end
  end

  # context 'I see a map on the adventure page with marker of the adventure' do
  #   Steps 'When I am signed in I am taken to profile page where I can choose to create a new adventure' do
  #     Given 'I start on the index page' do
  #       visit '/'
  #     end # ends given
  #     And 'I can sign up' do
  #       sign_up('cow@cow.com', 'cowcow', 'Holstein McMooFace')
  #     end # ends Given
  #     Then 'I can add a new category' do
  #       create_category('Urban Art')
  #     end
  #     Then 'I can create a new adventure' do
  #       create_adventure('Learn Academy', '3803 Ray St. San Diego, CA, 92104', 'corner of Ray and Northpark, just south of university', 'A haunted place of mystery and ghouls', 'option[1]')
  #     end # ends and
  #     Then 'I am taken to the adventure show page where I can see the map' do
  #       expect(page.find_by_id('adventureMap')).to_not eq nil
  #     end # ends Then
  #   end # ends steps
  # end #end context

  context 'On a profile page I can see a map of all my adventures' do
    Steps 'I can go to my profile page and see my adventures on a map' do
      Given 'There are adventures created for the map' do
        sign_up('cow@cow.com', 'cowcow', 'Holstein McMooFace')
        create_category('Urban Art')
        create_category('Haunted')
        create_adventure('Learn Academy', '3803 Ray St. San Diego, CA, 92104', 'corner of Ray and Northpark, just south of university', 'A haunted place of mystery and ghouls', 'option[1]')
        create_adventure('North Park Water Tower', 'Howard Ave, San Diego, CA 92104', 'haunted water tower', 'spoopy and creppy', 'option[2]')
      end # ends Given
      Then 'I can see the map with all of the adventures' do
        visit '/profile'
        expect(page.find_by_id('profileMap')).to_not eq nil
      end # ends then
    end #end steps
  end #end context

  context 'Users and Posts' do
    Steps 'Adventure Name shows up on posts' do
      Given 'I am signed in and on my profile page' do
        sign_up('user@email.com', 'password', 'username')
      end
      And 'There are categories & adventures created' do
        create_category("Spoopy and Creppy")
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
      Then 'I can see my post on my profile page' do
        click_link 'Profile'
        expect(page).to have_content 'Adventure: Haunted Forest'
      end
    end
  end


end # ends rspec

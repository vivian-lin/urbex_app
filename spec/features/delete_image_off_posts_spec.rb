require 'rails_helper'

RSpec.feature "DeleteImageOffPosts", js: true,  type: :feature do
  context 'I can add photos to a gallery on an adventrue and delete the photo' do
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
      Then 'I can create a new Adventure' do
        click_link 'Adventures'
        click_link 'New Adventure'
        create_adventure_no_images('North Park Water Tower', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
      end # ends then
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'North Park Water Tower'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Haunted'
      end # ends then
      And 'I can create a post about this adventrue' do
        create_post('Adventure Post', 'This place was awesome!', 'North Park Water Tower')
        expect(page).to have_content 'Post was successfully created'
      end
      Then 'I can edit my post by adding photos' do
        click_link 'Edit'
      end
      # varible to create a new image to  put into database DO NOT MOVE THIS INSIDE it goes out side so it can be called in other test dos!
      my_image_int = Image.new
      And 'I can upload photos' do
        # varible that has an image
        file = File.open(File.join(Rails.root,"spec/assets/mine2.jpg"))
        # make the file var to the image var
        my_image_int.image = file
        # closing the file
        file.close
        # saving the image
        my_image_int.save!
        # creating a varable for an adventure
        post = Post.first
        # shoveling the image into the adventure
        post.images << my_image_int
        # saving the adventure
        post.save
      end # end and
      Then 'I then save my post' do
        click_button 'Update Post'
      end # ends then
      And 'I will see my picture on that post' do
        expect(page).to have_selector('img', :count => 2)
      end
      Then 'I can go into edit to delete my picture' do
        click_link 'Edit'
      end
      And 'I can click on a picture that I want to delete' do
        fill_in 'Title', with: 'title'
        fill_in 'Body', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
        find_by_id(my_image_int.id).click
        page.driver.browser.switch_to.alert.accept
        page.driver.browser.switch_to.alert.accept
      end # end and
      Then 'I then save my post' do
        click_button 'Update Post'
      end # ends then
      And 'I will see my picture on that post' do
        expect(page).to have_selector('img', :count => 1)
      end
    end # ends steps
  end # ends context

end

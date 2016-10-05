require 'rails_helper'

RSpec.feature "DeleteImageOnEditPages", js: true,  type: :feature do
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
        create_adventure_no_images('adventure_name', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
      end # ends then
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Haunted'
      end # ends then
      And 'I can edit my post by adding photos' do
        click_link 'Edit'
      end # end and
      And 'I can upload photos' do
        my_image_int = Image.new
        file = File.open(File.join(Rails.root,"spec/assets/mine2.jpg"))
        my_image_int.image = file
        file.close
        my_image_int.save!
      end # end and
      Then 'I save my post' do
        click_button 'Update Adventure'
      end
      Then 'I can see all the info about my Adventure' do
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Haunted'
        expect(page).to have_selector('img', :count => 1)
      end # ends then
      Then 'I can edit my post by deleting my photos' do
        click_link 'Edit'
      end
      And 'I can click on a picture that I want to delete' do
        find_by_id('1').click
        page.driver.browser.switch_to.alert.accept
        page.driver.browser.switch_to.alert.accept
      end # end and
      Then 'I save my post' do
        click_link 'Update Adventure'
        expect(page).to have_content 'adventure_name'
        expect(page).to have_content 'adventure_address'
        expect(page).to have_content 'adventure_directions'
        expect(page).to have_content 'adventure_description'
        expect(page).to have_content 'Haunted'
        expect(page).to have_selector('img', :count => 5)
      end
    end # ends steps
  end # ends context

end

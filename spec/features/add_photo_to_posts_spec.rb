require 'rails_helper'

RSpec.feature "AddPhotoToPosts", type: :feature do
  context 'Posts on adventure page' do
    Steps 'I can go to the adventure page and see all related posts' do
      Given 'There are adventures created' do
        sign_up('cow@cow.com', 'cowcow', 'Holstein McMooFace')
        create_category('Haunted')
        create_adventure('North Park Water Tower', 'Howard Ave, San Diego, CA 92104', 'haunted water tower', 'spoopy and creppy', 'option[1]')
      end
      Then 'There are posts created' do
        create_post_with_image('Adventure Post', 'This place was awesome!', 'North Park Water Tower')
        expect(page).to have_content 'Post was successfully created'
      end
      Then 'I can go to the Adventures show page and see that post' do
        click_link 'Adventures'
        click_link 'North Park Water Tower'
        expect(page).to have_content 'Adventure Post'
      end
      Then 'I can click on that Post link and see the content of that Post' do
        click_link 'Adventure Post'
        expect(page).to have_content 'This place was awesome!'
        expect(page).to have_selector('img', :count => 2)
      end
    end #end steps
  end # end context

  context 'Posts on adventure page adding more images in edit' do
    Steps 'I can go to the adventure page and see all related posts' do
      Given 'There are adventures created' do
        sign_up('cow@cow.com', 'cowcow', 'Holstein McMooFace')
        create_category('Haunted')
        create_adventure('North Park Water Tower', 'Howard Ave, San Diego, CA 92104', 'haunted water tower', 'spoopy and creppy', 'option[1]')
      end # ends given
      Then 'There are posts created' do
        create_post_with_image('Adventure Post', 'This place was awesome!', 'North Park Water Tower')
        expect(page).to have_content 'Post was successfully created'
      end # ends then
      Then 'I can go to the Adventures show page and see that post' do
        click_link 'Adventures'
        click_link 'North Park Water Tower'
        expect(page).to have_content 'Adventure Post'
      end # ends then
      Then 'I can click on that Post link and see the content of that Post' do
        click_link 'Adventure Post'
        expect(page).to have_content 'This place was awesome!'
        expect(page).to have_selector('img', :count => 2)
      end # ends then
      Then 'I can edit my post by adding more photos' do
        click_link 'Edit'
        edit_post
        click_button 'Update Post'
      end # ends then
      And 'I will see my newly added photos on the page' do
        expect(page).to have_selector('img', :count => 5)
      end # ends and
    end #end steps
  end # end context
end

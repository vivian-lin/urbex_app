require 'rails_helper'

RSpec.feature "AdminPages", type: :feature do
  context 'I can log as an admin and see the admin page' do
    Steps 'I am on the index page to log on as an admin' do
      Given 'I have an admin account' do
        create_admin
      end
      And 'I am on the index page' do
        visit '/'
      end # end and
      Then 'I can login as an admin' do
        visit '/users/sign_in'
        fill_in 'user_email', with: 'admin@admin.com'
        fill_in 'user_password', with: 'adminadmin'
        click_button 'Log in'
      end
      Then 'I can go to the admin page' do
        click_link 'Administration'
        expect(page).to have_content 'Admin-ify'
      end
    end
  end # ends

  context 'On the admin page, only users show a Make Admin button' do
    Steps 'A user account and an admin accout are created' do
      Given 'I have an admin account' do
        create_admin
      end
      And 'I can create a user account' do
        sign_up('happycat@happy.com', 'happy1', 'Happy Cat')
      end
      Then 'I can sign out of the user account' do
        sign_out
      end
      Then 'I can go to the index page' do
        visit '/'
      end # end and
      And 'I can login as an admin' do
        visit '/users/sign_in'
        fill_in 'user_email', with: 'admin@admin.com'
        fill_in 'user_password', with: 'adminadmin'
        click_button 'Log in'
      end
      Then 'I can go to the admin page' do
        click_link 'Administration'
        expect(page).to have_css('input', :count => 1)
      end
    end
  end # ends
end # ends RSpec

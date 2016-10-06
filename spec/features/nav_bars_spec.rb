require 'rails_helper'


RSpec.feature "NavBars", type: :feature do
  context 'I can see a sign up link' do
    Steps 'Going to the sign up page' do
      Given 'I am on the index page' do
        visit '/'
      end
      And 'I can click on the Sign Up link on the nav bar' do
        click_link 'Sign Up'
      end
      Then 'I am taken to the Sign Up page' do
        expect(page).to have_content "Sign up"
      end
    end
  end
  context 'I can log in and log out through the navbar' do
    Steps 'Going to the log in page' do
      Given 'I am signed up' do
        sign_up('whatever@email.com', 'whatever', 'username')
      end
      Then 'I can sign out' do
        click_link 'Sign Out'
      end
      And 'I can click the Sign In link on the nav bar to sign in' do
        click_link 'Sign In'
      end
      Then 'I will be sent to the sign in form ' do
        expect(page).to have_content "Log in"
      end
    end
  end
  context 'I can see an Adventures link in the navbar' do
    Steps 'Going to the adventure page' do
      Given 'I am on the index page' do
        visit '/'
      end
      Then 'I can click the Adventures link' do
        click_link 'Adventures'
      end
      Then 'I will be sent to the Adventures page' do
        expect(page).to have_content('Search Adventures')
      end
    end
  end

  context 'I can see an Explorers link in the navbar' do
    Steps 'Going to the Explorers page' do
      Given 'I am on the index page' do
        visit '/'
      end
      Then 'I can click the Explorers link' do
        click_link 'Explorers'
      end
      Then 'I will be sent to the Explorers page' do
        expect(page).to have_content('Search Explorers')
      end
    end
  end  

end # end rspec

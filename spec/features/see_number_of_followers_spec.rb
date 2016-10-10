require 'rails_helper'

RSpec.feature "SeeNumberOfFollowers", type: :feature do
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
      Then 'I can sign out' do
        click_link 'Sign Out'
      end # ends then
      And 'Another user can sign up' do
        sign_up('dog@me.com', 'dogdog', 'dogdog')
      end
      Given 'I am on the profile page' do
        visit '/profile'
      end # ends given
      And 'I can see all my profile information' do
        expect(page).to have_content "dogdog"
      end # ends and
      Then 'I can go to the exploers page and find an exploerer to follow' do
        click_link 'Explorers'
        expect(page).to have_content 'catcat'
        expect(page).to have_selector('img', :count => 3)
      end # ends Then
      Then 'I can click on a users name to go to their profile' do
        click_link 'catcat'
        expect(page).to have_content "catcat"
      end # ends Then
      And 'I can click on the follow button to follow that user' do
        click_link 'Follow this Explorer'
        expect(page).to have_content 'catcat has 1 followers'
        expect(page).to have_content 'catcat is following 0 explorers'
      end
      Then 'I can go to my profile and see how many explorers I am following and how many are following me' do
        click_link 'Profile'
        expect(page).to have_content 'dogdog has 0 followers'
        expect(page).to have_content 'dogdog is following 1 explorers'
      end # ends then
    end # ends steps
  end # ends context
end # ends rspec

require 'rails_helper'

RSpec.feature 'Socialization', type: :feature do
  context 'I can follow other users' do
    Steps 'I can follow another user' do
      Given 'I create accounts' do
        sign_up('user@email.com', 'password', 'username')
        sign_out
        sign_up('alex@alex.com', 'alexalex', 'AlexLove')
      end
      And 'I am on the explorer page' do
        click_link 'Explorers'
        click_link 'username'
      end
      Then 'I can follow username' do
        click_link 'Follow this Explorer'
        expect(page).to have_content 'You are now following username'
      end
    end
  end
end

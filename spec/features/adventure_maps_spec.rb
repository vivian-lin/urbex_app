require 'rails_helper'
# testing map integration and usage
RSpec.feature "AdventureMaps", type: :feature do
  context 'I am on the adventure index page'do
  Steps 'I can post a photo of a place that I explored' do
    Given 'I am on the index page' do
      visit '/'
    end # ends given
    Given 'I can sign up' do
      sign_up('whatever@email.com', 'whatever', 'username')
    end # ends Given
    Then 'I can create a new adventure' do
      new_adventure
    end
    Then 'The page redirects me to the show page so I can see the photo' do
      expect(page).to have_selector('img')
    end # ends then
  end #ends steps
 end #ends context
end #ends rspec

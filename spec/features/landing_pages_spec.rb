require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'Going to webpage' do
     Steps 'See a welcome to UrbEx message' do
       Given 'I am on the landing page' do
         visit '/'
       end # ends given
       Then 'I can read about UrbEx' do
         expect(page).to have_content "UrbEx"
       end # ends then
     end # ends steps
   end # ends context


  context 'Going to an about page' do
    Steps 'I can click the nav-bar link called About' do
      Given 'I am on the landing page' do
        visit '/'
      end # ends given
      Then 'I am taken to the about page' do
        click_link('About')
        expect(page).to have_content "About UrbEx"
      end # ends then
    end # ends steps
  end # ends context

end # ends rspec

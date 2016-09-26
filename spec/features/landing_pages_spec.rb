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

  end # ends rspec

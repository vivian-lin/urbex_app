require 'rails_helper'

RSpec.feature "AdventureGalleries", type: :feature do
  context 'I can add photos to a gallery on an adventrue' do
    Steps 'I have to sign up to I can create an account to create an adventrue' do
      Given 'I am on the index page' do
        visit '/'
      end # ends given
      And 'I can create a user account' do
        sign_up('happycat@happy.com', 'happy1', 'Happy Cat')
      end # end and
      Then 'I can create an adventure' do
         
      end # ends then
    end # ends steps
  end # ends context
end # ends rspec

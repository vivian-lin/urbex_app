require 'rails_helper'

RSpec.feature "AdminPages", type: :feature do
  context 'I can log into the admin page' do
    Steps 'I am on the index page to log on as an admin' do
      Given 'I am on the index page' do
        visit '/'
      end # end Given
      Then 
    end
  end # ends
end # ends RSpec

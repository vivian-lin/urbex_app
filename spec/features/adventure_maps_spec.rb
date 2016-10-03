# require 'rails_helper'
# # testing map integration and usage
# RSpec.feature "AdventureMaps", type: :feature do
#   context 'I can see my Adventure location on a map'do
#   Steps 'I can create an adventure and see the location on a map' do
#     Given 'I am on the index page' do
#       visit '/'
#     end # ends given
#     Given 'I can sign up' do
#       sign_up('whatever@email.com', 'whatever', 'username')
#     end # ends Given
#     Then 'I can add a new category' do
#       create_category('Urban Art')
#     end
#     Then 'I can create a new adventure' do
#       create_adventure('Learn Academy', '3803 Ray St. San Diego, CA, 92104', 'corner of Ray and Northpark, just south of university', 'A haunted place of mystery and ghouls', 'Urban Art')
#     end
#     Then 'The page redirects me to the show page so I can see the map' do
#       expect(page.find_by_id('adventureMap')).to_not eq nil
#     end # ends then
#   end #ends steps
#  end #ends context
# end #ends rspec

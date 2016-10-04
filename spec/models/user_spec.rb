require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is a thing' do
    expect {User.new}.to_not raise_error
  end

  it 'has an email and password' do
    user = User.new
    user.email = 'bob@bob.com'
    user.password = 'bobbob'
    user.username = 'bobbobbob'
    expect(user.save).to be true
    user2 = User.find_by_email('bob@bob.com')
    expect(user2.email).to eq 'bob@bob.com'
  end

  it 'has adventures' do
    user = User.new
    user.email = 'bob@bob.com'
    user.password = 'bobbob'
    user.username = 'bobbobbob'
    user.save
    category = Category.new
    category.save
    adventure = Adventure.new
    adventure.name = "Adventure name"
    adventure.address = "Adventure address"
    adventure.directions = "Adventure directions"
    adventure.category = category
    expect(adventure.save).to be true
    user.adventures << adventure
    user2 = User.find_by_email('bob@bob.com')
    expect(user2.adventures.count).to be 1
    expect(user2.adventures[0].name).to eq 'Adventure name'
  end
end

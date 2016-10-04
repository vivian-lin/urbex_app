require 'rails_helper'

RSpec.describe Adventure, type: :model do
  it 'is a thing' do
    expect {Adventure.new}.to_not raise_error
  end

  it 'has many Users' do
    category = Category.new
    category.save
    adventure = Adventure.new
    adventure.name = "Adventure name"
    adventure.address = "Adventure address"
    adventure.directions = "Adventure directions"
    adventure.category = category
    adventure.save
    user = User.new
    user.email = 'test1@me.com'
    user.password = 'testing'
    user.username = 'test1'
    user.save
    adventure.users << user
    user2 = User.new
    user2.email = 'test2@me.com'
    user2.password = 'testing'
    user2.username = 'test2'
    user2.save
    adventure.users << user2
    adventure2 = Adventure.find_by_name('Adventure name')
    expect(adventure2.users.count).to be 2
    expect(adventure2.users[0].username).to eq 'test1'
  end

  it 'has many Posts' do
    adventure = Adventure.new
    category = Category.new
    category.save
    adventure.name = "Adventure name"
    adventure.address = "Adventure address"
    adventure.directions = "Adventure directions"
    adventure.category = category
    adventure.save
    post = Post.new
    post.title = 'Title!'
    post.body = 'This is the body.'
    adventure.posts << post
    adventure.save
  end
end

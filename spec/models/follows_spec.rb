require 'rails_helper'

RSpec.describe Follow, type: :model do
  it 'is a thing' do
    expect {Follow.new}.to_not raise_error
  end

  it 'users can follow and unfollow' do
    user1 = User.new
    user1.email = "email@email.com"
    user1.password = "password"
    user1.username = "username"
    user1.save
    user2 = User.new
    user2.email = "email2@email.com"
    user2.password = "password"
    user2.username = "username2"
    user2.save
    user1.follow!(user2)
    expect(user2.followers(User)).to eq [user1]
    user1.unfollow!(user2)
    expect(user2.followers(User)).to eq []
  end
end

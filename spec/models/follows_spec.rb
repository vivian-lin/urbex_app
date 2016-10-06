require 'rails_helper'

RSpec.describe Follow, type: :model do
  it 'is a thing' do
    expect {Follow.new}.to_not raise_error
  end

  it 'has follower and followable types' do
    follow = Follow.new
    follow.follower_type = 'explorer'
    follow.followable_type = 'user'
    expect(follow.save).to be true
    follow2 = Follow.find_by_follower_type('explorer')
    expect(follow2.follower_type).to eq 'explorer'
    expect(follow2.followable_type).to eq 'user'
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is a thing' do
    expect{Post.new}.to_not raise_error
  end

  it 'has a title, body, and user id' do
    user = User.new
    post = Post.new
    post.title = 'Bridge'
    post.body = 'It is a big bridge'
    post.user_id = user.id
    expect(post.save).to be true
  end

  # it 'belongs to an Adventure' do
  #   post = Post.new
  #   post.title = "Post Title"
  #   post.body = "This is the post body."
  #   adventure = Adventure.new
  #
  #   post.save
  #
  # end
end

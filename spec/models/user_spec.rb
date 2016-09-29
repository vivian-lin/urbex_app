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

end

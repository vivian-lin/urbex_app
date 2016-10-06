require 'rails_helper'

RSpec.describe Image, type: :model do
  it 'is a picture' do
    expect{Image.new}.to_not raise_error
  end

  it 'has an id' do
    image = Image.new
    image_id = image.id
  end
end

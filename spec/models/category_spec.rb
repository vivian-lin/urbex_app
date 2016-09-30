require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is a thing' do
    expect {Category.new}.to_not raise_error
  end

  it 'has a name' do
    category = Category.new
    category.category_name = 'Tunnels'
    expect(category.save).to be true
    category2 = Category.find_by_category_name('Tunnels')
    expect(category2.category_name).to eq 'Tunnels'
  end
end

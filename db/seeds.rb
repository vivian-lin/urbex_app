# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create a default admin user
user = User.create! :username => 'AppManager', :email => 'admin@admin.com', :password => 'adminadmin', :password_confirmation => 'adminadmin'
user.add_role :admin
# creates categories
category1 = Category.create! :category_name => 'Abandoned'
category1 = Category.create! :category_name => 'Arts & Culture'
category1 = Category.create! :category_name => 'Haunted'
category1 = Category.create! :category_name => 'Hiking'
category1 = Category.create! :category_name => 'Historical'
category1 = Category.create! :category_name => 'Kid-Friendly'
category1 = Category.create! :category_name => 'Scenic'
category1 = Category.create! :category_name => 'Miscellaneous'

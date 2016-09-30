# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create a default admin user
user = User.create! :username => 'App Manager', :email => 'admin@admin.com', :password => 'adminadmin', :password_confirmation => 'adminadmin'

user.add_role :admin

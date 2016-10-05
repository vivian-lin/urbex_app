module FeatureSupport

  def sign_up(email, password, username)
    visit '/users/sign_up'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    fill_in 'user[username]', with: username
    attach_file "user[image]", File.join(Rails.root, "spec/assets/marty.jpg")
    fill_in 'user[user_description]', with: 'Hello, I am Joe and I love dogs. I love to visit haunted places with my dog. We get scared.'
    click_button 'Sign up'
  end

  def sign_out
    click_link 'Sign Out'
  end

  def create_category(category_name)
    visit '/categories/new'
    fill_in 'category[category_name]', with: category_name
    click_button 'Create Category'
  end

  def create_adventure(name, address, directions, description, option)
    visit '/adventures/new'
    fill_in 'adventure[name]', with: name
    fill_in 'adventure[address]', with: address
    fill_in 'adventure[directions]', with: directions
    fill_in 'adventure[description]', with: description
    find_field('adventure[category_id]').find(:xpath, option).select_option
    attach_file "images[]", [File.join(Rails.root,"spec/assets/strawberry_hill.jpg"), File.join(Rails.root,"spec/assets/dam.jpg"), File.join(Rails.root,"spec/assets/haunted.jpg")]
    click_button 'Create Adventure'
  end

  def create_adventure_no_images(name, address, directions, description, option)
    visit '/adventures/new'
    fill_in 'adventure[name]', with: name
    fill_in 'adventure[address]', with: address
    fill_in 'adventure[directions]', with: directions
    fill_in 'adventure[description]', with: description
    find_field('adventure[category_id]').find(:xpath, option).select_option
    click_button 'Create Adventure'
  end

  def edit_adventure
    attach_file "images[]", [File.join(Rails.root,"spec/assets/mine1.jpg"), File.join(Rails.root,"spec/assets/mine2.jpg"), File.join(Rails.root,"spec/assets/mine3.jpg")]
    click_button 'Update Adventure'
  end

  def create_admin
    user = User.create! :username => 'App Manager', :email => 'admin@admin.com', :password => 'adminadmin', :password_confirmation => 'adminadmin'
    user.add_role :admin
  end

end

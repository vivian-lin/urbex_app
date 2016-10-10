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
    user = User.create! :username => 'AppManager', :email => 'admin@admin.com', :password => 'adminadmin', :password_confirmation => 'adminadmin'
    user.add_role :admin
  end

  def create_post(title, body, adventureName)
    visit '/adventures'
    click_link adventureName
    click_link 'Add New Post'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_button 'Create Post'
  end

  def create_post_with_image(title, body, adventureName)
    visit '/adventures'
    click_link adventureName
    click_link 'Add New Post'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    attach_file "images[]", File.join(Rails.root, "spec/assets/dam.jpg")
    click_button 'Create Post'
  end

  def edit_post
    attach_file "images[]", [File.join(Rails.root,"spec/assets/mine1.jpg"), File.join(Rails.root,"spec/assets/mine2.jpg"), File.join(Rails.root,"spec/assets/mine3.jpg")]
  end

  def create_categories
    category1 = Category.create! :category_name => 'Abandoned'
    category1 = Category.create! :category_name => 'Arts & Culture'
    category1 = Category.create! :category_name => 'Haunted'
    category1 = Category.create! :category_name => 'Hiking'
    category1 = Category.create! :category_name => 'Historical'
    category1 = Category.create! :category_name => 'Kid-Friendly'
    category1 = Category.create! :category_name => 'Scenic'
    category1 = Category.create! :category_name => 'Miscellaneous'
  end
end

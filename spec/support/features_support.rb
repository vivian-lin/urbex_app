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
    expect(page).to have_content('Signed out successfully')
  end

  def create_admin
    # create a default admin user
    user = User.create! :username => 'App Manager', :email => 'admin@admin.com', :password => 'adminadmin', :password_confirmation => 'adminadmin'

    user.add_role :admin

  end

  def new_adventure
    visit 'adventures/new'
    fill_in 'Name', with: 'Strawberry Hill'
    fill_in 'Address', with: '12345 Strawberry Hill'
    fill_in 'Directions', with: 'Go down yellow brick road, watch out for wicked witch of the west she wants your ruby slippers.'
    fill_in 'Description', with: 'Beautiful hill with strawberies with lots of art and great shadows'
    attach_file "adventure_image", File.join(Rails.root, "spec/assets/strawberry_hill.jpg")
    click_button 'Create Adventure'
  end

end

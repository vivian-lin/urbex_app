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

  def new_adventure
    visit 'adventures/new'
    fill_in 'Name', with: 'Learn Academy'
    fill_in 'Address', with: '3803 Ray Street, San Diego, CA  92104'
    fill_in 'Directions', with: 'Corner of Ray and North Park'
    fill_in 'Description', with: 'Cool place with rotating art exhibits and really cool people that hang out and make cool stuff'
    attach_file "adventure_image", File.join(Rails.root, "spec/assets/strawberry_hill.jpg")
    click_button 'Create Adventure'
  end
end

module FeatureSupport

  def sign_up(email, password, username)
    visit '/users/sign_up'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    fill_in 'user[username]', with: username
    attach_file "user[image]", "spec/assets/marty.jpg"
    fill_in 'user[user_description]', with: 'Hello, I am Joe and I love dogs. I love to visit haunted places with my dog. We get scared.'
    save_and_open_page
    click_button 'Sign up'
  end

end

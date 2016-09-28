class ProfileController < ApplicationController
  before_action :authenticate_user!

  #Purpose: To show current user's profile
  #Signature: use current_user to instantiate @user with a User
  def show
    @user = current_user
  end

end

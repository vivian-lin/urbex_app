class ProfileController < ApplicationController

  #Purpose: To show current user's profile
  #Signature: use current_user to instantiate @user with a User
  def show
    if !current_user.nil?
      @user = current_user
    else
      redirect_to '/users/sign_in'
    end
  end

  def view
    @user = User.find_by_username(params[:username])
  end

end

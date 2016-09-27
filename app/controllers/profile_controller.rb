class ProfileController < ApplicationController
  #Devise::RegistrationsController
  before_action :authenticate_user!

  #Purpose: To show current user's profile
  #Signature: use current_user to instantiate @user with a User
  def show
    @user = User.first
    @user = current_user
    #@user = User.find(params[:id])
  end

end

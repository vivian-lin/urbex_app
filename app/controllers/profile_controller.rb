class ProfileController < ApplicationController

  def index
  end

  def show
    if !current_user.nil?
      @user = current_user
    else
      redirect_to '/users/sign_in'
    end
    id = current_user.id
    @posts = Post.where(user_id: id).order('created_at DESC')
  end

  def view
    @user = User.find_by_username(params[:username])
  end

end

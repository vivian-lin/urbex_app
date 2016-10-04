class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  #to show all users on admin page
  def index
    @users = User.all
  end

  #gives user admin role
  def update
    @user = User.find(params[:id])
    @user.remove_role(:user)
    @user.add_role(:admin)
    redirect_to '/admin'
  end

  private

  #to protect from hackers
  def authorize
    if !current_user.has_role? :admin
      redirect_to '/'
      flash[:notice] = 'You do not have admin authorization.'
    end
  end

end

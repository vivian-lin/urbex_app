class ProfileController < ApplicationController

  def index
  end
  #
  # def view
  #   @user = User.find_by_username(params[:username])
  # end

  def show
    if current_user.nil? && (params[:username].nil? || params[:username].empty?)
      redirect_to '/users/sign_up'
    elsif current_user.nil? && (!params[:username].nil? || !params[:username].empty?)
      @user = User.find_by_username(params[:username])
      @posts = @user.posts.order('created_at DESC')
    else
      if params[:username].nil? || params[:username].empty?
        @user = current_user
        @posts = @user.posts.order('created_at DESC')
      else
        @user = User.find_by_username(params[:username])
        @posts = @user.posts.order('created_at DESC')
      end
    end
  end

  # GET /profile/:id/profile_map_locations --> JSON object
  def profile_map_locations
    adventures = User.find(params[:id]).adventures
    hash = Gmaps4rails.build_markers(adventures) do |adventure, marker|
      marker.lat adventure.latitude
      marker.lng adventure.longitude
      marker.infowindow adventure.address
    end
    render json: hash.to_json
  end

end

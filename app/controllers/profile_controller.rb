class ProfileController < ApplicationController

  def index
  end

  def show
    if !current_user.nil?
      @user = current_user
    else
      redirect_to '/users/sign_in'
    end
    @posts = current_user.posts.order('created_at DESC')
    # adventures = current_user.adventures
    # @pindrop = Gmaps4rails.build_markers(adventures) do |adventure, marker|
    #   marker.lat adventure.latitude
    #   marker.lng adventure.longitude
    #   marker.infowindow adventure.address
    # end
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

  def view
    @user = User.find_by_username(params[:username])
  end

end

class ProfileController < ApplicationController

  def index
  end

  def feed
    followees = current_user.followees(User)
    followees_posts = followees.map{|followee| followee.posts}
    @feed = followees_posts
    self_posts = Post.where( user_id: current_user.id )
    @feed = followees_posts << self_posts
    # @feed.each
    # @feed = @feed.sort {|a, b| a.created_at<=>b.created_at}
    # default_scope -> { order(created_at: :desc) }
  end


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

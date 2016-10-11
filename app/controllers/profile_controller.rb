class ProfileController < ApplicationController

  def index
  end

  def feed
    followees = current_user.followees(User)
    followees_posts = followees.map{|followee| followee.posts}
    self_posts = Post.where( user_id: current_user.id )
    feed = followees_posts << self_posts
    #empty array to hold organized feed posts
    @organized_feed = []
    #shoveling posts into empty array organized feed
    feed.each do |f|
      f.each do |post|
        @organized_feed << post
      end
    end
    #sorting organized_feed by descending created_at date
    @organized_feed = @organized_feed.sort{|a,b| b.created_at <=> a.created_at}
    #for recently added adventures on feed page
    @adventures = Adventure.all.order('created_at DESC').limit(15)
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

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

    @adventures = Adventure.all.order('created_at DESC').limit(15)
  end

  def show
    # nobody logged in & user is trying to go to /profile (hacking)
    if current_user.nil? && (params[:username].nil? || params[:username].empty?)
      redirect_to '/users/sign_up'
    # nobody logged in & user is trying to view other explorers' profiles
    elsif current_user.nil? && (!params[:username].nil? || !params[:username].empty?)
      @user = User.find_by_username(params[:username])
      @posts = @user.posts.order('created_at DESC')
    # if you are logged in
    else
      # if you're looking at /profile (your own profile)
      if params[:username].nil? || params[:username].empty?
        @user = current_user
        @posts = @user.posts.order('created_at DESC')
        # sets instance variable for a collection of the user's followers
        @followers = @user.followers(User)
        # sets variable for a collection of the followers names
        @follower_usernames = @followers.map { |follower|  follower.username}
        # sets variable for a collection of who you are following (followees)
        @followees = @user.followees(User)
        # sets variable for a collection of names of who you are following (followees)
        @followee_usernames = @followees.map { |followee| followee.username }
      # if you're looking at someone else's profile
      else
        @user = User.find_by_username(params[:username])
        @posts = @user.posts.order('created_at DESC')
        # sets instance variable for a collection of the user's followers
        @followers = @user.followers(User)
        # sets variable for a collection of the followers names
        @follower_usernames = @followers.map { |follower| follower.username }
        # sets variable for a collection of who you are following (followees)
        @followees = @user.followees(User)
        # sets variable for a collection of names of who you are following (followees)
        @followee_usernames = @followees.map { |followee| followee.username }
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

class PostsController < ApplicationController
  before_action :authenticate_user!,:except => [:show, :index]
  load_and_authorize_resource
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #sets default sort for posts to descending order
  # default_scope -> { order(created_at: :desc) }
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @images = []
    #stating the var for the loop
    index = 0
    #while there is a imgae uploded that is greater than 0 upload them into the array
    while index < @post.images.length do
      #array of images that they are now put into
      set_of_images = []
      #shoveling the images into the array
      set_of_images << @post.images[index]
      #adding an image to the index to the loop to now compare to the next loop
      index = index + 1
      #comparing if the index is less than the amount of photos uploaded
      if index < @post.images.length
        #shoveling the images into the new uploaded array
        set_of_images << @post.images[index]
        #adding the photo into the index loop to now compair for the next loop
        index = index + 1
      end
      if index < @post.images.length
        #shoveling the images into the new uploaded array
        set_of_images << @post.images[index]
        #adding the photo into the index loop to now compair for the next loop
        index = index + 1
      end
      #adding one array of pictures into the images corresponding to a row in the view
      @images << set_of_images
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user = current_user
    @post.adventure = Adventure.find(params[:adventure_id])
  end

  # GET /posts/1/edit
  def edit
    #empty array that will hold arrays of images
    @images = []
    #stating the var for the loop
    index = 0
    #while there is a imgae uploded that is greater than 0 upload them into the array
    while index < @post.images.length do
      #array of images that they are now put into
      set_of_images = []
      #shoveling the images into the array
      set_of_images << @post.images[index]
      #adding an image to the index to the loop to now compare to the next loop
      index = index + 1
      #comparing if the index is less than the amount of photos uploaded
      if index < @post.images.length
        #shoveling the images into the new uploaded array
        set_of_images << @post.images[index]
        #adding the photo into the index loop to now compair for the next loop
        index = index + 1
      end
      if index < @post.images.length
        #shoveling the images into the new uploaded array
        set_of_images << @post.images[index]
        #adding the photo into the index loop to now compair for the next loop
        index = index + 1
      end
      #adding one array of pictures into the images corresponding to a row in the view
      @images << set_of_images
    end


  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        if params[:images]
          params[:images].each do |image|
            img = Image.create(image: image)
            @post.images << img
          end
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.user = current_user
    respond_to do |format|
      if params[:images]
        params[:images].each do |image|
          img = Image.create(image: image)
          @post.images << img
        end
      end
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.user = current_user
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :adventure_id, :user, :image)
    end
end

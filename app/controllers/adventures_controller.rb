class AdventuresController < ApplicationController
  load_and_authorize_resource
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]

  # GET /adventures, GET /adventures.json
  def index
    # for search bar on adventure's index page
    if params[:search].nil?
      @adventures = Adventure.all
    else
      @adventures = Adventure.search(params[:search])
    end
    # for browsing by categories
    @categories = Category.all
    # for the all adventures map on the adventures index page
    @pindrop = Gmaps4rails.build_markers(@adventures) do |adventure, marker|
      marker.lat adventure.latitude
      marker.lng adventure.longitude
      marker.infowindow adventure.address
    end
  end

  # gets the info for google map for the Adventure SHOW page and creates json hash
  def map_location
    @adventure = Adventure.find(params[:adventure_id])
    @hash = Gmaps4rails.build_markers(@adventure) do |adventure, marker|
      marker.lat adventure.latitude
      marker.lng adventure.longitude
      marker.infowindow adventure.address
    end
    render json: @hash.to_json
  end

  #gets the info for google maps for the adventure INDEX page and creates json hash
  def all_map_locations
    @adventure = Adventure.all
    @hash = Gmaps4rails.build_markers(@adventure) do |adventure, marker|
      marker.lat adventure.latitude
      marker.lng adventure.longitude
      marker.infowindow adventure.address
    end
    render json: @hash.to_json
  end

  # GET /adventures/1
  # GET /adventures/1.json
  # Added show method info got google map api
  def show
    @posts = Adventure.find(params[:id]).posts 
    @adventures = Adventure.find(params[:id])
    @pindrop = Gmaps4rails.build_markers(@adventures) do |adventure, marker|
      marker.lat adventure.latitude
      marker.lng adventure.longitude
      marker.infowindow adventure.address
    end
    #empty array that will hold arrays of images
    @images = []
    #stating the var for the loop
    index = 0
    #while there is a imgae uploded that is greater than 0 upload them into the array
    while index < @adventure.images.length do
      #array of images that they are now put into
      set_of_images = []
      #shoveling the images into the array
      set_of_images << @adventure.images[index]
      #adding an image to the index to the loop to now compare to the next loop
      index = index + 1
      #comparing if the index is less than the amount of photos uploaded
      if index < @adventure.images.length
        #shoveling the images into the new uploaded array
        set_of_images << @adventure.images[index]
        #adding the photo into the index loop to now compair for the next loop
        index = index + 1
      end
      if index < @adventure.images.length
        #shoveling the images into the new uploaded array
        set_of_images << @adventure.images[index]
        #adding the photo into the index loop to now compair for the next loop
        index = index + 1
      end
      #adding one array of pictures into the images corresponding to a row in the view
      @images << set_of_images
    end
  end

  # GET /adventures/new
  def new
    @adventure = Adventure.new
    @categories_for_select = Category.all.map do |category|
      [category.category_name, category.id]
    end
  end

  # GET /adventures/1/edit
  def edit
    @categories_for_select = Category.all.map do |category|
      [category.category_name, category.id]
    end
  end

  # POST /adventures
  # POST /adventures.json
  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.users << current_user

    respond_to do |format|
      if @adventure.save
        # TODO: more comments
        if params[:images]
          params[:images].each do |image|
            #1/0
            img = Image.create(image: image)
            #@adventure.images.create(image_file_name: image)
            @adventure.images << img

          end
        end
        format.html { redirect_to @adventure, notice: 'Adventure was successfully created.' }
        format.json { render :show, status: :created, location: @adventure }
      else
        format.html { render :new }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adventures/1
  # PATCH/PUT /adventures/1.json
  def update
    @adventure.users << current_user
    respond_to do |format|
      if params[:images]
        params[:images].each do |image|
          #1/0
          img = Image.create(image: image)
          #@adventure.images.create(image_file_name: image)
          @adventure.images << img

        end
      end
      if @adventure.update(adventure_params)
        format.html { redirect_to @adventure, notice: 'Adventure was successfully updated.' }
        format.json { render :show, status: :ok, location: @adventure }
      else
        format.html { render :edit }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1
  # DELETE /adventures/1.json
  def destroy
    @adventure.destroy
    respond_to do |format|
      format.html { redirect_to adventures_url, notice: 'Adventure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adventure
      @adventure = Adventure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adventure_params

      params.require(:adventure).permit(:name, :address, :directions, :description, :user_id, :category_id, :images, :latitude, :longitude)

    end

end

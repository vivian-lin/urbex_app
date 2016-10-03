class AdventuresController < ApplicationController
  load_and_authorize_resource
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]

  # GET /adventures
  # GET /adventures.json
  def index
    if params[:search].nil?
      @adventures = Adventure.all
    else
      @adventures = Adventure.search(params[:search])
    end
    @categories = Category.all
  end

  def map_location
    @adventure = Adventure.find(params[:adventure_id])
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
    @adventures = Adventure.find(params[:id])
    @pindrop = Gmaps4rails.build_markers(@adventures) do |adventure, marker|
      marker.lat adventure.latitude
      marker.lng adventure.longitude
      marker.infowindow adventure.address
    end
    # TODO: add more images here or else all images will be the same.
    @images = [@adventure.image, @adventure.image, @adventure.image, @adventure.image, @adventure.image, @adventure.image, @adventure.image, @adventure.image, @adventure.image ]
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

    respond_to do |format|
      if @adventure.save
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
    respond_to do |format|
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
      params.require(:adventure).permit(:name, :address, :directions, :description, :user_id, :category_id, :image, :latitude, :longitude)
    end
end

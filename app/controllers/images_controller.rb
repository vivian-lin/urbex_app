class ImagesController < ApplicationController
  def delete_image
    @image = Image.find(params[:id])
    @image.destroy
    render json: "You have deleted your photo!".to_json
  end
end

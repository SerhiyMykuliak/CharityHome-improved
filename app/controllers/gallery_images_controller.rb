class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: [:edit, :update, :destroy]

  def index 
    @gallery_images = GalleryImage.all
  end 

  def new
    @gallery_image = GalleryImage.new
  end

  def edit 
  end 

  def create
    @gallery_image = GalleryImage.new(gallery_image_params)

    if @gallery_image.save
      redirect_to gallery_images_path,  notice: "Gallery image was successfully created." 
    else 
      render :new, status: :unprocessable_entity 
    end
    
  end

  def update

    if @gallery_image.update(gallery_image_params)
      redirect_to gallery_images_path,  notice: "Gallery image was successfully update." 
    else 
      render :edit, status: :unprocessable_entity 
    end

  end 

  def destroy
    @gallery_image.destroy!
    redirect_to gallery_images_path, status: :see_other, notice: "Gallery image was successfully destroyed."
  end 


private

  def set_gallery_image
    @gallery_image = GalleryImage.find(params[:id])
  end 

  def gallery_image_params
    params.require(:gallery_image).permit(:title, :image)
  end 

end

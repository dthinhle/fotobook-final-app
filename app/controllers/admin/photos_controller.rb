class Admin::PhotosController < Admin::ManagementsController

  before_action :find_photo, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.single_photos.order(:id).page params[:page]
  end

  def edit
    render 'photos/edit'
  end

  def update
    if @photo.update(photo_params)
        redirect_to admin_photos_path
    else
      render 'photos/edit'
    end
  end

  def destroy
    @photo.destroy
    redirect_to admin_photos_path
  end

  private

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :private, :desc, :img)
  end

end

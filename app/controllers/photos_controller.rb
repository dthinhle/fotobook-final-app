class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      byebug
      redirect_to myprofile_path
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    begin
      delete_task_params[:task] == "delete"
    rescue => exception
      redirect_to myprofile_path
    end
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.imageable = current_user
    byebug
    if @photo.save
      @photo.img = photo_params[:img]
      redirect_to myprofile_path
    else
      render 'new'
    end
  end

  private
  def delete_task_params
    params.require(:album).permit(:task)
  end

  def photo_params
    params.require(:photo).permit(:title, :private, :desc, :img)
  end
end

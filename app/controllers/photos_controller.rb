class PhotosController < ApplicationController
  before_action :find_photo, only: [:edit, :update, :destroy]
  before_action :find_photo_id, only: [:like, :unlike]

  PHOTO_MODE = 0
  ALBUM_MODE = 1

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.imageable = current_user
    if @photo.save
      @photo.img = photo_params[:img]
      redirect_to my_profile_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    is_owner = @photo.imageable_id == current_user.id
    if @photo.update(photo_params) && is_owner
      redirect_to my_profile_path
    elsif is_owner
      render 'edit'
    else
      flash[:notice] = t('not-owner-notice')
    end
  end

  def destroy
    if @photo.imageable == current_user || @photo.imageable.user_id == current_user.id
      @photo.destroy
    else
      flash[:notice] = t('not-owner-notice')
    end
    begin
      delete_task_params[:task] == "delete"
    rescue => exception
      redirect_to my_profile_path
    end
  end

  def like
    unless @photo.likes.include?(current_user.id)
      @photo.likes << current_user.id
      if @photo.save
        Notification.create(event: "like", user_id: @photo.imageable.id, params: [current_user.id, @photo.id, PHOTO_MODE])
      end
    end
  end

  def unlike
    if @photo.likes.include?(current_user.id)
      @photo.likes.delete current_user.id
      @photo.save
    end
  end

  private

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def find_photo_id
    @photo = Photo.find(params[:photo_id])
  end

  def delete_task_params
    params.require(:album).permit(:task)
  end

  def photo_params
    params.require(:photo).permit(:title, :private, :desc, :img)
  end
end

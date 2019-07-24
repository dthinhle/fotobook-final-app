class AlbumsController < ApplicationController

  before_action :find_album, only: [:edit, :update, :destroy]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_properties(album_params))
    @album.user = current_user
    if @album.save
      create_photos(album_params[:img], album_params)
      redirect_to my_profile_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    byebug

    if @album.update(album_properties(album_params)) && @album.user == current_user
      if album_params[:img]
        create_photos(album_params[:img], album_params)

      end
      redirect_to my_profile_path
    else
      render 'edit'
    end
  end

  def destroy
    if @album.user == current_user
      Photo.transaction do
        @album.destroy
      end
    else
      flash[:notice] = t("not-owner-notice")
    end
    redirect_to my_profile_path
  end

  private

  def photo_properties(params)
    photo_params = album_properties(params)
    photo_params[:title] += "_album"
    photo_params
  end

  def album_properties(params)
    album_params = params.to_h
    album_params.delete(:img)
    album_params
  end

  def create_photos(photos, params)
    Photo.transaction do
      photos.each do |x|
        photo = Photo.new(photo_properties(params))
        photo.img = x
        photo.imageable = @album
        photo.save!
      end
    end
  end

  def find_album
    @album = Album.includes(:photos).find params[:id]
  end

  def album_params
    params.require(:album).permit(:title, :private, :desc, {img: [] })
  end

end

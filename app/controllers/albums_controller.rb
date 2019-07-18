class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    a_params = album_params.to_h
    a_params.delete(:img)
    @album = Album.new(a_params)
    @album.user_id = current_user.id
    if @album.save
      a_params[:title] += "_album"
      album_params[:img].each do |x|
        Photo.transaction do
          photo = Photo.new(a_params)
          photo.img = x
          photo.imageable = @album
          photo.save!
        end
      end
      redirect_to myprofile_path
    else
      render 'new'
    end
  end

  def edit
    @album = Album.find params[:id]
  end

  def update
    a_params = album_params.to_h
    a_params.delete(:img)
    @album = Album.find params[:id]
    if @album.update(a_params)
      a_params[:title] += "_album"

      if album_params[:img]
        album_params[:img].each do |x|
          Photo.transaction do
            photo = Photo.new(a_params)
            photo.img = x
            photo.imageable = @album
            photo.save!
          end
        end
      end

      redirect_to myprofile_path
    else
      render 'new'
    end
  end

  def destroy
    @album = Album.find params[:id]
    @album.destroy
    redirect_to myprofile_path
  end

  private
  def album_params
    params.require(:album).permit(:title, :private, :desc, {img: [] })
  end

end

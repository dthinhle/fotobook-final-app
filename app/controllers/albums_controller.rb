class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new
    @album.title = album_params[:title]
    @album.desc = album_params[:desc]
    @album.user_id = current_user.id
    @album.private = album_params[:private]
    byebug
    if @album.save
      album_params[:img].each do|x|
        photo = Photo.new
        photo.title = "#{album_params[:title]}_album"
        photo.private = false
        photo.img = x
        photo.imageable = @album
        photo.save
      end
      redirect_to myprofile_path
    else
      render 'new'
    end
  end

  def edit
    @album = Album.find params[:id]
  end

  private
  def album_params
    params.require(:album).permit(:title, :private, :desc, {img: [] })
  end

end

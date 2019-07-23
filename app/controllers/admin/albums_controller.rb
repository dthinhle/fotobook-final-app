class Admin::AlbumsController < Admin::ManagementsController

  before_action :find_album, only: [:edit, :update, :destroy]

  def index
    @albums = Album.includes(:photos).order(:id).page params[:page]
  end

  def edit
    render 'albums/edit'
  end

  def update
    a_params = album_params.to_h
    a_params.delete(:img)
    if @album.update(a_params)
      a_params[:title] += "_album"
      if album_params[:img]
        Photo.transaction do
          album_params[:img].each do |x|
            photo = Photo.new(a_params)
            photo.img = x
            photo.imageable = @album
            photo.save!
          end
        end
      end
      redirect_to admin_albums_path
    else
      render 'albums/edit'
    end
  end

  def destroy
    @album.destroy
    redirect_to admin_albums_path
  end

  private

  def find_album
    @album = Album.includes(:photos).find params[:id]
  end

  def album_params
    params.require(:album).permit(:title, :private, :desc, {img: [] })
  end

end

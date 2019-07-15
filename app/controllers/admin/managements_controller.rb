class Admin::ManagementsController < ApplicationController

  def albums
    @albums = Album.order(:id).page params[:page]
  end

  def photos
    @photos = Photo.single_photos.order(:id).page params[:page]
  end

  def users
    @users = User.order(:id).page params[:page]
  end
end

class FeedsController < ApplicationController

  skip_before_action :authenticate_user!, except: [:home, :load_home, :blocked]
  skip_before_action :is_blocked?, only: [:blocked]

  ITEMS_PER_PAGE = 10

  def home
    load_home_contents
    begin
      @mode = mode_params[:mode]
    rescue => e
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def load_home
    load_home_contents
    begin
      @mode = mode_params[:mode]
    rescue => e
      @mode = 'photos'
    end
    respond_to do |format|
      format.js
    end
  end

  def discover
    load_discover_contents
    begin
      @mode = mode_params[:mode]
    rescue => e

    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def load_discover
    load_discover_contents
    begin
      @mode = mode_params[:mode]
    rescue => e
      @mode = 'photos'
    end
    respond_to do |format|
      format.js
    end
  end

  def album_preview
    @album = Album.includes(:photos, :user).find preview_params[:param]
    respond_to do |format|
      format.js
    end
  end

  def photo_preview
    @photo = Photo.find preview_params[:param]
    begin
      @author = @photo.imageable.user
    rescue => exception
      @author = @photo.imageable
    end
    respond_to do |format|
      format.js
    end
  end

  def blocked
    render layout: 'devise'
  end

  private

  def load_discover_contents
    @photo = Photo.single_photos
      .page(params[:page]).per(ITEMS_PER_PAGE)
    @album = Album
      .page(params[:page]).per(ITEMS_PER_PAGE)
  end

  def load_home_contents
    user_lst = current_user.followees.map {|x| x.id} << current_user.id
    @photo = Photo.single_photos
      .where(imageable_id: user_lst)
      .page(params[:page]).per(ITEMS_PER_PAGE)
    @album = Album.includes(:photos)
      .where(user_id: user_lst)
      .page(params[:page]).per(ITEMS_PER_PAGE)
  end

  def mode_params
    params.require(:request).permit(:mode)
  end

  def preview_params
    params.require(:request).permit(:param)
  end
end

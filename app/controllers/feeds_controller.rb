class FeedsController < ApplicationController

  skip_before_action :authenticate_user!

  ITEMS_PER_PAGE = 10

  def home
    if current_user
      user_lst = current_user.followees.map {|x| x.id} << current_user.id
      @photo = Photo.where(imageable_type: 'User').where(imageable_id: user_lst).page(1).per(ITEMS_PER_PAGE)
      @album = Album.includes(:photos).where(user_id: user_lst).page(1).per(ITEMS_PER_PAGE)
      begin
        @mode = mode_params[:mode]
      rescue => e
      end
    else
      redirect_to discover_path
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def discover
    @photo = Photo.where(imageable_type: 'User')
    @album = Album.all
    @photo = @photo.page(1).per(ITEMS_PER_PAGE)
    @album = @album.page(1).per(ITEMS_PER_PAGE)
    begin
      @mode = mode_params[:mode]
    rescue => e

    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def loaddiscover
    @photo = Photo.where(imageable_type: 'User')
    @album = Album.all
    @photo = @photo.page(params[:page]).per(ITEMS_PER_PAGE)
    @album = @album.page(params[:page]).per(ITEMS_PER_PAGE)
    begin
      @mode = mode_params[:mode]
    rescue => e
      @mode = 'photos'
    end
    respond_to do |format|
      format.js
    end
  end

  def loadhome
    unless current_user.nil?
      user_lst = current_user.followees.map {|x| x.id} <<current_user.id
      @photo = Photo.where(imageable_type: 'User').where(imageable_id: user_lst)
      @album = Album.includes(:photos).where(user_id: user_lst)
    else
      @photo = Photo.where(imageable_type: 'User')
      @album = Album.all
    end
    @photo = @photo.page(params[:page]).per(ITEMS_PER_PAGE)
    @album = @album.page(params[:page]).per(ITEMS_PER_PAGE)
    begin
      @mode = mode_params[:mode]
    rescue => e
      @mode = 'photos'
    end
    respond_to do |format|
      format.js
    end
  end

  def albumpreview
    @album = Album.find preview_params[:param]
    respond_to do |format|
      format.js
    end
  end

  def photopreview
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

  private
  def mode_params
    params.require(:request).permit(:mode)
  end

  def preview_params
    params.require(:request).permit(:param)
  end
end

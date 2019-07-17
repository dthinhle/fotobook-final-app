class FeedsController < ApplicationController

  skip_before_action :authenticate_user!
  def home
    if current_user
      user_lst = current_user.followees.map {|x| x.id} <<current_user.id
      @photo = Photo.where(imageable_type: 'User').where(imageable_id: user_lst).page
      @album = Album.includes(:photos).where(user_id: user_lst).page

      begin
        @mode = mode_params[:mode]
        puts @mode
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
    unless current_user.nil?
      user_lst = current_user.followees.map {|x| x.id} <<current_user.id
      @photo = Photo.where(imageable_type: 'User').where.not(imageable_id: user_lst).page params[:page]
      @album = Album.where.not(user_id: user_lst).page params[:page]
    else
      # @photo = Photo.where(imageable_type: 'User')
      @photo = Photo.all
      @album = Album.all
    end
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
    user_lst = current_user.followees.map {|x| x.id} <<current_user.id
    @photo = Photo.where(imageable_type: 'User').where.not(imageable_id: user_lst).page params[:page]
    @album = Album.where.not(user_id: user_lst).page params[:page]
    begin
      @mode = mode_params[:mode]
    rescue => e
      @mode = 'photos'
    end
    puts @mode
    respond_to do |format|
      format.js
    end
  end

  def loadhome
    user_lst = current_user.followees.map {|x| x.id} <<current_user.id
    @photo = Photo.where(imageable_type: 'User').where(imageable_id: user_lst).page params[:page]
    @album = Album.where(user_id: user_lst).page params[:page]
    begin
      @mode = mode_params[:mode]
    rescue => e
      @mode = 'photos'
    end
    puts @mode
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

  def pagination
    photo = Photo.where(imageable_type: 'User').where(imageable_id: user_lst).page(params[:page])
    photo.each do |image|
      render partial: "feeds/thumbnail", locals: {mode: 'photo', src: image}
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

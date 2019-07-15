class FeedsController < ApplicationController
  before_action :authenticate_user!

  def home
    user_lst = current_user.followees.map {|x| x.id} <<current_user.id
    @photo = Photo.where(imageable_type: 'User').where(imageable_id: user_lst)
    @album = Album.where(user_id: user_lst)
    begin
      @mode = mode_params[:mode]
      puts @mode
    rescue => e
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def discover
    user_lst = current_user.followees.map {|x| x.id} <<current_user.id
    @photo = Photo.where(imageable_type: 'User').where.not(imageable_id: user_lst)
    @album = Album.where.not(user_id: user_lst)
    begin
      @mode = mode_params[:mode]
    rescue => e

    end
    respond_to do |format|
      format.html
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

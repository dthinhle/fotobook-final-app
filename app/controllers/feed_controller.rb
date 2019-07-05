class FeedController < ApplicationController
  before_action :authenticate_user!

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
  def preview_params
    params.require(:request).permit(:param)
  end
end

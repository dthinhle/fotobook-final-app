class PhotosController < ApplicationController
  def new
    @photo = Photo.new
    session[:referrer] = request.referer
  end

  def edit
    @photo = Photo.find(params[:id])
    session[:referrer] = request.referer
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      begin
        referrer = session.delete(:referrer)
        redirect_to referrer
      rescue => exception
        redirect_to myprofile_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    begin
      delete_task_params[:task] == "delete"
    rescue => exception
      redirect_to myprofile_path
    end
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.imageable = current_user
    if @photo.save
      @photo.img = photo_params[:img]
      begin
        referrer = session.delete(:referrer)
        redirect_to referrer
      rescue => exception
        redirect_to myprofile_path
      end
    else
      render 'new'
    end
  end

  def like
    @photo = Photo.find params[:photo_id]
    unless @photo.likes.include?(current_user.id)
      @photo.likes << current_user.id
      @photo.save
    end
  end

  def unlike
    @photo = Photo.find params[:photo_id]
    if @photo.likes.include?(current_user.id)
      @photo.likes.delete current_user.id
      @photo.save
    end
  end

  private
  def delete_task_params
    params.require(:album).permit(:task)
  end

  def photo_params
    params.require(:photo).permit(:title, :private, :desc, :img)
  end
end

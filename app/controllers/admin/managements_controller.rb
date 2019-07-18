class Admin::ManagementsController < ApplicationController

  before_action :is_admin

  def albums
    @albums = Album.order(:id).page params[:page]
  end

  def editalbum
    @album = Album.find params[:id]
    render 'albums/edit'
  end

  def updatealbum
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
      redirect_to admin_managealbums_path
    else
      render 'albums/edit'
    end
  end

  def editphoto
    @photo = Photo.find params[:id]
    render 'photos/edit'
  end

  def updatephoto
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
        redirect_to admin_managephotos_path
    else
      render 'photos/edit'
    end
  end

  def photos
    @photos = Photo.single_photos.order(:id).page params[:page]
  end

  def users
    @users = User.order(:id).page params[:page]
  end

  def edituser
    @user = User.find params[:id]
  end

  def updateavtuser
    @user = User.find params[:id]
    @user.avatar =  user_avatar_params[:avatar]
    unless @user.save
      flash[:notice] = "Your selected file is invalid"
    end
    redirect_back(fallback_location: admin_manageusers_path)
  end

  def updateuser
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    if @user.update(user_params)
      flash[:notice] = "Successfully updated user."
      redirect_to admin_manageusers_path
    else
      render :action => 'edit'
    end
  end

  def deleteuser
    if current_user.id == params[:id]
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "Successfully deleted user."
      redirect_to admin_manageusers_path
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :private, :desc, :img)
  end

  def album_params
    params.require(:album).permit(:title, :private, :desc, {img: [] })
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :blocked)
  end

  def is_admin
    unless current_user.admin
      flash[:error] = "You must be an admin to access this section"
      redirect_to root_path
    end
  end
end

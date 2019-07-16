class Admin::ManagementsController < ApplicationController

  before_action :is_admin

  def albums
    @albums = Album.order(:id).page params[:page]
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

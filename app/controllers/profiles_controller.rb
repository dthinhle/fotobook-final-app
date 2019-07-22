class ProfilesController < ApplicationController

  ITEMS_PER_PAGE = 12

  def show
    @user = User.includes(:photos,:albums,:followers,:followees).find(params[:id])
  end

  def task
    task = task_params[:task]
    photo = Photo.find task_params[:param]
    if task == 'lock'
      photo.private = true
    elsif task == 'unlock'
      photo.private = false
    end
    photo.save
  end

  def update_avatar
    @user = current_user
    @user.avatar =  profile_avt_params[:avatar]
    unless @user.save
      flash[:notice] = "Your selected file is invalid"
    end
    redirect_to edit_profile_path
  end

  def update_password
    @user = current_user

    if profile_password_params[:password] == profile_password_params[:current_password]
      flash[:notice] = "Your new password can not be identical to the old one!"
    elsif profile_password_params[:password] != profile_password_params[:password_confirmation]
      flash[:notice] = "Your new password confirmation does not match!"
    else
      @user.update_with_password(profile_password_params)
    end
    redirect_to edit_profile_path
  end

  def update_info
    @user = current_user
    unless @user.update(profile_info_params)
      msg = []
      @user.errors.each {|key, value| msg <<value}
      flash[:notice] = msg
    else
      flash[:notice] = "Your info is successfully changed."
    end
    redirect_to edit_profile_path
  end

  def get_profile_photos
    load_user
    @mode = profile_data_params[:mode]
    respond_to do |format|
      format.js
    end
  end

  def load_photos
    load_user
    @page = params[:page]
    @mode = profile_data_params[:mode]
    if @mode == 'photos'
      @photo = @user.id == current_user.id ? @user.photos : @user.photos.public_photos
      @photo = @photo.page(@page).per(ITEMS_PER_PAGE)
    else
      @album = @user.id == current_user.id ? @user.albums : @user.albums.public_albums
      @album = @album.page(@page).per(ITEMS_PER_PAGE)
    end
    respond_to do |format|
      format.js
    end
  end

  def get_profile_follows
    @user = User.includes(:followers, :followees).find(profile_data_params[:param])
    @mode = profile_data_params[:mode]
    @page = params[:page]
    respond_to do |format|
      format.js
    end
  end

  def load_follows
    @page = params[:page]
    load_user
    @mode = profile_data_params[:mode]
    if @mode == 'followers'
      @follow = @user.followers.page(@page).per(ITEMS_PER_PAGE)
    else
      @follow = @user.followees.page(@page).per(ITEMS_PER_PAGE)
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_profile
    @user = current_user
  end

  private

  def load_user
    @user = User.includes(:photos, :albums).find(profile_data_params[:param])
  end

  def pagination_params
    params.require(:request).permit(:mode)
  end

  def profile_data_params
    params.require(:data).permit(:param,:mode)
  end

  def task_params
    params.require(:request).permit(:task, :param)
  end

  def profile_avt_params
    params.require(:user).permit(:avatar)
  end

  def profile_info_params
    params.require(:user).permit(:first_name,:last_name,:email)
  end

  def profile_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end

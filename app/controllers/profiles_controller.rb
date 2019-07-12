class ProfilesController < ApplicationController
  def show
    @user = User.includes(:photos,:albums,:followers,:followees).find(params[:id])
  end

  def task
    task = task_params[:task]
    if task == 'lock'
      photo = Photo.find task_params[:param]
      photo.private = true
      photo.save
    elsif task == 'unlock'
      photo = Photo.find task_params[:param]
      photo.private = false
      photo.save
    end
  end

  def update_avatar
    @user = current_user
    @user.avatar =  profile_avt_params[:avatar]
    unless @user.save
      flash[:notice] = "Your selected file is invalid"
    end
    redirect_to editprofile_path
  end

  def update_password
    @user = current_user
    puts profile_password_params

    if profile_password_params[:password] == profile_password_params[:current_password]
      flash[:notice] = "Your new password can not be identical to the old one!"
    elsif profile_password_params[:password] != profile_password_params[:password_confirmation]
      flash[:notice] = "Your new password confirmation does not match!"
    else
      @user.update_with_password(profile_password_params)
    end
    redirect_to editprofile_path
  end

  def update_info
    @user = current_user
    unless @user.update(profile_info_params)
      msg = []
      @user.errors.each {|key, value| msg <<value}
      flash[:notice] = msg
    else
      puts profile_info_params
      flash[:notice] = "Your info is successfully changed."
      # bypass_sign_in(@user)
    end
    redirect_to editprofile_path
  end

  def getprofilephotos
    @user = User.includes(:photos, :albums).find(profile_data_params[:param])
    @mode = profile_data_params[:mode]
    respond_to do |format|
      format.js
    end
  end

  def getprofilefollows
    @user = User.includes(:followers, :followees).find(profile_data_params[:param])
    @mode = profile_data_params[:mode]
    respond_to do |format|
      format.js
    end
  end

  def editprofile
    @user = current_user
  end

  private
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

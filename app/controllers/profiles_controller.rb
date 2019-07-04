class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def task
    task = task_params[:task]
    if task == 'follow'
      respond_to do |format|
        format.json {
          render json: {:follower => current_user[:id],:followee => task_params[:param].to_i}
        }
      end
    elsif task == 'lock'
      photo = Photo.find task_params[:param]
      photo.private = true
      photo.save
    elsif task == 'unlock'
      photo = Photo.find task_params[:param]
      photo.private = false
      photo.save
    end
  end

  def update_password
    @user = current_user
    puts profile_password_params

    if profile_password_params[:password] == profile_password_params[:new_password]
      flash[:notice] = "Your new password can not be identical to the old one!"
    else
      @user.update(profile_password_params)
    end
    redirect_to editprofile_path
  end

  def update_info
    p params
    @user = current_user
    unless @user.update(profile_info_params)
      flash[:notice] = "Your info is invalid!"
    else
      puts profile_info_params
      flash[:notice] = "Your info is successfully changed."
      # bypass_sign_in(@user)
    end
    redirect_to editprofile_path
  end

  def editprofile
    @user = current_user
  end

  private

  def task_params
    params.require(:request).permit(:task, :param)
  end

  def profile_info_params
    params.require(:user).permit(:first_name,:last_name,:email)
  end

  def profile_password_params
    params.require(:user).permit(:password, :new_password, :new_password_confirmation)
  end
end

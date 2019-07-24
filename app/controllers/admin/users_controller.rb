class Admin::UsersController < Admin::ManagementsController

  def index
    @users = User.order(:id).page params[:page]
  end

  def edit
    @user = User.find params[:id]
  end

  def update_avatar
    @user = User.find params[:id]
    @user.avatar =  user_avatar_params[:avatar]
    unless @user.save
      flash[:notice] = "Your selected file is invalid"
    end
    redirect_back(fallback_location: admin_users_path)
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update(user_params)
      flash[:notice] = "Successfully updated user."
      redirect_to admin_users_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if current_user.id == params[:id]
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "Successfully deleted user."
      redirect_to admin_users_path
    end
  end

  private

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :blocked)
  end

end

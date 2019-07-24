class Admin::UsersController < Admin::ManagementsController

  before_action :find_user, only: [:edit, :update, :update_avatar, :remove_avatar]

  def index
    @users = User.order(:id).page params[:page]
  end

  def edit
  end

  def update_avatar
    @user.avatar =  user_avatar_params[:avatar]
    unless @user.save
      flash[:notice] = "Your selected file is invalid"
    end
    redirect_to edit_admin_user_path
  end


  def remove_avatar
    @user.remove_avatar!
    if @user.save
      flash[:notice] = "User's avatar has successfully deleted"
    end
    redirect_to edit_admin_user_path
  end

  def update
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

  def find_user
    @user = User.find(params[:id])
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :blocked)
  end

end

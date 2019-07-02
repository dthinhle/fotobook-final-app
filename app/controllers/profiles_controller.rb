class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    p "=========#{profile_params}"
  end

  def edit
    @user = User.find(params[:id])
    puts current_user.id
    puts @user.id
    unless current_user.id == @user.id
      redirect_to profile_path(@user)
      flash[:notice] = "You can just edit other people profile like this, right?"
    end
  end

  private
  def profile_params
    params.require(:user).permit(:id,:first_name,:last_name)
  end
end

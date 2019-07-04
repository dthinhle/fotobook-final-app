class FollowsController < ApplicationController

  def create
    puts params
    followee = User.find(follow_params[:followee])
    if follow_params[:follower].to_i == current_user.id
      new_follow = Follow.new(follower_id: follow_params[:follower], followee_id: follow_params[:followee])
      new_follow.save
    else
      flash[:notice] = "You can't follow this user as another user"
    end
    # redirect_to profile_path(followee)
  end

  def destroy
    follow_destroy = Follow.where("follower_id = ? AND followee_id = ?",current_user.id ,follow_destroy_params[:id]).take
    follow_destroy.destroy
    # redirect_to profile_path(params[:id])
  end

  private

  def follow_params
    params.require(:follow).permit(:follower, :followee)
  end

  def follow_destroy_params
    params.permit(:id)
  end
end

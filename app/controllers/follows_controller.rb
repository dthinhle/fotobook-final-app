class FollowsController < ApplicationController

  def create
    followee = User.find(follow_params[:followee])
    if find_follow(current_user.id, followee.id).empty?
      new_follow = Follow.new(follower_id: current_user.id, followee_id: follow_params[:followee])
      new_follow.save
    else
      flash[:notice] = t('already-follow-notice')
    end
    Notification.create(event: "#{current_user.name} has followed you", user_id: followee.id)
  end

  def destroy
    follow_destroy = find_follow(current_user.id, follow_destroy_params[:id])
    unless follow_destroy.empty?
      follow_destroy.take.destroy
    else
      flash[:notice] = t('not-follow-notice')
    end
  end

  private

  def find_follow(follower_id, followee_id)
    Follow.where("follower_id = ? AND followee_id = ?", follower_id, followee_id)
  end

  def follow_params
    params.require(:follow).permit(:follower, :followee)
  end

  def follow_destroy_params
    params.permit(:id)
  end
end

class Admin::ManagementsController < ApplicationController

  before_action :is_admin

  private

  def is_admin
    unless current_user.admin
      flash[:error] = "You must be an admin to access this section"
      redirect_to root_path
    end
  end

end

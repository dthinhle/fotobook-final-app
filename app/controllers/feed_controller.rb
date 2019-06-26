class FeedController < ApplicationController
  before_action :authenticate_user!

  def following
  end
end

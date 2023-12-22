class GuestLoginController < ApplicationController
  skip_before_action :authenticate

  def new
  end

  def create
    redirect_to songs_path, notice: "Welcome! You have entered successfully"
  end

end
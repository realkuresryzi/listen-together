class GuestLoginController < ApplicationController
  skip_before_action :authenticate

  def new
  end

  def create

    t = Token.find_by(code: params[:code])
    puts "\n\ntoken: #{t}"

    if t
      session[:current_token] = t.code
      puts "kinda session created with token: #{Current.token}"
      redirect_to songs_path, notice: "Welcome! You have entered successfully"
    else
      redirect_to guest_login_path, alert: "Entered code is invalid..."
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You have left the jam successfully.'
  end

end
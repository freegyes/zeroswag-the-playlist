class Users::OmniauthCallbacksController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    puts spotify_user.top_tracks(time_range: 'short_term').inspect
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      # set_flash_message(:notice, :success, :kind => "Spotify") if is_navigational_format?
    else
      flash[:alert] = 'Error at omniauth'
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end

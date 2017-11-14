class Users::OmniauthCallbacksController < ApplicationController
  def spotify
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      @user.image_url = request.env["omniauth.auth"].info.images.first.try(:url)
      @user.save
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

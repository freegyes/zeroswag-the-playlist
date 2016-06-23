class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to mixtapes_path
    end
  end

  def console
    raise 'f'
  end
end

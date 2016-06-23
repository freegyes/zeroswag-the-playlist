class MixtapesController < ApplicationController
  def index
    @mixtapes = current_user.mixtapes
    @mixtape = Mixtape.new
  end
end

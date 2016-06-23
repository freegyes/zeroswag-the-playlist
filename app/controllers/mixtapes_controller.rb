class MixtapesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def index
    @owned_mixtapes = current_user.owned_mixtapes
    @mixtapes = current_user.mixtapes - current_user.owned_mixtapes
    @mixtape = Mixtape.new
  end

  def show
    @mixtape = Mixtape.friendly.find(params[:id])
  end

  def create
    mixtape = Mixtape.new(mixtape_params)
    mixtape.owner = current_user
    if mixtape.save
      # todo
      redirect_to mixtape, notice: 'Successfully created mixtape!'
    else
      redirect_to mixtapes_path, alert: 'Could not create mixtape: ' + mixtape.errors.full_messages
    end
  end

  def contribute
    mixtape = Mixtape.friendly.find(params[:id])
    mixtape.contributions.create(user: current_user)
    redirect_to mixtape
  end

  private

  def mixtape_params
    params.require(:mixtape).permit(:name)
  end
end

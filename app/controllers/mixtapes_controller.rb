class MixtapesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def index
    @owned_mixtapes = current_user.owned_mixtapes.order('created_at DESC')
    @mixtapes = current_user.mixtapes.order('created_at DESC') - current_user.owned_mixtapes.order('created_at DESC')
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

  def destroy
    current_user.mixtapes.friendly.find(params[:id]).destroy
    redirect_to mixtapes_path, notice: 'Successfully deleted mixtape locally.'
  end


  def contribute
    mixtape = Mixtape.friendly.find(params[:id])
    mixtape.contributions.create(user: current_user) unless current_user.contributes?(mixtape)
    mixtape.save
    redirect_to mixtape
  end

  private

  def mixtape_params
    params.require(:mixtape).permit(:name)
  end
end

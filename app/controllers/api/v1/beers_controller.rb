class Api::V1::BeersController < Api::V1::BaseController
  def all
    @beers = Beer.all.includes(:brewery).order_by_name
  end

  def search
    @beers = Beer.global_search(params[:query]).order_by_name
  end

  def show
    # raise
    @beer = Beer.find(params[:id])
  end
end

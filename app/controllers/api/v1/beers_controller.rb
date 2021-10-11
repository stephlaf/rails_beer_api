class Api::V1::BeersController < Api::V1::BaseController
  def index
    @beers = Beer.all.includes(:brewery).order_by_name
  end

  def search
    @beers = Beer.global_search(params[:query]).order_by_name
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :brewery, :photo, :upc)
  end
end

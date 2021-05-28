class Api::V1::TempBeersController < Api::V1::BaseController
  def index
    @temp_beers = TempBeer.all
  end

  def create

  end

  private

  def temp_beer_params
    params.require(:temp_beer).permit(:name, :brewery_name, :photo, :upc)
  end
end

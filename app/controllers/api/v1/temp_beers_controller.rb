class Api::V1::TempBeersController < Api::V1::BaseController
  def index
    @temp_beers = TempBeer.all
  end

  def show
    @temp_beer = TempBeer.find(params[:id])
    @beer = Beer.new()
  end

  def create
    @temp_beer = TempBeer.new(temp_beer_params)

    @temp_beer.photo.attach(io: temp_beer_params[:sent_photo], filename: 'photo', content_type: 'image/png')
    @temp_beer.upc_photo.attach(io: temp_beer_params[:sent_upc_photo], filename: 'upc_photo', content_type: 'image/png')

    if @temp_beer.save
      render :create
    else
      render json: { status: 500, errors: @temp_beer.errors }
    end
  end

  private

  def temp_beer_params
    params.require(:temp_beer).permit(:name, :brewery_name, :sent_photo, :sent_upc_photo)
  end
end

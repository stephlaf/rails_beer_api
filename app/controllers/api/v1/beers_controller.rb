class Api::V1::BeersController < Api::V1::BaseController
  def index
    @beers = Beer.all.includes(:brewery).order_by_name
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def search
    @beers = Beer.global_search(params[:query]).order_by_name
  end

  def create
    @beer = Beer.new(beer_params)
    @beer.brewery = Brewery.find(beer_params[:brewery_id].to_i)
    @beer.photo.attach(io: beer_params[:photo], filename: 'photo', content_type: 'image/png')

    if @beer.save
      render :show, status: :created
    else
      render json: { status: 500, errors: @beer.errors }
    end
  end

  def update
    @beer = Beer.find(params[:id])

    if @beer.update(beer_params)
      render :show
    else
      render json: { status: 500, errors: @beer.errors }
    end
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy
    render json: { message: "Beer with ID #{@beer.id} #{@beer.name} has been destroyed" }.to_json
  end

  def new_from_temp
    # @temp_beer = TempBeer.find(params[:id])

  end

  # POST
  def convert
    p @beer = Beer.new(beer_params)
    # render json: { message: "TempBeer with ID #{@temp_beer.id} has been converted" }.to_json
    render json: @beer.to_json
  end

  private

  def beer_params
    params.require(:beer).permit(
      :name,
      :brewery_id,
      :category,
      :rating,
      :ibu,
      :short_desc,
      :long_desc,
      :alc_percent,
      :photo,
      :upc
    )
  end
end

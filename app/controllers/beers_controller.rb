# require 'pry-byebug'

class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end
  
  def new_upc
    @beer = Beer.new(upc: params[:upc])
  end

  def new
    @beer = Beer.new(upc: params[:upc])
    # @beer.upc = params[:upc]
  end

  def create
    @beer = Beer.new(beer_params)

    if @beer.save
      redirect_to beer_path(@beer)
    else
      render :new_upc
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def scan
  end

  # POST /beers/get_barcode
  def get_barcode
    @upc = params[:upc]
    @beer = Beer.find_or_initialize_by(upc: @upc)
    render json: @beer
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :alc_percent, :short_desc, :long_desc, :photo, :upc)
  end
end




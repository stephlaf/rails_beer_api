require 'pry-byebug'

class BeersController < ApplicationController
  def index
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def new
  end
  
  # POST /beers/get_barcode
  def get_barcode
    @upc = params[:upc]

    @beer = Beer.find_or_initialize_by(upc: @upc)

    # binding.pry

    unless @beer.new_record?
      redirect_to beer_path(@beer)
    else
      redirect_to new_beer_path(@upc)
      # render :new
    end

    # render json: @beer
  end

  def new
    @beer = Beer.new
    # @beer.upc = params[:upc]
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end




require 'pry-byebug'

class BeersController < ApplicationController
  def index
  end

  def show
  end

  # def new
  # end
  
  # POST /beers/get_barcode
  def get_barcode
    upc = JSON.parse(params[:upc])

    binding.pry
    @beer = Beer.find_or_initialize_by(upc)

    unless @beer.new_record?
      redirect_to @beer
    else
      redirect_to new_product_path(upc)
    end
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




class TempBeersController < ApplicationController
  def index
  end

  def show
    @temp_beer = TempBeer.find(params[:id])
  end

  def new
    @brewery_names = Brewery.all.map { |brew| brew.name }
    @temp_beer = TempBeer.new(upc: params[:upc])
  end

  def create
    @temp_beer = TempBeer.new(temp_beer_params)

    if @temp_beer.save
      redirect_to root_path, flash: {notice: "Merci, nous allons y jeter un oeil 😉"}
    else
      render :new_upc
    end
  end

  def destroy
  end

  private

  def temp_beer_params
    params.require(:temp_beer).permit(:name, :brewery_name, :photo, :upc)
  end
end

class Api::V1::BeersController < Api::V1::BaseController
  def search
    if params[:query].present?
      @beers = Beer.global_search(params[:query])
    else
      @beers = Beer.includes(:brewery)
    end
  end

  def load
    @beers = Beer.includes(:brewery)
    
    beer_partials = @beers.map do |beer|
      render_to_string(partial: "beers/beer_partial", locals: { beer: beer }, formats: [:html])
    end

    render json: {
      results: beer_partials
    }
  end
end

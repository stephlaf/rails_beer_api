class Api::V1::BeersController < Api::V1::BaseController
  def search
    if params[:query].present?
      @beers = Beer.global_search(params[:query])
    else
      @beers = Beer.all
    end
  end
end

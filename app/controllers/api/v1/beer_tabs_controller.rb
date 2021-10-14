class Api::V1::BeerTabsController < Api::V1::BaseController
  def create
    @beer_tab = BeerTab.new(beer_tab_params)
    @beer_tab.user = current_user
    @beer_tab.beer = Beer.find(params[:beer_id])
  end

  private

  def beer_tab_params
    params.require(:beer_tab).permit(:rating, :content)
  end
end

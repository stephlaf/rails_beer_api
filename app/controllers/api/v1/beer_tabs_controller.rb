class Api::V1::BeerTabsController < Api::V1::BaseController
  def user_beer_tabs
    @beer_tabs = BeerTab.first_user_beer_tabs
    @counter = @beer_tabs.size
  end

  def create
    @beer_tab = BeerTab.new(beer_tab_params)
    @beer_tab.user = User.first
    @beer_tab.beer = Beer.find(params[:beer_id])

    if @beer_tab.save
      render :show
    else
      render json: { status: 500, errors: @beer_tab.errors }
    end
  end

  private

  def beer_tab_params
    params.require(:beer_tab).permit(:rating, :content, :tried)
  end
end

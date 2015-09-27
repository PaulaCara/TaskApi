class PoolsController < ApplicationController
  before_action :set_access_token

  # GET /pools
  def index
    puts 'about to get pools'
    @pools = Pool.all(params: { ungrouped: true })
    puts 'pools'
  end

  # GET /pools/:id
  def show
    @pool = Pool.find(accepted_params[:id])
  end

  # GET /pools/:id/smart_pick
  def smart_pick
    @smart_pick = []
    @smart_pick << Pool.find(accepted_params[:id]).get(:smart_pick, lines: 4)

    respond_to :js
  end

  # GET /pools/:id/settlement
  def settlements
    begin
      json = Pool.find(accepted_params[:id]).get(:settlement, payout_filter: 1)
      @settlements = Settlement.to_collection(json, accepted_params)

    rescue ActiveResource::ResourceNotFound
      flash[:error] = "The pool isn't found"
      redirect_to :back
    rescue ActiveResource::BadRequest
      flash[:error] = "Pool not closed"
      redirect_to :back
    end
  end

  private

  def set_access_token
    Pool.headers['Authorization'] = session[:access_token]
  end

  def accepted_params
    params.permit(:id)
  end
end

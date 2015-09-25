class TicketsController < ApplicationController
  before_action :set_access_token

  def create
    @pool = Pool.find(params[:pool_id])
    json = Pool.find(accepted_params[:pool_id]).get(:settlement, payout_filter: 1)

    @settlement = Settlement.get_by_id(json, accepted_params)
    @ticket = Ticket.new(@settlement[0].merge({pool_id: accepted_params[:pool_id], selections: '1,2,3/7,8/5',
                                               stake: '2.00', cost: '2.00', currency: @settlement[0][:customer_currency],
                                               poc: 'GB'}))

    if @ticket.save
      flash[:success] = 'You successfully placed the ticket'
      redirect_to @ticket
    else
      flash[:error] = 'Ticket buy failed'
      redirect_to root_path
    end
  end

  def show
    @pool = Ticket.find(params[:id])
  end

  private

  def accepted_params
    params.permit(:id, :pool_id)
  end

  def set_access_token
    Ticket.headers['Authorization'] = session[:access_token]
    Pool.headers['Authorization'] = session[:access_token]
  end
end
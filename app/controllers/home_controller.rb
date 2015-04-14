class HomeController < ApplicationController
  def index
    @stockprices = Stockprice.select('DISTINCT symbol,name')
  end

  def data
    @stockprices = Stockprice.get_for_symbol(params[:symbol])
    render json: {stockprices: @stockprices}
  end

  def create
    symbol = params[:symbol]
    name = params[:name]
    Stockprice.get_stock_data(symbol,name)    
    redirect_to action: :index
  end
end

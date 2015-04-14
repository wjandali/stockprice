class HomeController < ApplicationController
  def index
    @stockprices = Stockprice.select('DISTINCT symbol,name')
  end

  def data
    render json: {}
  end
end

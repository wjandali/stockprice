require 'rails_helper'

RSpec.describe Stockprice, type: :model do
  describe 'validations' do

    before do
      @params = { name: "Fake Stock", symbol: "FS", price: 10.00, date: Time.new }
    end

    it 'must have a name' do
      stock_price = Stockprice.create(@params.except(:name))
      expect(stock_price).to_not be_valid
    end
    it 'must have a symbol' do
      stock_price = Stockprice.create(@params.except(:symbol))
      expect(stock_price).to_not be_valid
    end
    it 'must have a date' do
      stock_price = Stockprice.create(@params.except(:date))
      expect(stock_price).to_not be_valid
    end
    it 'must have a price' do
      stock_price = Stockprice.create(@params.except(:price))
      expect(stock_price).to_not be_valid
    end


    it 'must have a price greater than zero' do
      @params[:price] = 0
      stock_price = Stockprice.create(@params)
      expect(stock_price).to_not be_valid
    end

    it 'must be unique within the scope of a day and symbol' do
      stock_price1 = Stockprice.create(@params)
      stock_price2 = Stockprice.create(@params.merge({name: 'New Name', price: 11.0, date: Time.new}))
      expect(stock_price2).to_not be_valid
    end
  end


  describe '.update_all!' do
  end

  describe '.update!' do
  end

  describe '.add_stock' do
  end
end

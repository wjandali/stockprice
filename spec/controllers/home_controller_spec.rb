require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe '#index' do
  end

  describe '#data' do
    before do
      31.times do |i|
        Stockprice.create(price: 1.0, name: "some name", symbol: "T", date: Time.now - i.days)
      end
    end
    it 'should return the data for the last 30 days' do
      get :data, {symbol: "T"}
      data = JSON.parse(response.body)
      expect(data["stockprices"].length).to eq(30)
    end
  end
end

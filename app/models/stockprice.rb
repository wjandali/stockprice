class Stockprice < ActiveRecord::Base
  validates :name, presence: true
  validates :symbol, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :price, numericality: { greater_than: 0 }

  include HTTParty

  base_uri 'http://api.kibot.com'

  def self.get_for_symbol(symbol)
    latest = where(symbol: symbol).order('date desc').first
    name = latest.name

    days_old = (Time.now.to_date - latest.updated_at.to_date).to_i

    days_old = 40 if days_old > 40 # assume there will never be under 30 trading days in any 40 day period
    
    get_stock_data(symbol, name, days_old)
    where(symbol: symbol).order('date desc').limit(30) # Caching could be used here, but such a small query
  end

  def self.get_stock_data(symbol, name, period=40)
    get('http://api.kibot.com/?action=login&user=guest&password=guest') # ensure login
    response = get("http://api.kibot.com/?action=history&symbol=#{symbol}&interval=daily&period=#{period}")
    response.body.split("\r").each do |line|
      date_string, price = line.split(",")
      month,day,year = date_string.split("/").map(&:to_i)
      return unless month && day && year
      date = DateTime.new(year,month,day)
      Stockprice.find_or_create_by(date: date, price: price, name: name, symbol: symbol)
    end
  end
end

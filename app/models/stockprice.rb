class Stockprice < ActiveRecord::Base
  validates :name, presence: true
  validates :symbol, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :price, numericality: { greater_than: 0 }

end

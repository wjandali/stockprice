require 'rails_helper'

RSpec.feature "Index", :type => :feature do

  subject { page }

  before(:all) do
    Stockprice.create(name: "Fake Google", symbol: "GOOG", price: 1.3, date: Time.now)
  end

  describe 'the dropdown list' do

    before(:each) do
      visit root_path
    end

    it 'should have no content when nothing has been selected' do
      pending
    end

    it 'should update when a selection is made', :js => true do
      select('Fake Google')
      expect(page).to have_css('.filled')
    end

    it 'should have all existing stock tickers', :js => true do
      expect(all('select option').length).to eq(Stockprice.select('DISTINCT symbol').all.length)
    end
  end

end

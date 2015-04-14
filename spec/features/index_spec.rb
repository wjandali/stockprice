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
      pending "this is not a critical test"
    end

    it 'should update when a selection is made', :js => true do
      pending "not sure how to test a canvas, don't want to waste time"
    end

    it 'should allow creation of a new stock profile' do
      fill_in('name', with: 'Apple')
      fill_in('symbol', with: 'AAPL')
      click_button 'Create'
      expect(page).to have_content "Apple"
    end

    it 'should have all existing stock tickers', :js => true do
      expect(all('select option').length).to eq(Stockprice.select('DISTINCT symbol').all.length + 1) 
    end
  end

end

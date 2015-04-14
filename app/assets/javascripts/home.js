// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var Home = {
  accept: function(view) {
    var context = this;
    var stockprices;
    var symbol;
    this.ctx = view.find('#chart').get(0).getContext('2d');
    view.find('select').on('change', function() {
      symbol = $(this).val();
      if (!symbol) { return; }
      if (context.queried[symbol]) {
        stockprices = context.queried[symbol];
        context.draw(stockprices, symbol);
      } else {
        $.ajax({
          url: '/data',
          dataType: 'json',
          data: {symbol: symbol},
          success: function (data, textStatus, jqXHR) {
            stockprices = data.stockprices;
            context.queried[symbol] = stockprices;
            context.draw(stockprices, symbol);
          }
        });
      }
    });
  },

  draw: function(stockprices, symbol) {
    var dates = $.map(stockprices, function(stockprice) { return stockprice.date; });
    var prices = $.map(stockprices, function(stockprice) { return stockprice.price; });
    var data = {
      labels: dates,
      datasets: [
        {
          label: symbol,
          fillColor: "rgba(220,220,220,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "rgba(220,220,220,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: prices
        }
      ]
    }
    new Chart(this.ctx).Line(data, {bezierCurve: false});
  },

  queried: {}

}


$(document).ready(function() {
  Home.accept($('body'));
});

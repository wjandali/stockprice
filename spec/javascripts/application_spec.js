describe("Application", function() {
  var view;

  beforeEach(function() {
    view = '<div class="chart-container">' +
    '<div class="selection-container">' +
    '<select class="selection">' +
    '<option value=""></option>' +
    '<option value="FA">Fake Stock</option>' +
    '</select>' +
    '</div>' +
    '<div class="chart">' +
    '</div>' +
    '</div>'
    view = $(view);
    wrapChart(view);
  });

 describe("selecting a stock", function() {
   beforeEach(function() {
     var option = $('option').last();
     view.find('select').val(option.val());
   });

   it("should issue an AJAX request", function() {
   });

   describe("selecting again", function() {
     beforeEach(function() {
       var option = $('option').last();
       view.find('select').val('');
       view.find('select').val(option.val());
     });

     it("should not issue an AJAX request", function() {
     });
   });
 });

//  describe ("adding a stock", function() {
//  });
});

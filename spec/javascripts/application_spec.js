describe("Application", function() {
  var view;
  var request;

  beforeEach(function() {
    jasmine.Ajax.install();
    view = '<div class="chart-container">' +
    '<div class="selection-container">' +
    '<select class="selection">' +
    '<option value=""></option>' +
    '<option value="FA">Fake Stock</option>' +
    '</select>' +
    '</div>' +
    '<div class="chart">' +
    '<canvas id="chart" width="400" height="400"></canvas>' +
    '</div>' +
    '</div>'
    view = $(view);
    Home.accept(view);
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
    Home.queried = {}; // not fancy, but I'm running out of time =]
  });

 describe("selecting a stock", function() {
   beforeEach(function() {
     spyOn(Home, 'draw');
     var option = view.find('option').last();
     view.find('select').val(option.val()).change();
     request = jasmine.Ajax.requests.mostRecent();
     var json = {
       symbol: 'FA',
       stockprices: [{date: '01/01/2001', price: 2.0}, {date: '01/02/2001', price: 1.0}]
     }
     request.respondWith({
       status: 200,
       responseText: JSON.stringify(json) 
     });
   });

   it("should draw a chart", function() {
     expect(Home.draw).toHaveBeenCalled();
   });

   it("should update the symbol cache", function() {
     expect(Home.queried["FA"]).toEqual([{date: '01/01/2001', price: 2.0}, {date: '01/02/2001', price: 1.0}]);
   });

   describe("selecting again", function() {
     beforeEach(function() {
       spyOn($, 'ajax');
       var option = view.find('option').last();
       view.find('select').val('').change();
       view.find('select').val(option.val()).change();
     });

     it("should not issue an AJAX request", function() {
       expect($.ajax).not.toHaveBeenCalled();
     });
   });

 });

//  describe ("adding a stock", function() {
//  });
});

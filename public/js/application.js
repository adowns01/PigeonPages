$(document).ready(function () {

  getEbookData();

});


var getEbookData = function(){

  var ajaxRequest = $.ajax({
    url: '/ebooks',
    type: 'GET'
  })
  ajaxRequest.success(function(data){
    ebook_data = [['ebook', data.ebook], ['paper', data.paper]]
    console.log(ebook_data)

    graphEbookData(ebook_data)
  })


}

var graphEbookData= function(data){

  $('#container').highcharts({
    chart: {
      plotBackgroundColor: null,
            plotBorderWidth: 0,//null,
            plotShadow: false
          },
          colors: ["#ff8e4e", "#ff9d4e", "#ffac4e", "#ffbb4e", "#ffc94e"],
          title: {
            text: ''
          },
          tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                  color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
              }
            }
          },
          series: [{
            type: 'pie',
            name: 'Browser share',
            data: data
          }]
  });

}
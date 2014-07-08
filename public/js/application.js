$(document).ready(function () {

  getEbookData();
  getPublicationYearData();

});


var getPublicationYearData = function(){

  var ajaxRequest = $.ajax({
    url: '/publication_year',
    type: 'GET'
  })
  ajaxRequest.success(function(data){
    data = parsePublicationYears(data)
    graphPublicationYearData(data);
  })


}


var parsePublicationYears = function(data){
  decades = []
  for(var i=0; i<9; i++){
    decades.push([(1930 + i*10).toString()+'s', 0])
  }

  for (var i=0; i<data.length; i++){
  var location = parseInt((Number(data[i]) % 1930)/10 )
    console.log(location)
    decades[location][1] += 1
  }
  return decades
}



var graphPublicationYearData = function(data){

  $('#publication_year').highcharts({
    chart: {
      type: 'column'
    },
    colors: ["#ff8e4e", "#ff9d4e", "#ffac4e", "#ffbb4e", "#ffc94e"],

    title: {
      text: 'Number of Books by Publication Year'
    },
    xAxis: {
      type: 'category',
      labels: {
        rotation: -45,
        style: {
          fontSize: '13px',
          fontFamily: 'Verdana, sans-serif'
        }
      }
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Number of Books'
      }
    },
    legend: {
      enabled: false
    },
    tooltip: {
      pointFormat: 'Population in 2008: <b>{point.y:.1f} millions</b>',
    },
    series: [{
      name: 'Population',
      data: data,
      dataLabels: {
        enabled: true,
        rotation: -90,
        color: '#FFFFFF',
        align: 'right',
        x: 4,
        y: 10,
        style: {
          fontSize: '13px',
          fontFamily: 'Verdana, sans-serif',
          textShadow: '0 0 3px black'
        }
      }
    }]
  });
}



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
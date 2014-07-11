$(document).ready(function () {
  if (needScrollBar()){
    addScrollBar();
  }
});

var needScrollBar = function(){
 return ($('.content').height() >= 610)
}

var addScrollBar = function(){
  $('.content').addClass('overflow')
}
$(document).ready(function() {
  var pageItem = $(".enlaces span").not(".previous,.next");
  var prev = $(".enlaces span.previous");
  var next = $(".enlaces span.next");

  pageItem.click(function() {
    pageItem.removeClass("current");
    //$(this).not(".previous,.next").removeAttr("style");
    $(this).not(".previous,.next").addClass("current");
  });

  next.click(function() {
  	//$('span').removeClass('current').prev().addClass('current');
  	//const last=$("enlaces a.next");
  	//if($(next) != $('span.current').next()){
    	$('span.current').removeClass('current').next().addClass('current');
    //location.href = $("span").nextSibling;
    //};
  });

  prev.click(function() {
  	//const first=$("enlaces a.previous");  
  	//if($('span.current').not(".previous,.next")){
    	$('span.current').removeClass('current').prev().addClass('current');
    	//location.href = $("span").previousSibling;
    //};
  });


});

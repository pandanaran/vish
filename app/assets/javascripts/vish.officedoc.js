Vish.Officedoc = (function(V,undefined){

var calculate = function(anch){
	return -($(anch).width() / 2);

}

var redim = function(anch){

$('.resize').css({
        width: 'auto',
        'margin-left': calculate(anch)
    });
	
}

var googdoc = function(){
  	var height = ($('.resize').height())*(8/10);
  	setTimeout(function(){
  	$('#gdoc').css("height", height);
	},500);
}

var rwindow = function(){
	var height = ($('.resize').height())*(9/10);
  	$(window).resize(function () {
  	var height = ($('.resize').height())*(8/10);
  	$('#gdoc').css("height", height);

});

}

var removeM = function(){
      var divs_tmp2 = $("div[id^='picture-modal-']");  //resize
      var divs_tmp1 = $("div[id^='picture-modal-body']");     //footar  
      var divs_tmp3 = $("div[id^='modyfooter']");           //sticky
      
          console.log(divs_tmp3); //sticky
          console.log(divs_tmp2); //resize
          console.log(divs_tmp1); //footar  

           divs_tmp1.removeClass('footar')
           divs_tmp2.removeClass('resize')
           divs_tmp3.removeClass('sticky')

}

return {
  redim: redim,
  rwindow : rwindow,
  googdoc : googdoc,
  removeM : removeM,
}

}) (Vish);

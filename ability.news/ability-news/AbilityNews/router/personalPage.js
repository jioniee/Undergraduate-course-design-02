

$(function(){
    $(".hide1").hide();
     $("#nav-title1 a").click(function () {
            var navEle=$(this).parents(".side-bar").children(".hide1");
            if(navEle.css("display")!="none"){
                navEle.slideUp();
            }else{
                navEle.slideDown(800);
            }
          }) 
});
	
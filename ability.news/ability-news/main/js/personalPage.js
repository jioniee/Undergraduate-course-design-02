/*var aList=document.querySelectorAll('.list-group-item');
var aHide1=document.querySelectorAll('#hide1');
var aHide2=document.querySelectorAll('#hide2');
var aIcon=document.querySelectorAll('.list-group-item i');
aList[2].onclick=function(){
    aList[2].style.backgroundColor='white';
    aHide1[0].style.height='40px';
    aHide1[0].style.padding='10px 15px';
    aHide1[0].style.margin='0 0 2px';
    aHide2[0].style.margin='0 0 5px';
    aHide2[0].style.padding='10px 15px';
    aHide2[0].style.height='40px';

}*/

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
	
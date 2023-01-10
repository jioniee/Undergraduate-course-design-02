
window.onload = function () {

    var leftBtn = document.getElementById('leftBtn');
    var rightBtn = document.getElementById('rightBtn');
    var textBtn = document.getElementById('text_button');
    var imageBtn = document.getElementById('image_button');
    var setText = false;
    var setImage = true;
    var textContent= document.getElementById('banner_text');

    var points = document.getElementById('points');
    //get the points
    var points = points.children;


    //addScript('router/home.js');

    console.log(points);
    //Cyclic mount click event

    for(var i= 0; i< points.length; i++){
        points[i].index = i;
        points[i].onclick = function(){
            change(this.index);
        }
    }


    var banner = document.getElementById('banner');
    var imgArr = ["public/home/img/welcome.jpg"];
    var textArr = [];

        $.ajax({
            url:'/recommend',
            success:function(dataobj){

                textArr=dataobj.title_arr;
                imgArr=dataobj.img_arr;
            },
            error:function(data){

            }
        })


    $(banner).css('background-image', 'url('+imgArr[0]+')');

    var count = 0;
    function change(index){
        count = index;
        var lastImage = imgArr[count - 1];
        var image = imgArr[count];
        var text = textArr[count];

        if (setImage) {
            $(banner).css('background-image', 'url('+lastImage+')').fadeOut('slow', function() {
                $(banner).css('background-image', 'url('+image+')').fadeIn('slow');
            });
            // banner.style.backgroundImage= `url(${image})`;

            banner.style.backgroundSize="1000px 580px"
            textContent.innerText = text;
            textContent.style.top = '90%';
            textContent.style.fontSize =  '24px';
            textContent.style.color = 'White';
            textContent.style.backgroundColor = 'Black';

        } else {
            textContent.innerText = text;
            banner.style.backgroundImage= '';
            textContent.style.top = '50%';
            textContent.style.fontSize =  '48px';
            textContent.style.color = '#666';
        }

        for(var i = 0; i < points.length ; i++){
            points[i].className = 'normal';
        }

        points[index].className = 'shover';
    }

    //Control the picture to slide to the left to the previous page
    leftBtn.onclick = function(){
        count --;
        //If count is the first one, skip to the last one
        if(count == -1){
            count = imgArr.length-1;
        }
        change(count);
    }
//Control the picture to slide to the right to the next page
    rightBtn.onclick = function(){
        count ++;
        //If the picture is the last one, start from the beginning
        if(count == imgArr.length){
            count = 0;
        }
        change(count);
    }

    textBtn.onclick = function(){
        setText = true;
        setImage = false;
        change(count);
    }

    imageBtn.onclick = function(){
        setText = false;
        setImage = true;
        change(count);
    }

    //timer
    var bannerTime = setInterval("rightBtn.onclick()",10000);
    //Close when moving into the banner
    banner.onmouseover = function(){
        clearInterval(bannerTime);
    }
    //Move out and reopen
    banner.onmouseout = function(){
        bannerTime = setInterval("rightBtn.onclick()",10000);
    }





}


/**
 * @param {*} fileDIV The upload area is a dom element
 * @param {*} boxSize The size of the box that holds the picture
 */
function uploads(fileDIV, boxSize) {
    var config = {
        div: document.createElement('div'),
        upload: document.createElement("div"),
        showImg: document.createElement("img"),
        remove :document.createElement('div'),
    }
    // Create an area for storing upload buttons and pictures
    createDom();
    // Bound event area
    bindEvent();

    // Initialize the upload area
    function createDom() {
        var div = config.div;
        div.className = "file";
        div.style.position = "relative";
        div.style.display = "inline-block";
        div.style.perspective = "800px";
        div.style.transformStyle = 'preserve-3d';
        div.style.width = boxSize + 'px';
        fileDIV.parentNode.insertBefore(div, fileDIV);
        fileDIV.parentNode.appendChild(div);
        div.appendChild(fileDIV);
        var upload = config.upload;
        upload.className = "upload";
        upload.innerHTML = 'upload image';
        upload.style.backgroundColor = '#3399cc';
        upload.style.color = '#fff';
        upload.style.width = '100%';
        upload.style.textAlign = 'center';
        upload.style.border = '0 none';
        upload.style.outline = '0 none';
        upload.style.lineHeight = '30px';
        upload.style.cursor = 'pointer';
        upload.style.borderRadius = '5px';
        div.insertBefore(upload, fileDIV);
        var showImg = config.showImg;
        showImg.setAttribute('alt', 'No files selected');
        showImg.setAttribute('width', boxSize);
        showImg.setAttribute('height', boxSize);
        showImg.style.display = 'none';
        showImg.style.boxSizing = 'border-box';
        showImg.style.margin = '10px 0';
        showImg.style.transition = 'all 0.3s ease-in-out';
        insertAfter(showImg, fileDIV);
        fileDIV.style.position = 'absolute';
        fileDIV.style.top = '99999em';
        // fileDIV.style.visibility = 'hidden';
    }
    // Bound event
    function bindEvent() {
        config.showImg.onmouseenter = function () {
            config.showImg.style.boxShadow = '0 0 5px rgba(20,20,20,0.7)';
            config.showImg.style.transform = 'scaleY(1.01)';
        }
        config.showImg.onmouseleave = function () {
            config.showImg.style.boxShadow = '';
            config.showImg.style.transform = '';

        }
        // Remove picture
        config.remove.onclick = function () {
            fileDIV.value = '';
            config.showImg.style.display = 'none';
            config.remove.innerHTML = '';
            return;

        }
        // upload
        config.upload.onclick = function(){
            fileDIV.click();
        }
        fileDIV.onchange = function () {
            config.showImg.onload = function(){
                config.showImg.style.display = 'block';
                config.remove.className = 'remove';
                config.remove.innerHTML = 'X';
                config.remove.style.position = 'absolute';
                config.remove.style.right = '5px';
                config.remove.style.top = '40px';
                config.remove.style.color = '#fff';
                config.remove.style.zIndex = '10';
                config.remove.style.cursor = 'pointer';
                insertAfter(config.remove, fileDIV, config.showImg);
            }
            var str = this.files[0].name;
            var size = this.files[0].size;
            var arr = str.split("\\");//Separate image path
            var filename = arr[arr.length - 1];//Get picture name
            var fileExtArr = filename.split(".");//Delimited format picture
            var fileExt = fileExtArr[fileExtArr.length - 1];//Get image suffix
            // Determine file type
            if (fileExt != 'jpg' && fileExt != 'gif' && fileExt != 'png' && fileExt != 'jpeg') {
                alert('Please upload pictures in jpg, gif, png, jpeg format');
                this.value = '';
                config.showImg.style.display = 'none';
                return;
            }
            // Determine file size
            var fileSize = 1024 * 1024 * 2;
            if (size >= fileSize) {
                alert("Uploaded picture must not be larger than 2M");
                this.value = '';
                config.showImg.style.display = 'none';
                return;
            }
            //Create fileReader object
            var reader = new FileReader();
            //Picture encoding is complete
            reader.onloadend = function (e) {
                config.showImg.src = e.target.result;
                console.log(reader.result);
            }
            //Parse pictures into base 64-bit pictures Use readAsDataURL 
            // of fileReader to read local picture objects
            reader.readAsDataURL(this.files[0]);
        }
    }
    function insertAfter(newElement,targetElement){
        var parent = targetElement.parentNode;
        if(parent.lastChild == targetElement){
            parent.appendChild(newElement);
        }else{
            parent.insertBefore(newElement,targetElement.nextSibling);
        }
    }

}
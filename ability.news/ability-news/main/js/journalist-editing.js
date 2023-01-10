// The following two functions two set the onclick listener to 
// add new fields when button clicked
$("#addAuthor").click(function(){
     let newAuthor = document.createElement("div");
     let f = $(".author-first-block").html();
     newAuthor.innerHTML = f;
     $(".author_contact").append(newAuthor);
})

$("#addEditor").click(function(){
     let newEditor = document.createElement("div");
     let f = $(".editor-first-block").html();
     newEditor.innerHTML = f;
     $(".editor_contact").append(newEditor);
})

// the following function load a local picture for the cover of the news
 document.getElementById('upload-pic-btn').onclick = function() {
     document.getElementById('fileInput').click();
 };

$("#fileInput").change(function (e) { 
      let path = getImageUrl(document.getElementById("fileInput").files[0]);
      console.log(path);
      $('#loaded-cover-picture').attr('src', path)
 });

 function getImageUrl(file) {
     var url = null;
     if (window.createObjcectURL !== undefined) {
           url = window.createOjcectURL(file);
  } else if (window.URL !== undefined) {
           url = window.URL.createObjectURL(file);
  } else if (window.webkitURL !== undefined) {
          url = window.webkitURL.createObjectURL(file);
  }
    return url;
}

// this function deletes the cover picture of the news
$("#delete-pic-btn").click(function (e) { 
     $("#loaded-cover-picture").attr('src', "https://dummyimage.com/600x400/222222/999999.png&text=News");
});

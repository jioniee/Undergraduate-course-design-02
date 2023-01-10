// Import express
const express = require("express");
// Instantiate router
const router = express.Router();
//Setup file upload
const multer = require("multer");
// Set up a temporary directory for storing files
const upload = multer({ dest: "tmp/" });
// Import database module
const mysql = require("../../config/db.js");
// Introduce image upload method
const uploads = require("../../common/uploads");
// Format timestamp
const moment = require("moment");
// Import pagination method
const page = require("../../common/page");
// Import file system module-execute delete a file operation
const fs = require("fs");

//main page
router.get("/", function (req, res, next) {
    // Step 1: Get the data on the page and URL. 
    // If there is p on the URL with data, get the value of p, otherwise take 1
    let p = req.query.p ? req.query.p : 1;
    // search
    let search = req.query.search ? req.query.search : "";
    // Step 2: The default number of data displayed on each page
    let size = 5;
    // Step 2: Calculate where the page number starts
    let start = (p - 1) * size;
    // Step 3: Count the total number of data in the database
    mysql.query("select count(*) tot from news,topic type where news.cid = type.id and title like ? ", ['%' + search + '%'], function (err, data) {
        if (err) {
            return '';
        } else {
            let tot = data[0].tot; //Get the number of data
            let fpage = page(tot, p, size); //
            // Query related data from the data
            mysql.query("select news.*,type.name tname from news,topic type where news.cid = type.id and title like ? order by news.id desc limit ?,?", [`%${search}%`, fpage.start, fpage.size], function (err, data) {
                if (err) {
                    return "";
                } else {
                    // Format timestamp
                    data.forEach(item => {
                        item.time = moment(item.time * 1000).format("YYYY-MM-DD HH:mm:ss");
                    })
                    // Load news management homepage
                    res.render("admin/news/index.html", { data: data, search: search, show: fpage.show });
                }
            });

        }

    });
});

// Add page for news management
router.get("/add", function (req, res, next) {
    mysql.query("select * from topic order by sort desc", function (err, data) {
        if (err) {
            return "";
        } else {
            // Load the news management add page
            res.render("admin/news/add.html", { data: data });
        }
    });
});
router.post("/add", upload.single("img"), function (req, res, next) {
    // Receive file upload resources
    let imgRes = req.file;
    let {title, author, cid, text, summary} = req.body;
    let time = (Math.round(new Date().getTime()) / 1000);//Timestamp in seconds, needs to be converted to milliseconds
    // Image upload
    let img = uploads(imgRes, "news");//Return the address where the picture is stored
    // Continue database insert
    mysql.query("insert into news(title, author, cid, text, img, time, summary, recommended, likeNumber) value(?,?,?,?,?,?,?,?,?)",
        [title, author, cid, text, img, time, summary, 0, 0], function (err, data) {
            if (err) {
                return "";
            } else {
                if (data.affectedRows == 1) {
                    res.send("<script>alert('success');location.href = '/admin/news'</script>");
                } else {
                    res.send("<script>alert('failure');history.go(-1)</script>");

                }
            }
        });

})
// Edit page for news management
router.get("/edit",function(req,res,next){
    // Get the incoming data
    let id = req.query.id;
    // Query database classification page
    mysql.query("select * from topic order by sort desc",function(err,data){
        if(err){
            return "";
        }else{
            // Query database news page
            mysql.query("select * from news where id = "+id,function(err,data2){
                if(err){
                    return "";
                }else{
                    // What data2 takes out is a two-dimensional array
                    res.render("admin/news/edit.html",{data:data , newDate:data2[0]});
                }
            })
           
        }
    });

});
// Modification function of news management
router.post("/edit",upload.single("img"),function(req,res,next){
    // Receive data from the post method
    let imgRes = req.file;
    let {id,cid,text,oldimg,author,title,summary} = req.body;
    let img = oldimg;
    // Determine whether the user modifies the picture
    if(imgRes){
        // Get the path returned by replacing the new image,
       img = uploads(imgRes,"news");//The root directory is upload
    }
    // Send sql statement to modify data
    mysql.query("update news set cid = ? , text = ? , author= ? , title= ? , img = ? , summary = ? where id = ?",
    [cid,text,author,title,img,summary,id],function(err,data){
        if(err){
            return "";
        }else{

            if(data.affectedRows == 1){
                // Determine whether the user has modified the picture
                if(imgRes){
                    if(fs.existsSync(__dirname+"/../../"+oldimg)){
                        fs.unlinkSync(__dirname+"/../../"+oldimg);
                    }
                }
                res.send("<script>alert('success');location.href = '/admin/news'</script>");
            }else{
                res.send("<script>alert('failure');history.go(-1)</script>");

            }
        }
    });
})
// Delete news data without refresh
router.get("/ajax_del",function(req,res,next){
    // Receive the data to be deleted
    let {id,img} =  req.query;
    mysql.query("delete from news where id ="+id,function(err,data){
        if(err){
            return "";
        }else{
            if(data.affectedRows == 1){
                // Delete picture
                if(fs.existsSync(__dirname+"/../../"+img)){
                    fs.unlinkSync(__dirname+"/../../"+img);
                }
                res.send("1");
            }else{
                res.send("0");
            }
        }
    });
})
module.exports = router;
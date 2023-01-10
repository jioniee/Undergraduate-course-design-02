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
    // Step 1: Get the data on the page and URL. If there is p on the URL with data, get the value of p, otherwise take 1
    let p = req.query.p ? req.query.p : 1;
    // search
    let search = req.query.search ? req.query.search : "";
    // Step 2: The default number of data displayed on each page
    let size = 5;
    // Step 2: Calculate where the page number starts
    let start = (p - 1) * size;
    // Step 3: Count the total number of data in the database
    mysql.query("select count(*) tot from news,topic type where news.cid = type.id and news.recommended = 1 and title like ? ", ['%' + search + '%'], function (err, data) {
        if (err) {
            return '';
        } else {
            let tot = data[0].tot; //Get the number of data
            let fpage = page(tot, p, size); //
            // Query related data from the data
            mysql.query("select news.*,type.name tname from news,topic type where news.cid = type.id and news.recommended = 1 and title like ? order by news.id desc limit ?,?", [`%${search}%`, fpage.start, fpage.size], function (err, data) {
                if (err) {
                    return "";
                } else {
                    // Format timestamp
                    data.forEach(item => {
                        item.time = moment(item.time * 1000).format("YYYY-MM-DD HH:mm:ss");
                    })
                    // Load news management homepage
                    res.render("admin/recommend/index", { data: data, search: search, show: fpage.show });
                }
            });

        }

    });
});

// Add page for news management0
router.get("/add", function (req, res, next) {
    // mysql.query("select news.*,type.name tname from news,topic type where news.cid = type.id and recommended <> 1 order by id", function (err, data) {
    //     if (err) {
    //         return "";
    //     } else {
    //         // Load the news management add page
    //         res.render("admin/recommend/add", { data: data });
    //     }
    // });
    let p = 1;
    // Step 2: The default number of data displayed on each page
    let size = 5;
    let start = (p - 1) * size;
    // Step 3: Count the total number of data in the database
    mysql.query("select count(*) tot from news,topic type where news.cid = type.id and recommended = 0", function (err, data) {
        if (err) {
            return '';
        } else {
            let tot = data[0].tot; //Get the number of data
            let fpage = page(tot, p, size); //
            // Query related data from the data
            mysql.query("select news.*,type.name tname from news,topic type where news.cid = type.id and recommended = 0 order by news.id desc limit ?,?", [fpage.start, fpage.size], function (err, data) {
                if (err) {
                    return "";
                } else {
                    // Format timestamp
                    data.forEach(item => {
                        item.time = moment(item.time * 1000).format("YYYY-MM-DD HH:mm:ss");
                    })  
                    // Load news management homepage
                    res.render("admin/recommend/add", {data: data, show: fpage.show });
                }
            });
        }

    });
});


router.get("/ajax_set",function(req,res,next){
    // Receive the data to be modified
    let {id} =  req.query;
    mysql.query("update news set recommended = 1 where id =" + id,function(err,data){
        if(err){
            return "";
        }else{
            res.send("1");
        }
    });
})

router.get("/ajax_del",function(req,res,next){
    // Receive the data to be deleted
    let {id} =  req.query;
    mysql.query("update news set recommended = 0 where id =" + id,function(err,data){
        if(err){
            return "";
        }else{
            res.send("1");
        }
    });
})
module.exports = router;
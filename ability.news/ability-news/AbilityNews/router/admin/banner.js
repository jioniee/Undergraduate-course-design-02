//import express
let express = require("express");
//initialization
let router = express.Router();
//Setup file upload
const multer = require("multer");
// Set up a temporary directory for storing files
const upload = multer({ dest: "tmp/" });
// Introduce the path module to get the file name suffix
const path = require('path');
// Import file system module
const fs = require("fs");
//Call the database module
const mysql = require('../../config/db.js');
// Call paging method
const page = require("../../common/page.js");

//main page
router.get("/", function (req, res, next) {
    // Step 1: Get the data on the page and URL. If there is p on the URL with data,
    // get the value of p, otherwise take 1
    let p = req.query.p ? req.query.p : 1;
    // search
    let search = req.query.search ? req.query.search : "";
    // Step 2: The default number of data displayed on each page
    let size = 5;
    // Step 2: Calculate where the page number starts
    let start = (p - 1) * size;
    // Step 3: Count the total number of data in the database
    mysql.query("select count(*) tot from banner where name like ? ", ['%' + search + '%'], function (err, data) {
        if (err) {
            return '';
        } else {
            let tot = data[0].tot; //Get the number of data
            let fpage = page(tot, p, size); //
            // Query eligible data from the database
            mysql.query("select * from banner where name like ? order by id desc limit ?,?", [`%${search}%`, fpage.start, fpage.size], function (err, data) {
                // Determine whether the execution is successful
                if (err) {
                    return "";
                } else {
                    //Render the page and transfer the data
                    res.render("admin/banner/index.html", { data: data, search: search, show: fpage.show });
                }
            });
        }
    });

});
//add
router.get("/add", function (req, res, next) {
    // Add page
    res.render('admin/banner/add.html');
});
router.post("/add", upload.single("img"), function (req, res, next) {
    // Receive the data submitted by the form
    let { name, url, sort } = req.body;
    // Receiving data related to file upload
    let imgRes = req.file;
    // Get the temporary directory of the file
    let tmpPath = imgRes.path;  
    // Generate picture name: current timestamp plus suffix
    let newName = "" + (new Date().getTime()) + Math.round(Math.random() * 10000);
    // Get the suffix of the uploaded file name
    let ext = path.extname(imgRes.originalname);  //eg. .png
    // Set the specified directory for file upload
    let newPath = "/upload/banner/" + newName + ext;
    // Make a file copy
    let fileData = fs.readFileSync(tmpPath);//Synchronously read the contents of the file
    fs.writeFileSync(__dirname + "/../../" + newPath, fileData);//Synchronously write the content of the read file to the new file
    //Insert data into the database
    mysql.query("insert into banner(name,url,sort,img) value(?,?,?,?)", [name, url, sort, newPath], function (err, data) {
        if (err) {
            return "";
        } else {
            if (data.affectedRows == 1) {
                res.send("<script>alert('successful');location.href='/admin/banner'</script>");
            } else {
                res.send("<script>alert('failure');history.go(-1)</script>");
            }
        }
    });

});
//modify
// Modify page
router.get("/edit", function (req, res, next) {
    //Get the id of the data to be modified
    let id = req.query.id;

    // Query corresponding data by id
    mysql.query("select * from banner where id = ? ", [id], function (err, data) {
        if (err) {
            return "";
        } else {
            res.render("admin/banner/edit.html", { data: data[0] });
        }
    });

});
// Modification function Get the picture information when uploading
router.post("/edit", upload.single("img"), function (req, res, next) {
    // Receive picture information
    let imgRes = req.file;
    // Receive form information
    let { id, name, url, sort, oldimg } = req.body;
    // Determine whether the image resource exists to confirm whether to modify the image
    let sql = "";
    let arr = []
    if (imgRes) {
        // If the user clicks to upload a picture, upload the picture first
        // Call function, provide picture information and upload to which specific directory
        let img = uploads(imgRes, "slider")
        sql = "update banner set name = ?,url = ?,sort = ?, img = ? where id= ?";
        arr = [name, url, sort, img, id];
    } else {
        sql = "update banner set name = ?,url = ?,sort = ? where id= ?";
        arr = [name, url, sort, id];
    }
    // Send sql statement
    mysql.query(sql, arr, function (err, data) {
        if (err) {
            return "";
        } else {
            if (data.affectedRows == 1) {
                //Determine whether the picture has been modified
                // If the old picture exists, delete the picture
                if (fs.existsSync(__dirname + "/../../" + oldimg)) {
                    fs.unlinkSync(__dirname + "/../../" + oldimg);
                }
                res.send("<script>alert('success');location.href ='/admin/banner' </script>");
            } else {
                res.send("<script>alert('failure');history.go(-1) </script>");
            }
        }
    })
});
//delete
router.get("/ajax_del", function (req, res, next) {
    // Receive the data that the user wants to delete
    let { id, img } = req.query;
    // delete data
    mysql.query("delete from banner where id = ?", [id], function (err, data) {
        if (err) {
            return "";
        } else {
            if (data.affectedRows == 1) {
                // Delete the corresponding picture
                // Determine whether the picture exists
                if (fs.existsSync(__dirname + "/../../" + img)) {
                    // Delete the corresponding picture if it exists
                    fs.unlinkSync(__dirname + "/../../" + img);
                }
                res.send("1");
            } else {
                res.send("0");
            }
        }
    });
});
// No refresh modification sorting function
router.get("/ajax_sort", function (req, res, next) {
    // Receive data
    let { id, sort } = req.query;
    // Data modification
    mysql.query("update banner set sort = ? where id = ? ", [sort, id], function (err, data) {
        if (err) {
            return "";
        } else {
            if (data.affectedRows == 1) {
                res.send("1");
            } else {
                res.send("0");
            }
        }
    });
})
module.exports = router;
// Import express framework
const express = require("express");
// Instantiate router
const router = express.Router();
// Import database related content
const mysql = require("../../config/db.js");
// home
router.get("/", function (req, res, nxet) {
    // search
    let search = req.query.search ? req.query.search : "";
    // Query related data from the database
    mysql.query("select * from topic where name like ? order by sort desc",['%' + search + '%'], function (err, data) {
        if (err) {
            return "";
        } else {
            // Load page
            res.render("admin/newstype/index.html", { data: data });
        }
    });

});
// Category add page
router.get("/add", function (req, res, nxet) {
    // Load the add page
    res.render("admin/newstype/add.html");
});

// Add operation of category
router.post("/add", function (req, res, next) {
    // Receive the parameters passed by the post method
    let { name, keywords, description, sort } = req.body;
    // Insert data into the database
    mysql.query("insert into topic(name,keywords,description,sort) value(?,?,?,?)", [name, keywords, description, sort], function (err, data) {
        if (err) {
            return "";
        } else {
            if (data.affectedRows == 1) {
                res.send("<script>alert('success');location.href ='/admin/newstype'</script>");
            } else {
                res.send("<script>alert('failure');history.go(-1) </script>");
            }
        }
    });

});

// Category management modification page
router.get("/edit", function (req, res, nxet) {
    let id = req.query.id;
    // Find data from the database
    mysql.query("select * from topic where id = ?", [id], function (err, data) {
        if (err) {
            return "";
        } else {
            // Render the obtained data to the page
            res.render("admin/newstype/edit.html", { data: data[0] });
        }
    });
});

// Classification management and data modification function
router.post("/edit", function (req, res, next) {
    // Get the data to be modified
    let { name, keywords, description, sort,id} = req.body;
    console.log(id);
    mysql.query("update topic set name = ?, keywords = ?, description = ?, sort = ? where id = ?",[name, keywords, description, sort,id],function(err,data){
        if(err){
            return err;
        }else{
            if(data.affectedRows == 1){
                res.send("<script>alert('success');location.href ='/admin/newstype'</script>");
            }else{
                res.send("<script>alert('failure');history.go(-1) </script>");
            }
        }
    }); 

})

// Delete data without refresh
router.get('/ajax_del', function (req, res, next) {
    // console.log(req.query);
    let id = req.query.id;
    // console.log(id);
    mysql.query(`delete from topic where id = ${id}`, function (err, data) {
        if (err) {
            return "";
        } else {
            if (data.affectedRows == 1) {
                res.send('1');
            } else {
                res.send('0');
            }
        }
    });
});

// No refresh modification sort operation
router.get("/ajax_sort",function(req,res,next){
    // Get the incoming data
    let {id,sort} = req.query;
    // Perform update sql statement operation
    mysql.query("update topic set sort = ? where id = ?",[sort,id],function(err,data){
        if(err){
            return "";
        }else{
            if(data.affectedRows == 1){
                res.send("1");
            }else{
                res.send("0");
            }
        }
    });
    
})
module.exports = router;
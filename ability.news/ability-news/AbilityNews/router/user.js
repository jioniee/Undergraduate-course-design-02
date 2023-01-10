//import express
let express = require("express");
//initialization
let router = express.Router();
//Load MD5 password encryption module
let crypto = require('crypto');
//Load the mysql database module
let mysql = require("../config/db.js");
//use methods from userfn.js
let userfn = require('./userfn.js');

router.use(function (req, res, next) {
	// Determine the URL address
	if (req.url != "/login" && req.url != "/check" && req.url != "/signup") {
		// Determine whether the user is logged in-Determine whether the request header contains the following two pieces of information, 
        // whether the background is logged in and whether the user name exists
		if (req.session.HsmMessageIsUser && req.session.HsmMessageUsername) {
			next();
		} else {
			res.send("<script>alert('Please log in');location.href = '/login';</script>");
		}
	} else {
		// If you are visiting the login page or check page
		next();
	}
});

router.get('/', function (req, res) {
    //TODO for discuss
	// for test
    res.render("home/MainPage.html", {user:req.session.HsmMessageUsername, type:req.session.HsmMessageUserType});
})

router.get('/signup', function (req, res) {
    res.render('user/Signup.html');
});

 //user register
 router.post("/signup", function (req, res, next) {
	userfn.postsignup(req, res);
 });

router.get('/login', function (req, res) {
    res.render('user/LogIn.html');
});
router.post('/login', function (req, res) {
    
    // Receive data
    let {
        username,
        password
    } = req.body;
    // Determine whether the user enters
    if (username) {
        if (password) {
            // Encryption password
            const md5 = crypto.createHash('md5');
            password = md5.update(password).digest('hex');
            // Determine whether the user exists in the database
            mysql.query("select * from registered_users where username = ? and password = ?", [username, password], function (err, data) {
                if (err) {
                    return "";
                } else {
                    // If the corresponding data is queried in the database
                    if (data[0]) {
                        // console.log(data[0]);
                        // Compare the data in the database with the input data again
                        
                        if (data[0].username === username && data[0].password === password) {
                            res.send("<script>location.href = '/user';</script>");
                        } 
                        
                    } else{
                        res.send("<script>alert('failure');location.href = '/user/login';</script>");
                    }
                }
            });
        }
    }
});
router.get('/reset', function (req, res) {
    res.render('user/ResetPassword.html');
});
router.post('/reset', function (req, res) {
	userfn.postreset(req, res);
});

router.get('/reporter',function(req,res){
	res.send("reporter page");
})

router.get('/editor',function(req,res){
	res.send("editor page");
})

router.post('/username', function(req, res){
    res.json(req.session.HsmMessageUsername);
})

router.post('/usertype', function(req, res){
    res.json(req.session.HsmMessageUserType);
})



module.exports = router;


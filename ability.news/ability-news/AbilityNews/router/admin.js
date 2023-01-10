//import express
let express = require("express");
//initialization
let router = express.Router();
//Load MD5 password encryption module
let crypto = require('crypto');
//Load the mysql database module
let mysql = require("../config/db.js");

// Monitor user's access address
router.use(function (req, res, next) {
	// Determine whether the url address can be accessed directly,
	// if the user does not access the login page or check page
	if (req.url != "/login" && req.url != "/check") {
		// Determine whether the user is logged in-Determine whether the request header contains the following two pieces of informat
		// whether the background is logged in and whether the user name exists
		if (req.session.HsmMessageIsAdmin && req.session.HsmMessageUsername) {
			next();
		} else {
			res.send("<script>alert('please sign in');location.href = '/login';</script>");
		}
	} else {
		// If you are visiting the login page or check page
		next();
	}
});


router.get("/logout", function (req, res, next) {
	req.session.HsmMessageIsAdmin = false;
	req.session.HsmMessageUsername = "";
	req.session.HsmMessageUserType = "";
	res.send("<script>alert('Log out');location.href = '/';</script>");

});
router.get('/', function (req, res, next) {
	res.render("admin/index", {user:req.session.HsmMessageUsername, userType:req.session.HsmMessageUserType})
});

router.get('/welcome', function (req, res, next) {
	res.render("admin/welcome")
});

//admin
let adminRouter = require('./admin/admin');
router.use('/admin', adminRouter);
//user
let userRouter = require('./admin/user');
router.use('/user', userRouter);
//newstype
let newstypeRouter = require('./admin/newstype');
router.use('/newstype', newstypeRouter);
//scrolling img
let bannerRouter = require('./admin/banner');
router.use('/banner', bannerRouter);
//news
let newsRouter = require('./admin/news');
router.use('/news', newsRouter);
//comment
let commentRouter = require('./admin/comment');
router.use('/comment', commentRouter);
//recommend
let recommendRouter = require('./admin/recommend');
router.use('/recommend', recommendRouter);

module.exports = router;

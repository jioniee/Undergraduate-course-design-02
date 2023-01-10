//import express
let express = require("express");
//initialization
let router = express.Router();
// load the database module
const mysql = require("../config/db.js");
// load the MD5 encryption module
const crypto = require('crypto');

// Import the moment module
const moment = require("moment");

//use methods from userfn.js
let userfn = require('./userfn.js')


//Login processing operation
router.post("/check", function (req, res, next) {
	// Receive data
	let {
		username,
		password
	} = req.body;
	// Determine whether the user enters
	if (username) {
		if (password) {
			// Encryption password
			let md5 = crypto.createHash('md5');
			password = md5.update(password).digest('hex');
			// Determine whether the user exists in the database
			mysql.query("select * from topadmin where username = ? and password = ?", [username, password], function (err, data) {
				if (err) {
					return "";
				} else {
					// If the corresponding data is queried in the database
					if (data[0]) {
						// Compare the data in the database with the input data again
						if (data[0].username == username && data[0].password == password) {
							req.session.HsmMessageIsAdmin = true;
							req.session.HsmMessageUsername = data[0].username;
							res.send("<script>location.href = '/admin';</script>");
						} else {
							res.send("<script>alert('failure');location.href = '/login';</script>");
						}
					} else {
						 //check if the information matches the information in the registered user database
						 mysql.query("select * from registereduser where username = ? and password = ?", [username, password], function (err1, data1) {
							if (err1) {
								return "";
							} else {
								// If the corresponding data is queried in the database
								if (data1[0]) {
									// Compare the data in the database with the input data again
									if (data1[0].username == username && data1[0].password == password) {
										req.session.HsmMessageIsUser = true;
										req.session.HsmMessageUserType = "user";
										req.session.HsmMessageUsername = data1[0].username;
										let user_id = data1[0].user_id;
										// check if the user is a reporter
										mysql.query("select * from reporter where user_id = ?", [user_id], function(err ,data){
											if (err){
												return "";
											}
											else{
												if (data[0]){
													if (data[0].user_id == user_id){
														req.session.HsmMessageUserType = "reporter";
														res.send("location.href = '/user/reporter';</script>");
													}
													else{
														res.send("<script>location.href = '/user';</script>");
													}
												}
												else{
													// check the if the user is an editor
														mysql.query("select * from editor where user_id = ?", [user_id], function (err, data) { 
															if (err){
																return "";
															}
															else{
																if (data[0]){
																	if (data[0].user_id ==user_id){

																		res.send("<script>location.href = '/user/editor';</script>");
																	}else{res.send("<script>location.href = '/user';</script>");}
																}
																else{
																	req.session.HsmMessageUserType = "editor";
																	res.send("<script>location.href = '/user';</script>");}
															}
														 })
													
												}
											
												
											}
										})
										
									} else {
										res.send("<script>alert('failure');location.href = '/';</script>");
									}
								} else {
									 res.send("<script>alert('failure');location.href = '/login';</script>");
								}
							}
						});
					}
				}
			});		
		} else {
			res.send("<script>alert('please log in');location.href = '/login';</script>");
		}
	} else {
		res.send("<script>alert('please log in');location.href = '/login';</script>");
	}
})



// assume news table have following attributes: id, cid(topic_id), title, img, time, author, text and summary
// assume topic table have attributes:id,name,sort,keywords,description
//assume topic cid =1 when the news belongs to label = disability
router.get('/', function (req, res, next) {
	let id = req.query.id ? req.query.id : 1;

	mysql.query("select * from topic order by sort desc",function(err,data){
		if (err) {
			return "";
		}else{
			mysql.query("select news.*, type.name tname from news,topic type where news.cid = type.id and news.cid = ? order by news.id desc limit 6", [id],function(err, data1){
				if(err){
					return '';
				}else{
					data1.forEach(item=>{
						item.time = moment(item.time*1000).format("YYYY-MM-DD HH:mm:ss");
					})
					mysql.query("select * from news where recommended = 1 order by news.id desc limit 4", function(err, data2){
						if(err){
							return '';
						}else{
							res.render("home/MainPage", {data: data1, typeData: data, recommenddata:data2, user: req.session.HsmMessageUsername});
						}
					});
				}
			});
		}
	});
});

router.get('/recommend', function (req, res, next) {
	let id = req.query.id ? req.query.id : 1;
	let dataobj = {
		ret:true,
		title_arr:[],
		img_arr:[]
	}

	dataobj.img_arr.push("public/home/img/welcome.jpg");
	dataobj.title_arr.push("");

	mysql.query("select * from news where recommended = 1 limit 5", [id],function(err, data1){
		if(err){
			return '';
		}else{

			data1.forEach(item=>{
				dataobj.title_arr.push(item.title);
				dataobj.img_arr.push(item.img);

			})
			res.send(dataobj);
		}
	});
});


//signIn
router.get('/login',function(req,res,next){
		res.render("home/LogIn.html")
})
//signUp
router.get('/signup',function(req,res,next){
    res.render("user/SignUp.html")
})

router.post('/signup',function(req,res,next){
    userfn.postsignup(req, res)
})

router.get('/reset',function(req,res,next){
    res.render("user/ResetPassword.html")
})

router.post('/reset',function(req,res,next){
    userfn.postreset(req, res)
})



module.exports = router;
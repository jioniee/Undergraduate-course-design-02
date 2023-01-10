/**
 * userfn.js
 * This file encapsulates the methods that are used to process POST requests for users
 */
//import express
let express = require("express");
//Load MD5 password encryption module
let crypto = require('crypto');
//Load the mysql database module
let mysql = require("../config/db.js");
const router = require("./user.js");


exports.postsignup = function (req, res) {
    let {username, password, email, cdkey, repassword } = req.body;
 	console.log(req.body);
 	if (username) {
 		if (username.length >= 6 && username.length <= 12) {
 			if (password) {
 				if (password.length >= 8 && password.length <= 14) {
 					if (repassword && repassword === password) {
 						// Whether user has registered
 						mysql.query("select * from registered_users where username = ?",[username], function (err, data) {
 							if (err) {
 								console.log(err);
 								return "";
 							} else {
 								if (data.length > 0) {
 									res.send({ ok: 0, msg: 'Username cannot be used. Please choose another username.' });
 								} else {
 									// MD5 encryption of the password
 									const md5 = crypto.createHash('md5');
 									password = md5.update(password).digest('hex');
 									// Perform database increase operation
 									mysql.query("insert into registered_users(username,user_email,password) value(?,?,?)", [username, email, password], function (err1, data2) {
 										if (err1) {
 											return "";
// 										}else{
// 											console.log(data2);
// 											res.end("successfully signed up");
 										//}
 										 } else {
 										 	console.log(data2);
 										 	if (data2.affectedRows == 1) {
 										 		if(cdkey == 2 || cdkey == 3){
 										 			mysql.query("select user_id from registered_users where username = ? ", [username], function (err, data3) {
 										 				if(err){
 										 					throw err;
 										 				}else{
 										 					var id = data3[0].user_id;
 										 					if(cdkey == 2){
 										 						mysql.query("insert into reporter(user_id) value(?)", [id], function(err, data4){
 										 							if(err){
 										 								throw err;
 										 							}else{
 										 								//res.send({ ok: 1, msg: 'Successfully registered!' });
 										 								res.send("<script>alert('Successful');location.href='/user/LogIn.html'</script>");
	
 										 							}
 										 						});

 										 					}

 										 					if(cdkey == 3){
 										 						mysql.query("insert into editor(user_id) value(?)", [id], function(err, data4){
 										 							if(err){
 										 								throw err;
 										 							}else{
 										 								//res.send({ ok: 1, msg: 'Successfully registered!' });
 										 								res.send("<script>alert('Successful');location.href='/user/LogIn.html'</script>");
	
 										 							}
 										 						});

 										 					}
															
 										 				}
 										 			});
												
 										 		}else{
 										 			//res.send({ ok: 1, msg: 'Successfully registered!' });
 										 			//res.redirect('/user/login');
 										 			res.send("<script>alert('Successful');location.href='/user/LogIn.html'</script>");
 										 		}
 										 	} else {
 										 		res.send({ ok: 0, msg: 'Failed registered!' });
 										 	}
 										 }
 									});
									
 								}
 							}
 						});
 					} else {
 						res.send({ ok: 0, msg: 'The two passwords entered are inconsistent!' });
 					}
 				} else {
 					res.send({ ok: 0, msg: 'The password length is between 8-14!' });
 				}
 			} else {
 				res.send({ ok: 0, msg: 'Please enter the password!' });
 			}
 		} else {
 			res.send({ ok: 0, msg: 'Username length is between 6-12!' });
 		}
 	} else {
 		res.send({ ok: 0, msg: 'please enter user name!' });
 	}
};
exports.postreset = function (req, res) {
       
    // Receive the data submitted by the form
	let { username, newpassword, newpasswordConfirm } = req.body;
	// Determine whether the user changes the password
	let sql = "";
	if (newpassword) {
        if(newpassword === newpasswordConfirm){
		    const md5 = crypto.createHash('md5');
            newpassword = md5.update(newpassword).digest('hex');
		    // sql statement, "password" is added to become a string, because the default is a hash
		    sql = `update registered_users set password = '${newpassword}' where username = '${username}'`;
            
        }else{
            res.send("<script>alert('the password confirmed does not match with new password');history.go(-1)</script>");
        }
		
	} else{
        res.send("<script>alert('please input your new password');history.go(-1)</script>");
    }
	mysql.query(sql, function (err, data) {
		if (err) {
			return "";
		} else {
			if (data.affectedRows === 1) {
				res.send("<script>alert('Successful');location.href='/user/LogIn.html'</script>");

			} else {
				res.send("<script>alert('Fail');history.go(-1)</script>");

			}
		}
	})
};



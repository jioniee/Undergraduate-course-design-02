//import express
let express = require("express");
//initialization
let router = express.Router();

// Import database related configuration
let mysql = require("../../config/db.js");

//Import time formatting module
let moment = require('moment');

//Load MD5 password encryption module
let crypto = require('crypto');

//main page
//Render pages and implement search functions
router.get('/', function (req, res, next){
	// search
	let search = req.query.search ? req.query.search : "";
	//Query database data
	mysql.query("select * from admin where username like ? order by id desc", [`%${search}%`],function (err, data) {
		// Determine whether the execution is successful
		if (err) {
			return "";
		} else {
			//Convert the timestamp
			data.forEach(item => {
				item.time = moment(item.time * 1000).format("YYYY-MM-DD HH:mm:ss");
			})
			//Render the page and transfer the data
			res.render("admin/admin/index", {data:data,search:search});
		}
	});	
});
// No refresh modification status
router.get('/ajax_status', function (req, res, next) {
	// console.log(req.query);
	// Receive the corresponding data
	let { id, status } = req.query;//{ id: '8', status: '1' }
	// change the data
	mysql.query("update admin set status= ? where id= ?", [status, id], function (err, data) {
		//Determine whether the modification is successful (error report)
		if (err) {
			return "";
		} else {
			// If it has been modified successfully
			if (data.affectedRows == 1) {
				res.send("1");
			} else {
				res.send("0");
			}
		}
	});
});
// Delete administrator data without refresh
router.get('/ajax_del', function (req, res, next) {
	let id = req.query.id;
	mysql.query(`delete from admin where id = ${id}`, function (err, data) {
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


//add
router.get('/add',function(req,res,next){
    res.render("admin/admin/add")
})

router.post("/add", function(req, res, next){
    // Receive data from post
	let { username, password, repassword, status} = req.body
	// Determine whether the user name exists
	if (username) {
		// Determine the length of the username
		if (username.length >= 6 && username.length <= 12) {
			// Determine whether the password exists
			if (password) {
				// Determine whether the two entered passwords are the same
				if (password == repassword) {
					//Determine whether the username already exists
					mysql.query("select * from admin where username = ?", [username], function (err, data) {
						// Determine if there is an error,
						if (err) {
							return "";
						} else {
							// Determine whether the username is registered
							if (data.length == 0) {
								// No registration, insert data
								//Create current timestamp
								let time = Math.round((new Date().getTime() / 1000));
								// Password encryption, 
								// need to load the encryption module provided by node
								// Create encryption rules
								let md5 = crypto.createHash('md5');
								password = md5.update(password).digest('hex');
								mysql.query("insert into admin(username,password,status,time) value(?,?,?,?)", [username, password, status, time], function (err, data) {
									if (err) {
										console.log(err);
										return "";
									} else {
										if (data.affectedRows === 1) {
											res.send("<script>alert('Add successfully');location.href ='/admin/admin'</script>");
										} else {
											res.send("<script>alert('Fail to add');history.go(-1)</script>");
										}
									}
								})
							} else {
								res.send("<script>alert('Already signed，ReEnter ');history.go(-1)</script>");

							}
						}
					});
				} else {
					res.send("<script>alert('The two passwords entered are inconsistent');history.go(-1)</script>");
				}
			} else {
				res.send("<script>alert('Please enter the password');history.go(-1)</script>");
			}
		} else {
			res.send("<script>alert('User name length is between 6-12 digits');history.go(-1)</script>");
		}

	} else {
		res.send("<script>alert('please enter user name');history.go(-1)</script>");
	}
})


//edit
//The administrator manages to modify the page
router.get('/edit',function(req,res,next){
    let id = req.query.id;
	// Query corresponding data
	mysql.query("select * from admin where id = " + id, function (err, data) {
		if (err) {
			return "";
		} else {
			// Load the modified page
			res.render("admin/admin/edit.html", { data: data[0] });
		}
	});
})
//Administrator modify data function
router.post("/edit", function (req, res, next) {
	// Receive the data submitted by the form
	let { username, password, repassword, id, status } = req.body;
	// Determine whether the user changes the password
	let sql = "";
	if (password) {
		var md5 = crypto.createHash('md5');
		password = md5.update(password).digest('hex');
		// sql statement, "password" is added to become a string, because the default is a hash
		sql = `update admin set status = ${status} ,password = '${password}' where id = ${id}`;
	} else {
		// sql statement
		sql = `update admin set status = ${status} where id = ${id}`;
	}
	mysql.query(sql, function (err, data) {
		if (err) {
			return "";
		} else {
			if (data.affectedRows == 1) {
				res.send("<script>alert('Successful');location.href='/admin/admin'</script>");

			} else {
				res.send("<script>alert('Fail');history.go(-1)</script>");

			}
		}
	})
});


//delete
router.get('/delete',function(req,res,next){
    res.send("delete");
})

module.exports = router;
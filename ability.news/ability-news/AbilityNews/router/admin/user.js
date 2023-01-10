//import express
let express = require("express");
//initialization
let router = express.Router();
// Import database related configuration
let mysql = require("../../config/db.js");
//Import time formatting module
let moment = require('moment');
//Import pagination method
const page = require("../../common/page.js");
router.get('/', function (req, res, next) {
	//Get the data on the page, URL, if there is p on the URL with data, get the value of p, otherwise take 1
	let p = req.query.p ? req.query.p : 1;
	// The default number of data displayed per page
	let size = 5;
	// search
	let search = req.query.search ? req.query.search : "";
	//Query database data
	mysql.query("select count(*) tot from registereduser where username like ? ", ['%' + search + '%'], function (err, data) {
		if (err) {
			return "";
		} else {
			let tot = data[0].tot;
			let fpage = page(tot, p, size);
			mysql.query("select * from registereduser where username like ? order by id desc limit ?,?", ['%' + search + '%', fpage.start, fpage.size], function (err, data) {
				if (err) {
					return "";
				} else {
					// Load page
					data.forEach(item => {
						item.time = moment(item.time * 1000).format("YYYY-MM-DD HH:mm:ss");
					})
					res.render("admin/user/index.html",
						{
							data: data,
							search: search,
							show: fpage.show
						}
					);
				}
			});
		}
	});	
});

// No refresh modification status
router.get('/ajax_status', function (req, res, next) {
	// console.log(req.query);
	// Receive the corresponding data
	let { id, status } = req.query;//{ id: '8', status: '1' }
	// change the data
	mysql.query("update registereduser set status= ? where id= ?", [status, id], function (err, data) {
		// Determine whether the modification is successful (error report)
		if (err) {
			return "";
		} else {
			// console.log("data.affectedRows: " +data.affectedRows);
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
	mysql.query(`delete from registereduser where id = ${id}`, function (err, data) {
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

module.exports = router;
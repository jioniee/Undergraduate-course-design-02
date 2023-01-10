//import express
let express = require("express");
//initialization
let router = express.Router();

router.get('/', function (req, res, next) {
	res.send("comment management");
});

module.exports = router;
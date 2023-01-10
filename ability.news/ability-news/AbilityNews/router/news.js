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

const url = require("url");

//use methods from userfn.js
let userfn = require('./userfn.js')


//newsPage
router.get('/', function (req, res, next) {
	const id = req.query.id;
    mysql.query("select * from news where id = ?" , [id],function(err, data){
		if(err){
			console.log(err)
		}else{
			data.forEach(item=>{
				item.time = moment(item.time*1000).format("YYYY-MM-DD HH:mm:ss");
			})
            mysql.query("select comment.*, n.id from comment, news n where comment.news_id = n.id and n.id = ? order by comment.time desc" , [id],function(err, data1){
                if(err){
                    console.log(err)
                }else{
                    data1.forEach(item=>{
                        item.time = moment(item.time*1000).format("YYYY-MM-DD HH:mm:ss");
                    })
                    mysql.query("select * from news where recommended = 1 order by news.id desc limit 4", function(err, data2){
						if(err){
							return '';
						}else{
                            res.render("home/NewsPage", {data: data[0],commentdata:data1, recommenddata:data2, user: req.session.HsmMessageUsername});
                        }
                    });
                }
            })
		}
	})
})

// post like number


router.post('/addLike', function(req, res){
    // get news id
    // console.log("enter into ###########")
	const id = req.body.news_id;
	// console.log("get the news id: " + id);
	res.json({ ok: true});
	// update like value
	mysql.query("update news set likeNumber = likenumber + 1 where id = ?", [id], function(err, data){
		if(err){
			throw err;
		}else{
			// console.log("successfully add")
		}
	})
})

router.post('/comment', function(req, res, next){
    const time = (Math.round(new Date().getTime())/1000);
    const {news_id, comment} = req.body;
	if(news_id){
        if (comment){
            mysql.query("insert into comment(news_id,text,author,time) value(?,?,?,?)", [news_id, comment, "NoName",time], function (err, data){
                if(err){
                    console.log(err);
                    throw err;
                }else{
                    if(data.affectedRows == 1){
                        let loc = "<script>location.href ='/news?id=" + news_id + "'</script>"
                        res.send(loc);
                    }else{
                        res.send({ok:false,msg:'failed post'})
                    }
                }
            });
        }
	}

});

module.exports = router;

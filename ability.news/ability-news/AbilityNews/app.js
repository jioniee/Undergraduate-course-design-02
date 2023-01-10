//import express
let express = require("express");
//initialize express
let app  = express();
//处理post请求
const bodyParser = require("body-parser");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:false}));
//加载ueditor 模块
var ueditor = require("ueditor");
//导入path模块
const path = require("path");
//导入session模块
const session = require('express-session');
// 使用 session 中间件
app.use(session({
    //session密钥
    secret: 'keyboard cat',
    resave: false, 
    saveUninitialized: false,  
    cookie : {
       //session有效时间，单位毫秒
        maxAge : 1000 * 60 * 300, 
    },
}));

//set up the framework
let ejs = require("ejs");
//设置静态引擎
app.set("views",'./views');
app.engine("html",ejs.__express);
app.set("view engine","html");
//加载静态资源
app.use("/public", express.static(__dirname+"/public"));
app.use("/upload",express.static(__dirname+"/upload"));
app.use("/images",express.static(__dirname+"/images"));
//导入路由文件
let homeRouter = require("./router/home");
let adminRouter = require("./router/admin");
let userRouter = require("./router/user");
let newsRouter = require("./router/news");
const { use } = require("./router/user");
//使用路由
app.use('/',homeRouter);
app.use('/admin',adminRouter);
app.use('/user', userRouter);
app.use('/news', newsRouter);
//使用ueditor模块
app.use("/public/baidu/ueditors", ueditor(path.join(__dirname, ''), function (req, res, next) {
    // ueditor 客户发起上传图片请求
    if (req.query.action === 'uploadimage') {
        var foo = req.ueditor;
        var imgname = req.ueditor.filename;
        var img_url = '/images/ueditor/';
        res.ue_up(img_url); //你只要输入要保存的地址 。保存操作交给ueditor来做
        res.setHeader('Content-Type', 'text/html');//IE8下载需要设置返回头尾text/html 不然json返回文件会被直接下载打开
    }
    //  客户端发起图片列表请求
    else if (req.query.action === 'listimage') {
        var dir_url = '/images/ueditor/';
        res.ue_list(dir_url); // 客户端会列出 dir_url 目录下的所有图片
    }
    // 客户端发起其它请求
    else {
        res.setHeader('Content-Type', 'application/json');
        res.redirect('/public/baidu/php/config.json');
    }
}));
app.listen(3000, function(){
    console.log("start, port:3000")
});
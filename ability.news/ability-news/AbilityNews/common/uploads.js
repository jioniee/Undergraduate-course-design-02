// Load file system module
const fs = require("fs");

// Introduce the path module to get the file name suffix
const path = require("path");

// File upload function, according to the provided image information and the name
// of the directory to be stored, return the path where the image is stored
function uploads(imgRes,dir =''){
    // Get the temporary directory of the file
    let tmpPath = imgRes.path;  //'tmp\\87fe4af813bd4a2d04cfaecdd7e23f7e'

    // Generate random picture name: current timestamp plus suffix
    let newName = ""+(new Date().getTime())+Math.round(Math.random()*10000);
    // Get the suffix of the uploaded file name
    let ext = path.extname(imgRes.originalname);  //eg .png
    // Set the specified directory for file upload
    let newPath = "/upload/"+dir+"/"+newName+ext;

    // Make a file copy
    let fileData = fs.readFileSync(tmpPath);//Synchronously read the contents of the file
    fs.writeFileSync(__dirname+"/../"+newPath,fileData);//Synchronously write the content of the read file to the new file
    // console.log(__dirname+"/../../"+newPath);//E:\software\apps data\VS code\project\nodejs-express-mysql\routers\admin/../..//upload/slider/15658611447833694.png
    return newPath;
}

module.exports = uploads;
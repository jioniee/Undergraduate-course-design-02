// Import database module
const mysql = require("mysql");
// Set database connection properties
let connect = mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"123456",
    database:"abilitynews",
    port: "3306"
})
// Start to connect to the database

connect.connect((err)=>{
    if(err) throw err;
    console.log('successfully connected to database');
});
// Throw module
module.exports = connect;
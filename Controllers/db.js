const mysql = require('mysql')

// define mysql connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'scientific article management platform'
})

connection.connect(function(err){
    if(err){
        throw err
    }else{
        console.log('Database connected!')
    }
})

module.exports = connection


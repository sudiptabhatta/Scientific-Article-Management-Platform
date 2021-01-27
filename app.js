// need to include the packages in our Node.js application, therefore create the following variables and require the modules
const express = require('express')
const path = require('path')
const ejs = require('ejs')
const bodyParser = require('body-parser')
const multer = require('multer')
const session = require('express-session')
const flash = require('connect-flash')
const controller = require('./Controllers/routes')

// Express is what we'll use for our web applications, this includes packages such as sessions and handling HTTP requests etc
const app = express()

// set views file
app.set('views', path.join(__dirname, 'views'))

//set template engine
app.set('view engine', 'ejs')

// middleware
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

// use connect-flash to store flash messages in the session
app.use(flash())

// The public directory off of our root folder contains the static files we want to serve
app.use(express.static('public'))

//define the storage location for our images
const storage = multer.diskStorage({
    destination: function (req, file, next) {
        next(null, 'public/uploads')
    },
    // By default, multer removes file extensions so let's add them back
    filename: function (req, file, next) {
        next(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
})

controller(app, multer, storage)

// server listening
const port = 3000
app.listen(port, function(){
    console.log(`Listening on port ${port}`)
})
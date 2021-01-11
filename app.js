const express = require('express')
const path = require('path')
const ejs = require('ejs')
const bodyParser = require('body-parser')
const multer = require('multer')
const session = require('express-session')
const flash = require('connect-flash')
const controller = require('./Controllers/routes')

// express app
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

controller(app)

// server listening
const port = 3000
app.listen(port, function(){
    console.log(`Listening on port ${port}`)
})
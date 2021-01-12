const connection = require('./db')
const helpers = require('./helpers')

module.exports = function(app, multer, storage){

    app.get('/', function(req, res){
        res.render('signup')
    })

    app.post('/save', function(req, res){
        let data = {name: req.body.name, email: req.body.name, password: req.body.password, specialization: req.body.specialization}
        let sql = "INSERT INTO researchers SET ?"
        let query = connection.query(sql, data, function(err, results){
            if(err) throw err
            res.redirect('/')
        })
    })
   
    app.get('/login', function(req, res) {
        if (req.session.loggedin == true){
            res.redirect('/home')
        }
        else{
            res.render('login', {message: req.flash('msg')})
        }
        
    })
    
    app.post('/auth', function(req, res) {
        var email = req.body.email
        var password = req.body.password
        if (email && password) {
            connection.query('SELECT * FROM researchers WHERE Email = ? AND Password = ?', [email, password], function(error, results, fields) {
                if (results.length > 0) {
                    req.session.loggedin = true
                    req.session.email = email
                    req.session.uid = results[0].ID
                    req.session.name = results[0].Name
                    req.session.specialization = results[0].Specialization
                    res.redirect('/home')
                } else {
                    req.flash('msg', 'Incorrect email or password!')
                    res.redirect('/login')
                }			
                res.end()
            })
        } else {
            req.flash('msg', 'Please enter email and passowrd!')
            res.redirect('/login')
        }
    })

    app.get('/home', function(req, res) {
        if (req.session.loggedin) {
            res.send('Welcome back, ' + req.session.email + '!')
        } else {
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
        res.end()
    })

    app.get('/logout', function(req, res) {
        req.session.loggedin = null
        req.session.email = null
        req.session.id = null
        req.session.name = null
        req.session.specialization = null
        req.flash('msg', 'Logged out successfully!')
        res.redirect('/login')
    })

    app.get('/article_insert', function(req, res){
        if (req.session.loggedin == true){
            let sql = "SELECT * FROM categories"
            connection.query(sql, function(err, results){
                res.render('article_insert', {categories: results, message: req.flash('msg')})
            })
        }
        else{
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.post('/article_submit', function(req, res){
        // // 'profile_pic' is the name of our file input field in the HTML form
        let upload = multer({ storage: storage, fileFilter: helpers.imageFilter}).single('profile_pic')
    
        upload(req, res, function(err) {
            // req.file contains information of uploaded file
            // req.body contains information of text fields, if there were any
            if (req.fileValidationError) {
                return res.send(req.fileValidationError)
            }
            else if (!req.file) {
                return res.send('Please select an image to upload')
            }
            else if (err instanceof multer.MulterError) {
                return res.send(err)
            }
            else if (err) {
                return res.send(err)
            }

            image_path = 'http://localhost:3000/'+req.file.path.substr(7, req.file.path.length - 1)
            
            let data = { Title: req.body.title, Image_path: image_path, Body: req.body.body, Created: new Date(), cid: req.body.category, uid: req.session.uid}
            //let sql = "INSERT INTO articles (Title, Body, Created) values ('" + req.body.title + "', '" + req.body.body + "', CURDATE())"
            let sql = "INSERT INTO articles SET ?"
            let query =  connection.query(sql, data, function (err) {
                if (err){
                    throw err
                } else{
                    req.flash('msg', 'data saved successfully!')
                    res.redirect('/article_insert')
                }
            })

        })
    })

    app.get('/categories_insert', function(req, res){
        let sql = "SELECT * FROM categories"
        connection.query(sql, function(err, results){
            if(err) throw err
            res.render('categories_insert', {categories: results})
        })
    })

    app.post('/categories_submit', function(req, res){
        let sql = "INSERT INTO categories(Category_Name) VALUES('"+req.body.Category_Name+"')"
        connection.query(sql, function(err){
            if(err) throw err
            res.redirect('/categories_insert')
        }) 
    })

}
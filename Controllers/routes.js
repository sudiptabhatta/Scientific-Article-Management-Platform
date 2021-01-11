const connection = require('./db')

module.exports = function(app){

    app.get('/', function(req, res){
        res.render('signup')
    })

    app.post('/save', function(req, res){
        let data = {name: req.body.name, email: req.body.name, password: req.body.password, specialization: req.body.specialization}
        let sql = `INSERT INTO researchers SET ?`
        let query = connection.query(sql, data, function(err, results){
            if(err) throw err
            res.redirect('/')
        })
    })
   
    app.get('/login', function(req, res) {
        res.render('login', {message: req.flash('msg')})
    })
    
    app.post('/auth', function(req, res) {
        var email = req.body.email
        var password = req.body.password
        if (email && password) {
            connection.query('SELECT * FROM researchers WHERE Email = ? AND Password = ?', [email, password], function(error, results, fields) {
                if (results.length > 0) {
                    req.session.loggedin = true
                    req.session.email = email
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
        req.flash('msg', 'Logged out successfully!')
        res.redirect('/login')
    })

}
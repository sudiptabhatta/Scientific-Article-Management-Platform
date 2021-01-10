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
   
  
}
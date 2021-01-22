const connection = require('./db')
const helpers = require('./helpers')

module.exports = function(app, multer, storage){

    app.get('/home', function(req, res){
        res.render('home')
    })

    app.get('/signup', function(req, res){
        let sql = "SELECT * FROM categories"
        connection.query(sql, function(err, results){
            res.render('signup', {categories: results})
        })
    })

    app.post('/save', function(req, res){
        let data = {name: req.body.name, email: req.body.name, password: req.body.password, specialization: req.body.specialization}
        let sql = "INSERT INTO researchers SET ?"
        let query = connection.query(sql, data, function(err, results){
            if(err) throw err
            req.flash('msg', 'Signup successful!')
            res.redirect('/login')
        })
    })
   
    app.get('/login', function(req, res) {
        if (req.session.loggedin == true){
            if(req.session.privilege == 0){
                res.redirect('/researcher_timeline')
            } else {
                res.redirect('/moderator_timeline')
            }
        } else{
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
                    req.session.privilege = results[0].privilege
                    req.session.specialization = results[0].Specialization
                    if (req.session.privilege == 0){
                        res.redirect('/researcher_timeline')
                    }
                    else{
                        res.redirect('/moderator_timeline')
                    }
                    
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
    
    app.get('/logout', function(req, res) {
        req.session.loggedin = null
        req.session.email = null
        req.session.uid = null
        req.session.name = null
        req.session.privilege = null
        req.session.specialization = null
        req.flash('msg', 'Logged out successfully!')
        res.redirect('/login')
    })

    app.get('/researcher_timeline', function(req, res){
        if(req.session.loggedin == true){
            if(req.session.privilege == 0){
                let sql = "SELECT * FROM categories"
                let sql1 = `SELECT * FROM articles WHERE Uid = ${req.session.uid}`
                connection.query(sql, function(err, results){
                    connection.query(sql1, function(err, rows){
                        if(err) throw err
                        res.render('researcher_timeline', {categories: results, articles: rows})
                    })
                })
            }
        } else {
            req.flash('msg', 'Please login to view this page')
            res.redirect('/login')
        }
    })

    app.get('/article/:Id', function(req, res){
        if(req.session.loggedin){
            const Id = req.params.Id 
            let sql = `SELECT articles.ID, articles.Uid, articles.Title, articles.Body, articles.Image_Path, articles.Created, categories.Category_Name FROM articles JOIN categories ON categories.ID = articles.Cid WHERE articles.ID = ${Id}`
            let sql1 = "SELECT * FROM categories"
            let sql2 = "SELECT comments.Comment, comments.Created, researchers.Name FROM comments JOIN researchers ON comments.Uid = researchers.ID WHERE comments.Aid="+Id
            connection.query(sql1, function(err, results){
                connection.query(sql, function(err, row){
                    connection.query(sql2, function(err, row2){
                        if(err) throw err
                         let poster_id = row[0].Uid
                         let logged_in_id = req.session.uid
                         let owner_flag = (poster_id == logged_in_id) //owner: owner_flag
                         res.render('article', {categories: results, article: row[0], comments: row2, owner: owner_flag})
                    })  
                })
            })
        }
    })

    app.get('/article_insert', function(req, res){
        if(req.session.loggedin == true){
            if (req.session.privilege == 0){
                let sql = "SELECT * FROM categories"
                connection.query(sql, function(err, results){
                    if(err) throw err
                    res.render('article_insert', {categories: results, message: req.flash('msg')})
                })
            }
        }  else{
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
            
            let data = { Title: req.body.title, Image_path: image_path, Body: req.body.body, Created: new Date(), Cid: req.body.category, Uid: req.session.uid}
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

    app.get('/article_edit/:Id', function(req, res){
        if(req.session.loggedin){
            if(req.session.privilege == 0){
                const Id = req.params.Id
                let sql = `SELECT * FROM articles WHERE ID = ${Id}`
                let sql1 = "SELECT * FROM categories"
                connection.query(sql1, function(err, cate){
                    connection.query(sql, function(err, results){
                        if(err) throw err
                        res.render('article_edit', {categories: cate, article: results[0]})

                    })
                })
            }
        } else{
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.post('/update', function(req, res){
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
            const Id = req.body.ID
            // let sql = "UPDATE articles SET Title = '"+req.body.title+"', Body = '"+req.body.body+"', Image_Path = '"+image_path+"' WHERE ID ="+Id  / \ problem for image path \ -> it is ignored (escape)
            let sql = 'UPDATE articles SET ? where ID = '+Id
            let data = {Title: req.body.title, Image_path: image_path, Body: req.body.body, Cid: req.body.category}
            connection.query(sql, data, function(err, results){
                if(err) throw err
                res.redirect('/researcher_timeline')
            })
        })
    })

    app.get('/article_delete/:Id', function(req, res){
        if(req.session.loggedin){
            const Id = req.params.Id
            let sql = `DELETE FROM articles WHERE ID = ${Id}`
            connection.query(sql, function(err, results){
                if(err) throw err
                if(req.session.privilege == 0){
                    res.redirect('/researcher_timeline')
               
                } else {
                    res.redirect('/moderator_timeline')
               
                }
            })
        }
    })

    app.get('/categories_insert', function(req, res){
        if(req.session.privilege == 1){
            let sql = "SELECT * FROM categories"
            connection.query(sql, function(err, results){
                if(err) throw err
                res.render('categories_insert', {categories: results})
            })
        }
        else{
            res.redirect('/researchers_timeline')
        }
       
    })

    app.post('/categories_submit', function(req, res){
        let sql = "INSERT INTO categories(Category_Name) VALUES('"+req.body.Category_Name+"')"
        connection.query(sql, function(err){
            if(err) throw err
            res.redirect('/categories_insert')
        }) 
    })

    app.get('/category/:Id', function(req, res){
        if(req.session.loggedin){
            const Id = req.params.Id
            let sql = "SELECT * FROM categories"
            let sql1 = `SELECT * FROM articles WHERE Cid = ${Id}`
            connection.query(sql, function(err, results){
                connection.query(sql1, function(err, rows){
                    if(err) throw err
                    res.render('researcher_timeline', {categories: results, articles: rows})
                })
            })
        }  else{
            req.flash('msg','Please login to continue!')
            res.redirect('/login')
        }
    })

    app.get('/moderator_timeline', function(req, res){
        if(req.session.loggedin == true){
            if(req.session.privilege == 1){
                const Id = req.body.ID
                let sql = "SELECT * FROM categories"
                let sql1 = `SELECT * FROM articles WHERE approved = 0`
                connection.query(sql, function(err, results){
                    connection.query(sql1, function(err, rows){
                        if(err) throw err
                        res.render('moderator_timeline', {categories: results, articles: rows})
                    })
                })
            }
        } else {
            req.flash('msg', 'Please login to view this page')
            res.redirect('/login')
        }
    })

    app.get('/article_approve/:Id', function(req, res){
        if(req.session.loggedin){
            const Id = req.params.Id
            let sql = `UPDATE articles SET approved = 1 WHERE ID = ${Id}`
            connection.query(sql, function(err, results){
                if(err) throw err
                    res.redirect('/moderator_timeline')
            })
        }
     
    })

    app.post('/comment_submit', function(req, res){
        if(req.session.loggedin){
            if(req.session.privilege == 0){
                const Id = req.body.ID
                let data = {comment: req.body.comment, uid: req.session.uid, aid: Id, Created: new Date()}
                let sql = "INSERT INTO comments SET ? "
                connection.query(sql, data, function(err, results){
                    if(err) throw err
                    res.redirect('back')
                })
            }
        } else {
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.get('/profile/:Email', function(req, res){
        if(req.session.loggedin){
            const Email = req.params.Email
            let sql = "SELECT * FROM categories"
            let sql1 = `SELECT articles.ID, articles.Title, articles.Body, articles.Image_Path, articles.Created FROM articles JOIN researchers ON articles.Uid = researchers.ID WHERE researchers.Email = '${Email}'`
            let sql2 = `SELECT ID, Name, Email FROM  researchers WHERE Email = '${Email}'`
            connection.query(sql, function(err, results){
                connection.query(sql1, function(err, rows){
                    connection.query(sql2, function(err, rids){
                        let sql3 = `SELECT * FROM followers WHERE Uid1 = ${req.session.uid} AND Uid2 = ${rids[0].ID}`
                        connection.query(sql3, function(err, follow){
                            if(err) throw err
                            let follow_flag = false
                            if(follow.length == 1){
                                follow_flag = true
                            }
                            res.render('public_profile', {categories: results, articles: rows, profile: rids[0], follow: follow_flag})
                        })
                        
                    })
                })
            })
        } else {
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.get('/profile/follow/:Uid2', function(req, res){
        if(req.session.loggedin){
            if(req.session.privilege == 0){
                const Uid2 = req.params.Uid2
                let data = {Uid1: req.session.uid, Uid2: Uid2}
                let sql = "SELECT * FROM categories"  
                let sql1 = "INSERT INTO followers SET ? "
                connection.query(sql, function(err, results){
                    connection.query(sql1, data, function(err, results1){
                        if(err) throw err
                        res.redirect('back')
                    })
                })
            }
        } else {
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.get('/profile/unfollow/:Uid2', function(req, res){
        if(req.session.loggedin){
            if(req.session.privilege == 0){
                const Uid2 = req.params.Uid2
                let sql = "SELECT * FROM categories"
                let sql1 = `DELETE FROM followers WHERE Uid1 = ${req.session.uid} and Uid2 = ${parseInt(Uid2)}`
                connection.query(sql, function(err, results){
                    connection.query(sql1, function(err, results1){
                        if(err) throw err
                        res.redirect('back')
                    })
                })
            }
        } else {
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.get('/follows/:Email', function(req, res){
        if(req.session.loggedin){
            let Email = req.params.Email
            let sql = "SELECT * FROM categories"
            let sql1 = `SELECT Name FROM researchers WHERE ID IN(SELECT Uid2 FROM followers WHERE Uid1 = (SELECT ID FROM researchers WHERE Email = '${Email}'))`
            let sql2 = `SELECT Name FROM researchers WHERE ID IN(SELECT Uid1 FROM followers WHERE Uid2 = (SELECT ID FROM researchers WHERE Email = '${Email}'))`
            connection.query(sql, function(err, results){
                connection.query(sql1, function(err, rows){
                    connection.query(sql2, function(err, tuples){
                     if(err) throw err
                     res.render('myFollows', {categories: results, following: rows, followers: tuples})
                    })
                })
            })
        } else {
            req.flash('msg', 'Please login to view this page!')
            
            res.redirect('/login')
        }
    })

    app.get('/search', function(req, res){
        if(req.session.loggedin){
            let sql = "SELECT * FROM categories"
            let sql1 = `SELECT articles.ID, articles.Title, articles.Body, articles.Image_Path, articles.Created, researchers.Name FROM articles JOIN researchers ON articles.Uid = researchers.ID WHERE articles.Cid = ${req.session.specialization}`
            let sql2 = 'SELECT categories.Category_Name, COUNT(*) as Category_Count FROM articles JOIN categories ON articles.Cid = categories.ID GROUP BY cid'
            connection.query(sql, function(err, results){
                connection.query(sql1, function(err, rows){
                    connection.query(sql2, function(err, stats){
                        if(err) throw err
                        let search_title = 'Suggestions'
                        res.render('search', {categories: results, articles: rows, search_title: search_title, statistics: stats})
                    })
                    
                })
            })
        } else {
            req.flash('msg', 'Please login to view this page!')
            res.redirect('/login')
        }
    })

    app.post('/search', function(req, res){
        let search = req.body.search
        let sql = "SELECT * FROM categories"
        let sql1 = `SELECT articles.ID, articles.Title, articles.Body, articles.Image_Path, articles.Created, researchers.Name FROM articles JOIN researchers ON articles.Uid = researchers.ID WHERE articles.Title LIKE '%${search}%'`
        let sql2 = 'SELECT categories.Category_Name, COUNT(*) as Category_Count FROM articles JOIN categories ON articles.Cid = categories.ID GROUP BY cid'
        connection.query(sql, function(err, results){
            connection.query(sql1, function(err, rows){
                connection.query(sql2, function(err, stats){
                    if(err) throw err
                    let search_title = 'Search Results'
                    res.render('search',{categories: results, articles: rows, search_title: search_title, statistics: stats})
                })
            })
        })
    })

}
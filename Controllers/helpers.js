const imageFilter = function(req, file, next) {
    // Accept images only
    if (!file.originalname.match(/\.(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)$/)) {
        req.fileValidationError = 'Only image files are allowed!'
        return next(new Error('Only image files are allowed!'), false)
    }
    next(null, true)
}
module.exports.imageFilter = imageFilter
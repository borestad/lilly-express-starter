###*
@module      :: Policy
@description :: Simple policy to allow any passport authenticated user
###
module.exports = (req, res, next) ->

  # User is allowed, proceed to the next policy or controller
  return next() if req.session?.passport?.user

  # User is not allowed
  # (default res.forbidden() behavior can be overridden in `config/403.js`)
  #req.flash 'You are not permitted to perform this action.'
  res.forbidden 'You are not permitted to perform this action.'
  # res.redirect '/'


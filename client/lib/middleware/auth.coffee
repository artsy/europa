basicAuth = require 'basic-auth'

module.exports = (req, res, next) ->

  unauthorized = (res) ->
    res.set 'WWW-Authenticate', 'Basic realm=Authorization Required'
    return res.sendStatus(401)

  user = basicAuth(req)

  if !user or !user.name or !user.pass
    return unauthorized(res)

  if user.name is process.env.LOCAL_USER && user.pass is process.env.LOCAL_PASSWORD
    return next()
  else
    return unauthorized(res)


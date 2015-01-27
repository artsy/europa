auth = require 'basic-auth'

module.exports = (req, res, next) ->
  user = auth(req)
  if !user or user.name isnt process.env.LOCAL_USER or user.pass isnt process.env.LOCAL_PASSWORD
    res.set 'WWW-Authenticate', 'Basic realm="Europa"'
    return res.sendStatus(401).send()

  next()
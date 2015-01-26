

module.exports.basicAuth = (req, res, next)->
  if req.get('API-KEY') isnt process.env.LOCAL_API_KEY
    return res.sendStatus 401

  next()


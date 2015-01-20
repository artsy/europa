module.exports = adminOnly = (req, res, next) ->
  if not req.user.details?.type isnt 'Admin'
    res.err 401, 'Must be an admin or the user being accessed.'
  else
    next()
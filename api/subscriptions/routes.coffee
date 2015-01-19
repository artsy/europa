_ = require 'underscore'

@index = (res, req, next) ->

@show = (res, req, next) ->

@create = (res, req, next) ->

@find = (res, req, next) ->

@update = (res, req, next) ->

@solveChallenge = (req, res, next) ->
  res.send req.query['hub.challenge']

@callback = (res, req, next) ->




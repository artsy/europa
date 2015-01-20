_ = require 'underscore'
{ Entry } = require '../lib/models.coffee'

@index = (req, res, next) ->
  Entry.find (err, tags)->
    res.send tags

@show = (req, res, next) ->
  Entry.findById req.params.id, (err, tags)->
    res.send tags

@create = (req, res, next) ->
  Entry.create {term: req.body.term, provider: req.body.provider}, (err, tag)->
    if err
      res.send err

    res.send tag

@update = (req, res, next) ->
  Entry.findByIdAndUpdate req.params.id, req.body, (err, tag)->
    if err
      res.send err

    res.send tag

@delete = (req, res, next) ->
  Entry.findByIdAndRemove req.params.id (err, tag)->
    res.send tag
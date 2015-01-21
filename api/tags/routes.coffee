_ = require 'underscore'
{ Tag } = require '../lib/models.coffee'

@index = (req, res, next) ->
  Tag.find (err, tags)->
    res.send tags

@show = (req, res, next) ->
  Tag.findById req.params.id, (err, tags)->
    res.send tags

@create = (req, res, next) ->
  Tag.create {term: req.body.term, provider: req.body.provider}, (err, tag)->
    if err
      res.send err

    res.send tag

@update = (req, res, next) ->
  Tag.findByIdAndUpdate req.params.id, req.body, (err, tag)->
    if err
      res.send err

    res.send tag

@delete = (req, res, next) ->
  Tag.findByIdAndRemove req.params.id, (err, tag)->
    res.send tag
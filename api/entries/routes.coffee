_ = require 'underscore'
ig = require('instagram-node').instagram()
{ Entry } = require '../lib/models.coffee'
{ INSTAGRAM_CLIENT_ID, INSTAGRAM_CLIENT_SECRET } = process.env

ig.use
  client_id: INSTAGRAM_CLIENT_ID
  client_secret: INSTAGRAM_CLIENT_SECRET

@index = (req, res, next) ->
  Entry.find (err, tags)->
    res.send tags

@show = (req, res, next) ->
  Entry.findById req.params.id, (err, tags)->
    res.send tags

@create = (req, res, next) ->
  ig.media req.body.id, (err, media, remaining, limit) ->
    Entry.create {external_id: media.id, payload: media}, (err, tag)->
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
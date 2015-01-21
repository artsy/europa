_ = require 'underscore'
ig = require('instagram-node').instagram()
{ Entry } = require '../lib/models.coffee'
{ INSTAGRAM_CLIENT_ID, INSTAGRAM_CLIENT_SECRET } = process.env

ig.use
  client_id: INSTAGRAM_CLIENT_ID
  client_secret: INSTAGRAM_CLIENT_SECRET

@index = (req, res, next) ->
  Entry.find (err, entries)->
    res.send entries

@show = (req, res, next) ->
  Entry.findById req.params.id, (err, entry)->
    res.send entries

@create = (req, res, next) ->
  # find the media by the external_id and save that payload into the entry
  ig.media req.body.external_id, (err, media, remaining, limit) ->
    Entry.create {external_id: media.id, payload: media}, (err, entry)->
      if err
        res.status(400).send err
      res.status(201).send entry

@update = (req, res, next) ->
  Entry.findByIdAndUpdate req.params.id, req.body, (err, entry)->
    if err
      res.send err

    res.send entry

@delete = (req, res, next) ->
  Entry.findByIdAndRemove req.params.id (err, entry)->
    res.send entry
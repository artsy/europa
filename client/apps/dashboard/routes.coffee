_ = require 'underscore'
Feed = require '../../collections/feed.coffee'

@index = (req, res, next) ->
  feed = new Feed()
  feed.fetch
    success: ->
      res.locals.sd.FEED = feed.toJSON()
      res.render 'index', entries: feed.models





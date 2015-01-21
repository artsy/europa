_ = require 'underscore'
Backbone = require 'backbone'
ig = require('instagram-node').instagram()
Q = require 'q'
{ INSTAGRAM_CLIENT_ID, INSTAGRAM_CLIENT_SECRET } = process.env
{ Tag, Entry } = require '../lib/models.coffee'

ig.use
  client_id: INSTAGRAM_CLIENT_ID
  client_secret: INSTAGRAM_CLIENT_SECRET

getTagFeed = (tag)->
  dfd = Q.defer()

  ig.tag_media_recent tag.term, (err, medias, pagination, remaining, limit)->
    dfd.resolve medias

  return dfd.promise

@index = (req, res, next) ->
  Entry.find null, 'external_id', (err, ids)->

    Tag.find (err, tags)->

      promises = _.map tags, getTagFeed

      Q.allSettled(promises).then( (response)->

        # make a new backbone collection to combine instagram feeds
        # and remove duplicates
        feed = new Backbone.Collection null
        feed.comparator = (model)-> - parseInt model.get('created_time')

        # add all retrieved feeds to the collection
        _.map response, (promise)-> feed.add promise.value

        # mark any entries that have already been approved
        feed.map (entry) ->
          if _.findWhere ids, {external_id: entry.id}
            entry.set('approved', true)

        res.send feed.toJSON()
      ).done()






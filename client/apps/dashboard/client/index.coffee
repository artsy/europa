$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = require 'jquery'
Entry = require '../../../models/entry.coffee'
Feed = require '../../../collections/feed.coffee'

class FeedView extends Backbone.View

  events:
    'click .entry__tools__approve' : 'approveEntry'

  approveEntry: (e)->
    e.preventDefault()
    e.stopPropagation()

    $el = $(e.currentTarget)
    $entry = $el.closest('.entry')

    id = $entry.data('id')

    entry = @collection.get id

    entry.approve()

    $entry.addClass 'entry--approved'


module.exports.init = ->
  feed = new Feed sd.FEED
  new FeedView
    collection: feed
    el: $('.layout__content__main')
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = require 'jquery'
init = require '../../../components/layout/client.coffee'
Entry = require '../../../models/entry.coffee'
Entries = require '../../../collections/entries.coffee'
Feed = require '../../../collections/feed.coffee'
Tags = require '../../../collections/tags.coffee'

entriesTemplate = -> require('../templates/entries.jade') arguments...
tagTemplate = -> require('../templates/tag.jade') arguments...

class FeedView extends Backbone.View
  collectionTypes:
    all: Feed
    approved: Entries

  events:
    'click .entry--approved .entry__tools__approve ' : 'deApproveEntry'
    'click .entry__tools__approve' : 'approveEntry'
    'click .feed__toggle' : 'toggleFeed'

  initialize: ->
    @on 'tags:updated', @fetchEntries

  getFromEvent: (e)->
    $el = $(e.currentTarget)
    $entry = $el.closest('.entry')
    id = $entry.data('id')

    entry = @collection.get id

    {id: id, $entry: $entry, entry: entry}

  deApproveEntry: (e)->
    e.preventDefault()
    e.stopImmediatePropagation()

    {$entry, entry} = @getFromEvent e

    if entry
      entry.deApprove()
      $entry.removeClass 'entry--approved'

  approveEntry: (e)->
    e.preventDefault()
    e.stopImmediatePropagation()

    {$entry, entry} = @getFromEvent e

    if entry
      entry.approve()
      $entry.addClass 'entry--approved'

  # here we switch collection types.
  # Feed: all entries from specified tags
  # Entries: all approved entries
  toggleFeed: (e)->
    $current = $(e.currentTarget)
    collectionName = $current.data('collection')

    @collection = new @collectionTypes[collectionName]

    $('.feed__toggle.is-active').removeClass 'is-active'
    $current.addClass 'is-active'

    @fetchEntries()

  fetchEntries: ->
    @collection.fetch success: @renderEntries

  renderEntries: =>
    @$('.layout__content__main--feed__entries').html entriesTemplate entries: @collection.models

class TagsView extends Backbone.View

  events:
    'click .tag__remove' : 'removeTag'

  initialize: (options)->
    @collection.fetch success:=> @$el.removeClass 'is-loading'

    @listenTo @collection, 'add', @appendTag

    @feedView = options.feedView

  appendTag: (tag)->
    @$el.append tagTemplate(tag: tag)

  render: ->
    @collection.each (tag)=> @appendTag tag

  removeTag: (e)->
    e.preventDefault()
    e.stopPropagation()

    $el = $(e.currentTarget)
    id = $el.closest('.tag').data('id')

    tag = @collection.get id
    tag.destroy
      success: =>
        @feedView.trigger 'tags:updated'
    $el.closest('.tag').remove()

class NewTagView extends Backbone.View

  events:
    'submit' : 'addTag'

  initialize: (options) ->
    @feedView = options.feedView

  getTextValue: -> @$('.tags__form__input').val()

  addTag: (e)->
    e.preventDefault()
    e.stopPropagation()

    attrs = {term: @getTextValue(), provider: 'instagram'}

    @collection.create attrs,
      success: =>
        @$('.tags__form__input').val ""
        @feedView.trigger 'tags:updated'

module.exports.init = ->
  init()

  feed = new Feed sd.FEED
  feedView = new FeedView
    collection: feed
    el: $('.layout__content__main')

  tags = new Tags null
  new TagsView
    collection: tags
    el: $('.layout__content__header__tags__list')
    feedView: feedView

  new NewTagView
    collection: tags
    el: $('.layout__content__header__tags__form')
    feedView: feedView


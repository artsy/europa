$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = require 'jquery'
init = require '../../../components/layout/client.coffee'
Entry = require '../../../models/entry.coffee'
Feed = require '../../../collections/feed.coffee'
Tags = require '../../../collections/tags.coffee'

tagTemplate = -> require('../templates/tag.jade') arguments...

class FeedView extends Backbone.View

  events:
    'click .entry--approved .entry__tools__approve ' : 'deApproveEntry'
    'click .entry__tools__approve' : 'approveEntry'

  getFromEvent: (e)->
    $el = $(e.currentTarget)
    $entry = $el.closest('.entry')
    id = $entry.data('id')

    entry = @collection.get id

    {id: id, $entry: $entry, entry: entry}

  deApproveEntry: (e)->
    console.log 'deApprove'
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


class TagsView extends Backbone.View

  events:
    'click .tag__remove' : 'removeTag'

  initialize: ->
    @collection.fetch success:=> @$el.removeClass 'is-loading'

    @listenTo @collection, 'add', @appendTag

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
      success: -> location.reload()
    $el.closest('.tag').remove()

class NewTagView extends Backbone.View

  events:
    'submit' : 'addTag'

  getTextValue: -> @$('.tags__form__input').val()

  addTag: (e)->
    e.preventDefault()
    e.stopPropagation()

    attrs = {term: @getTextValue(), provider: 'instagram'}

    @collection.create attrs,
      success: ->
        location.reload()

module.exports.init = ->
  init()

  feed = new Feed sd.FEED
  new FeedView
    collection: feed
    el: $('.layout__content__main')

  tags = new Tags null
  new TagsView
    collection: tags
    el: $('.layout__content__header__tags__list')

  new NewTagView
    collection: tags
    el: $('.layout__content__header__tags__form')


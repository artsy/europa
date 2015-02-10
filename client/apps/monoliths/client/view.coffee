init = require '../../../components/layout/client.coffee'
sd = require('sharify').data
_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
EuropaPusher = require '../../../models/europa_pusher.coffee'

presenceTemplate = -> require('../templates/presence.jade') arguments...

class ConsoleView extends Backbone.View

  events:
    'click .reset' : 'resetMonolith'

  initialize: ->
    @pusher = new EuropaPusher
    @$columns = @$ '.layout__content__main--console__columns'

    @pusher.bindChannel 'presence', 'pusher:subscription_succeeded', @showOnlineMonoliths
    @pusher.bindChannel 'presence', 'pusher:member_added', @showOnlineMonoliths
    @pusher.bindChannel 'presence', 'pusher:member_removed', @showOnlineMonoliths

  showOnlineMonoliths: =>
    @$columns.html presenceTemplate members: @pusher.getMembers('presence')

  resetMonolith: (e)=>
    $member = $(e.currentTarget).closest('.monolith-columns__list__member')
    monolithId = $member.data('name')

    @pusher.triggerEvent "command", 'restart', monolithId

module.exports.init = ->
  init()

  new ConsoleView
    el: $('.layout__content__main')
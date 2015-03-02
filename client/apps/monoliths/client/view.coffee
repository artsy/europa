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
    'submit .route-form' : 'routeMonolith'



  initialize: ->
    @pusher = new EuropaPusher
    @$columns = @$ '.layout__content__main--console__columns'
    @$feed = @$ '.layout__content__main--console__columns_feed'
    @$schedule = @$ '.layout__content__main--console__columns_schedule'

    @pusher.bindChannel 'presence', 'pusher:subscription_succeeded', @showOnlineMonoliths
    @pusher.bindChannel 'presence', 'pusher:member_added', @showOnlineMonoliths
    @pusher.bindChannel 'presence', 'pusher:member_removed', @showOnlineMonoliths

    @pusher.bindChannel 'presence_feed', 'pusher:subscription_succeeded', @showFeedMonoliths
    @pusher.bindChannel 'presence_feed', 'pusher:member_added', @showFeedMonoliths
    @pusher.bindChannel 'presence_feed', 'pusher:member_removed', @showFeedMonoliths

    @pusher.bindChannel 'presence_schedule', 'pusher:subscription_succeeded', @showScheduleMonoliths
    @pusher.bindChannel 'presence_schedule', 'pusher:member_added', @showScheduleMonoliths
    @pusher.bindChannel 'presence_schedule', 'pusher:member_removed', @showScheduleMonoliths

  showOnlineMonoliths: =>
    @$columns.html presenceTemplate members: @pusher.getMembers('presence')

  showFeedMonoliths: =>
    @$feed.html presenceTemplate members: @pusher.getMembers('presence_feed')

  showScheduleMonoliths: =>
    @$schedule.html presenceTemplate members: @pusher.getMembers('presence_schedule')

  resetMonolith: (e)=>
    $member = $(e.currentTarget).closest('.monolith-columns__list__member')
    monolithId = $member.data('name')

    @pusher.triggerEvent "command", 'restart', monolithId

  routeMonolith: (e)=>
    e.stopImmediatePropagation()
    e.preventDefault()
    $member = $(e.currentTarget).closest('.monolith-columns__list__member')
    monolithId = $member.data('name')

    route = $(e.currentTarget).find('.route-value').val()

    @pusher.triggerEvent "command", "route", { name: monolithId, route: route }

module.exports.init = ->
  init()

  new ConsoleView
    el: $('.layout__content__main')
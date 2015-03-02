_ = require 'underscore'
sd = require('sharify').data
$ = require 'jquery'

module.exports = class EuropaPusher
  name: "EUROPA"

  constructor: (options) ->
    @pusher = new Pusher sd.PUSHER_KEY,
      authEndpoint: '/api/pusher/auth'
      auth:
        params: client_id: @name

    @subscribeToChannels()

  subscribeToChannels: ->
    @channels =
      command: @pusher.subscribe 'command'
      presence: @pusher.subscribe 'presence-status'
      presence_feed: @pusher.subscribe 'presence-status-feed'
      presence_schedule: @pusher.subscribe 'presence-status-schedule'

  bindChannel: (channelName, channelEvent, callback) =>
    @channels[channelName].bind channelEvent, callback

  getMembers: (channelName)->
    members = @channels[channelName].members.members
    return _.reject members, (member, name) => name is @name

  triggerEvent: (channel, channelEvent, data) ->
    $.ajax
      url:'/api/pusher/publish'
      type: 'POST'
      data:
        channel: channel
        event: channelEvent
        data: data
      success: (res)-> console.log 'published event', res
      error: (res, error) -> console.log 'error', error



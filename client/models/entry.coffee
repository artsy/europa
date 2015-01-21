_  = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
moment = require 'moment'
sd = require('sharify').data

module.exports = class Entry extends Backbone.Model

  url: "#{sd.API_URL}/entries"

  timeAgo: ->
    date = parseInt(@get('created_time')) * 1000
    moment(date).fromNow()

  approve: ->
    $.ajax
      url: "#{sd.API_URL}/entries"
      type: "POST"
      data:
        external_id: @id
        payload:  @toJSON()
      success: (model)=>
        @set 'approved', true
      error: (error)->
        console.log 'entry error', error

_  = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
moment = require 'moment'
sd = require('sharify').data

module.exports = class Entry extends Backbone.Model

  urlRoot: "#{sd.API_URL}/entries"

  parse: (data) ->
    # if we have the payload attribute
    # then this is an approved entry
    # otherwise we just return the entry
    if data.payload?
      data.payload.approved = true
      return data.payload

    return data

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

  deApprove: ->
    # can't just call destroy, we want to keep the model there in case
    # the user changes their mind and re-approves
    $.ajax
      url: "#{sd.API_URL}/entries/#{@id}"
      type: "DELETE"
      success: (model)=>
        @set 'approved', false
      error: (error)->
        console.log 'entry error', error

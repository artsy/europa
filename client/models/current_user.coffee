_  = require 'underscore'
Backbone = require 'backbone'
sd = require('sharify').data

module.exports = class CurrentUser extends Backbone.Model

  url: "#{sd.API_URL}/users/me"

  isAdmin: ->
    @get('details').type is 'Admin'

  profileHandle: ->
    @get('profile')?.handle

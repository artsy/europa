_  = require 'underscore'
Backbone = require 'backbone'
sd = require('sharify').data

module.exports = class Entry extends Backbone.Model

  url: "#{sd.API_URL}/entries"

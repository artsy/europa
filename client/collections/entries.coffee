_ = require 'underscore'
Backbone = require 'backbone'
Entry = require '../models/entry.coffee'
sd = require('sharify').data

module.exports = class Entries extends Backbone.Collection

  url: "#{sd.API_URL}/entries"

  model: Entry
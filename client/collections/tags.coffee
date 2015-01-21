_ = require 'underscore'
Backbone = require 'backbone'
Tag = require '../models/tag.coffee'
sd = require('sharify').data

module.exports = class Tags extends Backbone.Collection

  url: "#{sd.API_URL}/tags"

  model: Tag
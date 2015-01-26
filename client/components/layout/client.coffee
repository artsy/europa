$ = require 'jquery'

module.exports = ->
  $.ajaxSettings.headers =
    'X-API-KEY': sd.LOCAL_API_KEY

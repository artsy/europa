$ = require 'jquery'
sd = require('sharify').data

hash =

  '^$': ->
    require('../apps/dashboard/client/index.coffee').init()

# On DOM load iterate through the hash and load that app's JS
$ ->
  for regexStr, load of hash
    if location.pathname.replace(/\/$/,'').match(new RegExp regexStr)
      load()
      break

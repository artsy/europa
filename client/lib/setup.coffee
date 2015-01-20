#
# Sets up intial project settings, middleware, mounted apps, and
# global configuration such as overriding Backbone.sync and
# populating sharify data
#

# Inject some configuration & constant data into sharify
_ = require 'underscore'
sharify = require 'sharify'
sd = sharify.data = _.pick process.env,
  'APP_URL', 'API_URL', 'NODE_ENV', 'FORCE_URL', 'ARTSY_URL', 'GEMINI_KEY',
  'SENTRY_PUBLIC_DSN'

# Dependencies
express = require 'express'
bodyParser = require 'body-parser'
Backbone = require 'backbone'
path = require 'path'
forceSSL = require 'express-force-ssl'
setupEnv = require './env'
setupAuth = require './auth'
{ parse } = require 'url'
fs = require 'fs'

module.exports = (app) ->

  # Override Backbone to use server-side sync
  Backbone.sync = require 'backbone-super-sync'

  # Mount generic middleware & run setup modules
  app.use forceSSL if 'production' is sd.NODE_ENV
  app.use sharify
  setupEnv app
  setupAuth app
  app.use bodyParser.json()
  app.use bodyParser.urlencoded()

  # Mount apps
  # app.use '/', require '../../apps/article_list'
  # app.use '/', require '../../apps/edit'
  # app.use '/', require '../../apps/impersonate'
  # app.use errorHandler

  # Mount static middleware for sub apps, components, and project-wide
  fs.readdirSync(path.resolve __dirname, '../apps').forEach (fld) ->
    app.use express.static(path.resolve __dirname, "../apps/#{fld}/public")
  fs.readdirSync(path.resolve __dirname, '../components').forEach (fld) ->
    app.use express.static(path.resolve __dirname, "../components/#{fld}/public")
  app.use express.static(path.resolve __dirname, '../public')

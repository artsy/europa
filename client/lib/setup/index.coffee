#
# Sets up intial project settings, middleware, mounted apps, and
# global configuration such as overriding Backbone.sync and
# populating sharify data
#
_ = require 'underscore'
sharify = require 'sharify'
sd = sharify.data = _.pick process.env,
  'APP_URL', 'API_URL', 'NODE_ENV', 'FORCE_URL', 'ARTSY_URL', 'GEMINI_KEY',
  'SENTRY_PUBLIC_DSN', 'LOCAL_API_KEY'

bucketAssets = require 'bucket-assets'
express = require 'express'
session = require 'cookie-session'
bodyParser = require 'body-parser'
Backbone = require 'backbone'
path = require 'path'
forceSSL = require 'express-force-ssl'
setupEnv = require './env'
{ parse } = require 'url'
fs = require 'fs'
auth = require '../middleware/auth'

module.exports = (app) ->

  Backbone.sync = require 'backbone-super-sync'

  Backbone.sync.editRequest = (req) -> req.set('X-API-KEY': sd.LOCAL_API_KEY)

  # Mount generic middleware & run setup modules
  app.use forceSSL if 'production' is sd.NODE_ENV
  app.use sharify
  app.use session
    secret: process.env.SESSION_SECRET
    key: 'europa.sess'
  setupEnv app
  app.use bucketAssets()
  app.use bodyParser.json()
  app.use bodyParser.urlencoded()

  # Mount apps
  app.use auth
  app.use '/', require '../../apps/dashboard'

  # Mount static middleware for sub apps, components, and project-wide
  fs.readdirSync(path.resolve __dirname, '../../apps').forEach (fld) ->
    app.use express.static(path.resolve __dirname, "../../apps/#{fld}/public")
  fs.readdirSync(path.resolve __dirname, '../../components').forEach (fld) ->
    app.use express.static(path.resolve __dirname, "../../components/#{fld}/public")
  app.use express.static(path.resolve __dirname, '../../public')

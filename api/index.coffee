require('node-env-file')("#{process.cwd()}/.env") unless process.env.NODE_ENV?
express = require "express"
bodyParser = require 'body-parser'

{ NODE_ENV, ARTSY_URL, ARTSY_ID, ARTSY_SECRET, MONGOLAB_URI, INSTAGRAM_CLIENT_ID, INSTAGRAM_CLIENT_SECRET, PUSHER_APP_ID, PUSHER_KEY, PUSHER_SECRET} = process.env

ig = require('instagram-node').instagram()
debug = require('debug') 'api'
cors = require 'cors'
mongoose = require 'mongoose'
Pusher = require 'pusher'

pusher = new Pusher
  appId:  PUSHER_APP_ID
  key:    PUSHER_KEY
  secret: PUSHER_SECRET

app = module.exports = express()

# db
mongoose.connect MONGOLAB_URI

# Middleware
app.use cors()
app.use bodyParser.urlencoded()
app.use bodyParser.json()

# Apps
app.use require './tags'
app.use require './entries'
app.use require './feed'

# Routes
app.post '/pusher/auth', (req, res) ->
  socketId = req.body.socket_id
  channel = req.body.channel_name
  auth = pusher.authenticate socketId, channel, user_id: req.body.client_id
  res.send auth

app.get '/system/up', (req, res) ->
  res.status(200).send { up: true }


# app.use errorHandler
# app.use notFound
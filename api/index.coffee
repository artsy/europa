require('node-env-file')("#{process.cwd()}/.env") unless process.env.NODE_ENV?
express = require "express"
bodyParser = require 'body-parser'
{ NODE_ENV, ARTSY_URL, ARTSY_ID, ARTSY_SECRET, MONGOLAB_URI, INSTAGRAM_CLIENT_ID, INSTAGRAM_CLIENT_SECRET} = process.env
ig = require('instagram-node').instagram()
debug = require('debug') 'api'
cors = require 'cors'
mongoose = require 'mongoose'

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

app.get '/system/up', (req, res) ->
  res.status(200).send { up: true }


# app.use errorHandler
# app.use notFound

# Start the test server if run directly
# app.listen(5000, -> debug "Listening on 5000") if module is require.main
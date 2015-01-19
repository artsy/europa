require('node-env-file')("#{process.cwd()}/.env") unless process.env.NODE_ENV?
express = require "express"
bodyParser = require 'body-parser'
{ NODE_ENV, ARTSY_URL, ARTSY_ID, ARTSY_SECRET } = process.env
debug = require('debug') 'api'
cors = require 'cors'

app = module.exports = express()

# Middleware
app.use cors()
app.use bodyParser.urlencoded()
app.use bodyParser.json()

# Apps
app.use require './subscriptions'

app.get '/system/up', (req, res) ->
  res.status(200).send { up: true }


# app.use errorHandler
# app.use notFound

# Start the test server if run directly
# app.listen(5000, -> debug "Listening on 5000") if module is require.main
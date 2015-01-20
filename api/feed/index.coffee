express = require 'express'
routes = require './routes'

app = module.exports = express()

app.get '/feed', routes.index

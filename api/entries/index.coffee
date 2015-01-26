express = require 'express'
routes = require './routes'
{ basicAuth } = require '../lib/middleware'

app = module.exports = express()

app.get '/entries', routes.index
app.get '/entries/:id', routes.show
app.post '/entries', basicAuth, routes.create
app.put '/entries/:id', basicAuth, routes.update
app.delete '/entries/:id', basicAuth, routes.delete


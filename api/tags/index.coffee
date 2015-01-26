express = require 'express'
routes = require './routes'
{ basicAuth } = require '../lib/middleware'

app = module.exports = express()

app.get '/tags', routes.index
app.get '/tags/:id', routes.show
app.post '/tags', basicAuth, routes.create
app.put '/tags/:id', basicAuth, routes.update
app.delete '/tags/:id', basicAuth, routes.delete

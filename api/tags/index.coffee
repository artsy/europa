express = require 'express'
routes = require './routes'

app = module.exports = express()

app.get '/tags', routes.index
app.get '/tags/:id', routes.show
app.post '/tags', routes.create
app.put '/tags/:id', routes.update
app.delete '/tags/:id', routes.delete

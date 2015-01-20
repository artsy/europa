express = require 'express'
routes = require './routes'

app = module.exports = express()

app.get '/entries', routes.index
app.get '/entries/:id', routes.show
app.post '/entries', routes.create
app.put '/entries/:id', routes.update
app.delete '/entries/:id', routes.delete
app.get '/entries/:id', routes.delete

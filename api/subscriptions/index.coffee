express = require 'express'
routes = require './routes'

app = module.exports = express()

app.get '/subscriptions', routes.index
app.get '/subscriptions/:id', routes.show
app.post '/subscriptions', routes.create
app.put '/subscriptions/:id', routes.find, routes.update
app.get '/callback', routes.solveChallenge
app.post '/callback', routes.callback
# app.delete '/articles/:id', routes.find, routes.delete

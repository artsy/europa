_ = require 'underscore'
mongoose = require 'mongoose'

subscriptionSchema = new mongoose.Schema
  provider:
    type: String
    required: true
  term:
    type: String
    required: true
    unique: true
  term_type:
    type: String
    required: true
  subscription_id:
    type: Number
    required: true
    unique: true

Subscription = mongoose.model 'Subscription', subscriptionSchema

@index = (req, res, next) ->
  Subscription.find (err, subscriptions)->
    res.send subscriptions

@show = (req, res, next) ->
  Subscription.findOne {id: req.params.id}, (err, subscriptions)->
    res.send subscriptions

@create = (req, res, next) ->
  # subscription = new Subscription
  #   title: req.body.title
  #   description: req.body.description
  #   style: req.body.style

@find = (req, res, next) ->

@update = (req, res, next) ->

@solveChallenge = (req, res, next) ->
  res.send req.query['hub.challenge']

@callback = (req, res, next) ->




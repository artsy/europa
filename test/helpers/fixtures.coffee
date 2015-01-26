CurrentUser = require '../../client/models/current_user'
moment = require 'moment'

timeCount = 0

module.exports = ->
  timeCount++
  fixtures = {}
  fixtures.tags =
    [{
      term: "thearmoryfair",
      provider: "instagram",
      _id: "54c0363fc1b1da91cfc7b255",
      __v: 0
    },
    {
      term: "ArtsyTakeover",
      provider: "instagram",
      _id: "54c036a9c1b1da91cfc7b257",
      __v: 0
    }]
  fixtures.entries =
  [{
    attribution: null,
    tags: [
      "art",
      "contemporaryart",
      "artsy",
      "artsytakeover",
      "nature"
    ],
    location: null,
    ,
    images: {
      low_resolution: {
        url: "http://scontent-b.cdninstagram.com/hphotos-xfa1/t51.2885-15/s306x306/e15/10948643_641296285995784_1643737510_n.jpg",
        width: 306,
        height: 306
      },
      thumbnail: {
        url: "http://scontent-b.cdninstagram.com/hphotos-xfa1/t51.2885-15/s150x150/e15/10948643_641296285995784_1643737510_n.jpg",
        width: 150,
        height: 150
      },
      standard_resolution: {
        url: "http://scontent-b.cdninstagram.com/hphotos-xfa1/t51.2885-15/e15/10948643_641296285995784_1643737510_n.jpg",
        width: 640,
        height: 640
      }
    },
    caption: {
      created_time: "1422030809",
      text: "AMAR Y NACER #danilorojas #mysignatureOneDot #art #painting #contemporaryart #abstractpainting #mindfulness #natur #nature #natureza #naturaleza #yuluka",
      from: {
        username: "danilorojasart",
        profile_picture: "https://instagramimages-a.akamaihd.net/profiles/profile_400220617_75sq_1370793167.jpg",
        id: "400220617",
        full_name: "danilo rojas"
      },
      id: "904382436036160262"
    },
    type: "image",
    id: "904382435524455391_400220617",
    user: {
      username: "danilorojasart",
      website: "",
      profile_picture: "https://instagramimages-a.akamaihd.net/profiles/profile_400220617_75sq_1370793167.jpg",
      full_name: "danilo rojas",
      bio: "",
      id: "400220617"
      }
  }]
  fixtures.locals =
    asset: ->
    user: new CurrentUser fixtures.users
    sd:
      PATH: '/'
    moment: require 'moment'
    sharify:
      script: -> '<script>var sharify = {}</script>'
  fixtures

var Twit = require('twit')
var mongoose = require('mongoose')
mongoose.connect('mongodb://localhost/tweets');

var tweetScheme = new mongoose.Schema({}, {strict: false})
var tweet = mongoose.model('Tweet', tweetScheme)

var twitter = new Twit({
  consumer_key: "",
  consumer_secret: "",
  access_token: "",
  access_token_secret: ""
})

var stream = twitter.stream('statuses/filter', {"locations":"-180,-90,180,90"})

stream.on('tweet', function (data) {
  var t = new tweet(data)
  t.save(function (err) {})
})

stream.on('error', function (error) {
  console.log("Error: " + error)
})

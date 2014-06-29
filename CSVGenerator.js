var mongoose = require("mongoose")
var stringify = require("csv-stringify")
var fs = require('fs');

mongoose.connect('mongodb://localhost/tweets')

var tweetScheme = new mongoose.Schema({}, {strict: false})
var tweet = mongoose.model('Tweet', tweetScheme)

console.log("finding..")

var locations = [["lat", "long"]]

tweet.find({"geo":{$ne:null}}).select({"geo": 1, "_id": 1}).sort({_id: -1}).limit(300000).exec(function (err, tweets) {
  console.log("returned. err: " + err)
  var tweet;
  for (var c in tweets) {
    tweet = tweets[c].toObject()
    console.log(tweet["_id"])
    locations.push(tweet["geo"]["coordinates"])
  }
  stringify(locations, function(err, output) {
    fs.writeFile('locations.csv', output, function (err) {
      if (err) return console.log(err)
      console.log("Done!")
      process.exit()
    })
  })

})

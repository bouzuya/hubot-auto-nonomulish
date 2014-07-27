{Promise} = require 'q'
request = require 'request'
cheerio = require 'cheerio'

module.exports = (message) ->
  new Promise (resolve, reject) ->
    request
      .post
        url: 'http://www.brownmush.net/kengi'
        form: { message: message }
      , (e, res) ->
        return reject(e) if e?
        $ = cheerio.load res.body
        resolve $('p.lead').text()

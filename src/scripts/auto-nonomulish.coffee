# Description
#   A Hubot script that respond automatically in nonomulished message
#
# Dependencies:
#   "cheerio": "^0.17.0",
#   "q": "^1.0.1",
#   "request": "^2.39.0"
#
# Configuration:
#   None
#
# Commands:
#   * - respond automatically in nonomulished message
#
# Author:
#   bouzuya <m@bouzuya.net>
#
nonomulish = require '../nonomulish'

module.exports = (robot) ->
  robot.hear /^(.*)$/, (res) ->
    p = parseFloat(process.env.HUBOT_AUTO_NONOMULISH_P ? '1.0')
    message = res.match[1]
    if Math.random() <= p
      nonomulish(message).then (message) ->
        res.send message

# Description:
#   心か・・・
#
# Commands:
#   hubot bleach poem v{number}
#

fs = require 'fs'

poem = fs.readFileSync 'kbtit-poem.json'
poem = JSON.parse poem
module.exports = (robot) ->
  robot.respond /BLEACH POEM (.*)$/i, (msg) ->
    message = poem.poem[msg.match[1]]
    if message == undefined
      message = poem.notfound
    msg.send message

  robot.respond /BLEACH AA (.*)$/i, (msg) ->
    message = poem.aa[msg.match[1]]
    if message == undefined
      message = poem.notfound
    message = "```" + message + "```"
    msg.send message


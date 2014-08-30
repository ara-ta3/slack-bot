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
    msg.send poem.poem[msg.match[1]]



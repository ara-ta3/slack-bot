# Description:
#   心か・・・
#
# Commands:
#   hubot bleach poem v{number} - Reply back with poem of Volume <number>
#   hubot bleach aa v{number} - Reply back with Ascii Art of Volume <number>
#   hubot echo <text> - Reply back with <text>
#   hubot die 死なぬ
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

  robot.respond /DIE$/i, (msg) ->
    msg.send "一体いつから`die`が使えると錯覚していた・・・？"

  robot.respond /ECHO (.*)$/i, (msg) ->
    input = msg.match[1]
    if /なん[\.・]*だと[\.・]*/.test(input)
      input = "なん・・・だと・・・\n http://mangakansou.com/wp-content/uploads/2014/05/2341.jpg"
    msg.send input


# Description:
#   Allows Hubot to know many languages.
#
# Commands:
#   hubot translate <phrase> - Searches for a translation for the <phrase> and then prints that bad boy out.

languages =
  "en": "English",
  "ja": "Japanese"

getCode = (language,languages) ->
  for code, lang of languages
      return code if lang.toLowerCase() is language.toLowerCase()

module.exports = (robot) ->
  language_choices = (language for _, language of languages).sort().join('|')
  pattern = new RegExp('translate?' +
                       '(.*)', 'i')
  robot.respond pattern, (msg) ->
    term   = "\"#{msg.match[1]}\""
    origin = 'auto'
    target = 'en'
    
    msg.http("https://translate.google.com/translate_a/t")
      .query({
        client: 't'
        hl: 'en'
        multires: 1
        sc: 1
        sl: origin
        ssel: 0
        tl: target
        tsel: 0
        uptl: "en"
        text: term
      })
      .header('User-Agent', 'Mozilla/5.0')
      .get() (err, res, body) ->
        data   = body
        if data.length > 4 and data[0] == '['
          parsed = eval(data)
          language =languages[parsed[2]]
          parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
          if parsed
            if language is undefined
              msg.send "No results"
            else
              if msg.match[2] is undefined
                msg.send "#{term} is #{language} for #{parsed}"
              else
                msg.send "The #{language} #{term} translates as #{parsed} in #{languages[target]}"


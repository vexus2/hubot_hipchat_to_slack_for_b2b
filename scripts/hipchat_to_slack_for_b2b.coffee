QS = require 'querystring'

module.exports = (robot) ->
  robot.hear /.*?(Fixed|Failed|Timed\sout):\s.*?build.*?/i, (msg) ->
    if /.*?Fixed.*?/.test(msg.message.text)
      body = 'テストが直ったよー'
    else
      body = '@channel テストが落ちたよ！'
    data = QS.stringify({'text': body})
    token = process.env.HUBOT_HIPCHAT_TOKEN

    notify_channel = 'ignition_development'
    robot.http("https://slack.com/api/chat.postMessage?token=#{token}&channel=%23#{notify_channel}&username=nanapi_bot&link_names=1&icon_emoji=%3Ananapibot%3A&pretty=1&" + data)
    .post(data) (err, r, body) ->


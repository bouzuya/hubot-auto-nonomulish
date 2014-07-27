require '../helper'

describe 'auto-nonomulish', ->
  beforeEach (done) ->
    @originalP = process.env.HUBOT_AUTO_NONOMULISH_P
    process.env.HUBOT_AUTO_NONOMULISH_P = '1.0'
    html = '<p class="lead">ワダヂッハアアアァアーー！！こまった。</p>'
    @sinon.stub require('request'), 'post', (_, callback)->
      callback null, body: html
    @kakashi.scripts = [require '../../src/scripts/auto-nonomulish']
    @kakashi.users = [{ id: 'bouzuya', room: 'hitoridokusho' }]
    @kakashi.start().then done, done

  afterEach (done) ->
    process.env.HUBOT_AUTO_NONOMULISH_P = @originalP
    @kakashi.stop().then done, done

  describe 'receive "私はこまった。"', ->
    it 'send "ワダヂッハアアアァアーー！！こまった。"', (done) ->
      sender = id: 'bouzuya', room: 'hitoridokusho'
      message = '私はこまった。'
      @kakashi
        .receive sender, message
        .then =>
          expect(@kakashi.send).to.have.callCount(1)
          expect(@kakashi.send.firstCall.args[1]).to
            .equal('ワダヂッハアアアァアーー！！こまった。')
        .then (-> done()), done

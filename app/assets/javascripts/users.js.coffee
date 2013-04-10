jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true

  # TOKBOX
  API_KEY = '25718772'
  TOKEN = 'T1==cGFydG5lcl9pZD0yNTcxODc3MiZzZGtfdmVyc2lvbj10YnJ1YnktdGJyYi12MC45MS4yMDExLTAyLTE3JnNpZz01ZjFjMWEwZGY4OTM2NGNjNTM3Y2RiNjI5N2ExOGE1ODg2MGIwMjcxOnJvbGU9bW9kZXJhdG9yJnNlc3Npb25faWQ9Ml9NWDR5TlRjeE9EYzNNbjR4TWpjdU1DNHdMakYtVkhWbElFRndjaUF3T1NBeE1UbzBNRG93TkNCUVJGUWdNakF4TTM0d0xqTTNOamt3TXpSLSZjcmVhdGVfdGltZT0xMzY1NTMyODEwJm5vbmNlPTAuMTE5MTI5NzY3NDY5NDkyNDQmZXhwaXJlX3RpbWU9MTM2ODEyNDgxMiZjb25uZWN0aW9uX2RhdGE9'

  VIDEO_HEIGHT = 240
  VIDEO_WIDTH = 320

  recorderManager = TB.initRecorderManager(API_KEY)
  recorder = recorderManager.displayRecorder(TOKEN, 'recorderElement')
  recorder.addEventListener('recordingStarted', recStartedHandler)
  recorder.addEventListener('archiveSaved', archiveSavedHandler)
  window.recorder = recorder

recStartedHandler = (event) ->
  recImgData = window.recorder.getImgData()

archiveSavedHandler = (event) ->
  archive = event.archives[0]
  archive_id = archive.archiveId
  $.post 'videos/',
    {tokbox_id: archive_id, user_id: $('#hidden_data').attr('user_id')},
  window.location = '/dashboards'
  false

# window.fbAsyncInit = ->
#   FB.init(appId: '321222854671109', cookie: true)

#   $('#sign_in').click (e) ->
#     e.preventDefault()
#     FB.login (response) ->
#       window.location = '/auth/facebook/callback' if response.authResponse

#   $('#sign_out').click (e) ->
#     FB.getLoginStatus (response) ->
#       FB.logout() if response.authResponse
#     true

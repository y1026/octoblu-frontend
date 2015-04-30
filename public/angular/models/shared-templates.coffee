SHARED_TEMPLATES =
  'E406E836-D97B-495D-834B-EBF1FA0AC497': {
    'name': 'SMS -> Weather'
    'id': 'fbc3a070-e91e-11e4-bd02-3515df578f32'
    'description': 'Sends a text message containing the weather'
    'tags': ['sms', 'weather', 'essential', 'text']
    'liked_by': ['userid1','userid2','userid3','userid4','userid5','user6','user7','user8']
    'download_count': 50
    'author': 'Octoblu'
  }
  '22D94D71-6C5B-4EDF-AB8C-E3ED2B3D714E': {
    'name': 'Twitter Sentiment Analysis'
    'id': 'b2490ca0-e91e-11e4-bd02-3515df578f32'
    'description': 'Changes color of Blink(1) depending on sentiment analysis of tweets from Twitter'
    'tags': ['twitter', 'blink', 'tweet', 'sentiment']
    'liked_by': ['userid1','userid2','userid3','userid4','userid5']
    'download_count': 944
    'author': 'Octoblu'
  }
  '6270B65B-8EAE-49F1-A96B-7CCB20F7403E': {
    'name': 'GoToMeeting -> Shell'
    'id': '2c674e60-e92f-11e4-84e5-75b844d80250'
    'description': 'Creates and starts a GoToMeeting, then opens it from the shell.'
    'tags': ['gotomeeting', 'shell', 'essential', 'enterprise']
    'liked_by': ['userid1','userid2','userid3']
    'download_count': 10
    'author': 'Octoblu'
  }
  'FE188D6C-A96D-4B6C-829E-0943AE80A1BC': {
    'name': 'Gifs -> Shell'
    'id': '9883e770-e934-11e4-84e5-75b844d80250'
    'description': 'Searches Giphy.com for gifs and opens them using the shell node.'
    'tags': ['fun', 'shell', 'genericdevice', 'gifs']
    'liked_by': ['userid1','userid2','userid3','userid4','userid5','b7cdcf1d-aa8d-4ee3-85ee-cbaab78e8f34']
    'download_count': 33
    'author': 'Octoblu'
  }

angular.module('octobluApp').constant 'SHARED_TEMPLATES', SHARED_TEMPLATES
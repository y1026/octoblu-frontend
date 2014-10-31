var request = require('request');
var Channel = require('../models/channel');
var channelId = '53dfcb87626a43a44f966d0a';
var applicationCredentials = Channel.syncFindById(channelId).applicationCredentials;

var EchoSignController = function(){
  this.authorize = function(req, res, next){
  	request.post({
  			url:'https://secure.echosign.com/api/rest/v2/auth/tokens',
  			json: {
          userCredentials: {
            apiKey : req.query.apiKey
          },
          applicationCredentials : applicationCredentials
        }
  		}, function(err, httpResponse, body) {
  		  if (err || !body.accessToken) {
  		    console.error('EchoSign Auth Failed:', err, body.accessToken);
          res.redirect('/home');
          return;
  		  }
        req.user.overwriteOrAddApiByChannelId(channelId, {authtype: 'echosign', token: body.accessToken});
  		  req.user.save(function (err) {
          return next();
        });
		});
  };
  this.redirectToDesigner = function(req, res){
    res.redirect('/design');
  };
};

module.exports = EchoSignController;
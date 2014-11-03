var express        = require('express');
var errorhandler   = require('errorhandler');
var http           = require('http');
var https          = require('https');
var morgan         = require('morgan');
var cookieParser   = require('cookie-parser');
var bodyParser     = require('body-parser');
var expressSession = require('express-session');
var cors           = require('cors');
var mongoose       = require('mongoose');
var passport       = require('passport');
var flash          = require('connect-flash');
var skynetdb       = require('./app/lib/skynetdb');
var connectRedis   = require('connect-redis');
var fs             = require('fs');
var privateKey     = fs.readFileSync('config/server.key', 'utf8');
var certificate    = fs.readFileSync('config/server.crt', 'utf8');

var credentials = {key: privateKey, cert: certificate};

var app        = express();
var env        = app.settings.env;
var configAuth = require('./config/auth.js')(env);
var port       = process.env.OCTOBLU_PORT || configAuth.port;
var sslPort    = process.env.OCTOBLU_SSLPORT || configAuth.sslPort;

if (process.env.AIRBRAKE_KEY) {
  var airbrake = require('airbrake').createClient(process.env.AIRBRAKE_KEY);
  app.use(airbrake.expressHandler())
}

var configDB = require('./config/database.js')(env);
mongoose.connect(configDB.url); // connect to our database
skynetdb.connect(configDB.skynetUrl);
var RedisStore = connectRedis(expressSession);
// Initialize Models

//moved all the models initialization into here, because otherwise when we include the schema twice,
//mongoose blows up because the model is duplicated.
require('./initializeModels.js');

require('./config/passport')(env, passport); // pass passport for configuration
passport.use(require('./config/app-net'));
passport.use(require('./config/bitly'));
passport.use(require('./config/box'));
passport.use(require('./config/dropbox'));
passport.use(require('./config/facebook'));
passport.use(require('./config/fitbit'));
passport.use(require('./config/four-square'));
passport.use(require('./config/github'));
passport.use(require('./config/jawbone'));
passport.use(require('./config/google'));
passport.use(require('./config/gotomeeting'));
passport.use(require('./config/instagram'));
passport.use(require('./config/linked-in'));
passport.use(require('./config/paypal'));
passport.use(require('./config/nest'));
passport.use(require('./config/rdio'));
passport.use(require('./config/sharefile'));
passport.use(require('./config/spotify'));
passport.use(require('./config/survey-monkey'));
passport.use(require('./config/twitter'));
passport.use(require('./config/vimeo'));
passport.use(require('./config/smartsheet'));
passport.use(require('./config/salesforce'));
passport.use(require('./config/quickbooks'));
passport.use(require('./config/xero'));
passport.use(require('./config/redbooth'));
passport.use(require('./config/podio'));
passport.use(require('./config/wordpress'));
passport.use(require('./config/uservoice'));
passport.use(require('./config/local'));

// set up our express application
app.use(morgan('dev', {immediate:false})); // log every request to the console
app.use(cookieParser()); // read cookies (needed for auth)

// app.use(express.bodyParser()); // get information from html forms
// app.use(bodyParser());
// increasing body size for resources
app.use(bodyParser({limit: '50mb'}));

app.use(express.static(__dirname + '/public'));     // set the static files location /public/img will be /img for users

// app.set('view engine', 'jade'); // set up jade for templating

// required for passport
app.use(expressSession({
        store:  new RedisStore({url: configDB.redisSessionUrl}),
        secret: 'e2em2miotskynet',
        cookie: { domain: configAuth.domain}
    })); // session secret
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
app.use(flash()); // use connect-flash for flash messages stored in session
app.use(cors());
if (process.env.NODE_ENV === 'development') {
  app.use(errorhandler());
}

require('./app/routes.js')(app, passport);

var httpServer = http.createServer(app);
var httpsServer = https.createServer(credentials, app);

httpServer.listen(port, function(){
    console.log('Listening on port ' + port);
});

httpsServer.listen(sslPort, function() {
  console.log('HTTPS listening on', sslPort);
});

var mongoose = require( 'mongoose' );
var DB_URL = process.env.DB_URL || 'mongodb://chessmean:ZoFr8nwH2LJmpAMZHiBzIUEEsVc4MNA6CWcI2LIfCvZDN6a8Trr9NQrF0ELdDYZc9jCjbogw1pgamHDu72oQag%3D%3D@chessmean.documents.azure.com:10255/?ssl=true", function (err, client) {
  client.close();
});
mongoose.connect(DB_URL);

mongoose.connection.on('connected', function () { 
 console.log('Mongoose connected to ' + DB_URL); 
}); 

mongoose.connection.on('error', function (err) { 
 console.log('Mongoose connection error: ' + err); 
}); 

mongoose.connection.on('disconnected', function () { 
 console.log('Mongoose disconnected'); 
});

var user = require('./models/users');
var game = require('./models/games');

exports.user = user; 
exports.game = game;

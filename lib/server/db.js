var mongoose = require( 'mongoose' );
var DB_URL = process.env.DB_URL || 'mongodb://chess428:b3qwSGQ5mCM8NMyjgbvDsPu3uDQtVEqWmrF85pZBoik71h3InFrYQLCmkUq0y66qPKHCJwqfGxre3PptZ26DLA==@chess428.documents.azure.com:10255/?ssl=true';
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

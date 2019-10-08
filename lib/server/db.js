var mongoose = require( 'mongoose' );
var DB_URL = process.env.DB_URL || 'mongodb://chess428:RTX5HohCcnVmD2hLctbKHkLwJpBmeRkS9We5em7i5SXk8rwR8w2hP9W3mp9lXsU81ut9XZXS8HiqRE88fpJIvg%3D%3D@chess428.documents.azure.com:10255/?ssl=true';
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

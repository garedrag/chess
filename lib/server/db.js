var mongoose = require( 'mongoose' );
var DB_URL = process.env.DB_URL || 'mongodb://chessnew:N0iXF7Rc6w6pWzz5QURBcXG2aAZIZl9yt1disyBBl0l22uKUWiinD5lMHNlQ777L6YJTME795fq6155UmKRnyw%3D%3D@chessnew.documents.azure.com:10255/?ssl=true';
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

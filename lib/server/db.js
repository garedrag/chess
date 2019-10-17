var mongoose = require( 'mongoose' );
var DB_URL = process.env.DB_URL || 'mongodb://chess428:xS28a3RTntLfOl0SqBJoSUBijCLlpLxkcj4qnH6ECohW6PQUsw607qutCdnmqPGxgUd6KBlPVeSOPmf83Cq4Fw==@chess428.documents.azure.com:10255/?ssl=true';
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

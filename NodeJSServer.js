// Connecting to MySQL Database

var http = require('http');

var mysql = require('mysql2');

var dbConnection = mysql.createConnection({
	host: '138.68.140.83',
	user: 'Prudhvi',
	password: 'Prudhvi@2004',
	database: 'dbPrudhvi'
});

dbConnection.connect(function(error) {
	if (error) throw error;
	// responce.write(dbConnection)
});

http.createServer(function (request, responce) {
	responce.write('Working NodeJS Server');
	// console.log(dbConnection);
	var query = "SELECT *FROM Item";
	dbConnection.query(query, function(error, result) {
		if (error) throw error;
		// console.log(result);
		for (let record in result) {
			console.log(record);
			console.log("--------------------");
		}
	});
	responce.end();
}).listen(8083); 

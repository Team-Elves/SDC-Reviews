const mysql = require('mysql');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Matthias',
  database: 'sdc_reviews'
});

connection.connect((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log('Connected to sdc_reviews at ', connection.threadId)
  }
});

///////////// DATABASE QUERIES:



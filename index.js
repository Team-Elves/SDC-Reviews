const express = require('express');
const db = require('./db/index.js');
const path = require('path');
const parser = require('body-parser');

const PORT = 3000;
const app = express();

// app.use(express.static(path.join(__dirname, '..', 'public')));
// app.use(parser.json());
// app.use(parser.urlencoded({extended: false}));

//////////// SERVER CONTROLLERS: ////////
//// create new review:

//// read reviews by id number:

//// update review by id with response:

//// update review by id with reported:

//// update review by id with helpfulness:

app.listen(PORT, () => {
  console.log(`Server listening at localhost:${PORT}!`);
});
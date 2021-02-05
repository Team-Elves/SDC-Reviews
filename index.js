require('newrelic');
const express = require('express');
const db = require('./db/index.js');
const path = require('path');
const parser = require('body-parser');

const PORT = 3000;
const app = express();

// app.use(express.static(path.join(__dirname, '..', 'public')));
app.use(parser.json());
app.use(parser.urlencoded({extended: false}));

//////////// SERVER CONTROLLERS: ////////
//// create new review:

//// server test:
app.get('/review', (req, res) => {
  console.log('postman is at the door!')
  res.send('Hello from the server!')
});

//// read reviews by product id number:
app.get('/reviews/:id', (req, res) => {
  db.getReviewsByProduct(req.params, req.query, (err, result) => {
    if (err) {
      console.log(err)
      res.sendStatus(500);
    } else {
      res.send(result);
    }
  })
})

//// read metadata for review by product id number:
app.get('/reviews/:id/meta', (req, res) => {
  db.getMetaByProduct(req.params, (err, result) => {
    if (err) {
      console.log(err);
      res.sendStatus(500);
    } else {
      res.send(result);
    }
  })
})

//// update review by id with response:

//// update review by id with reported:

//// update review by id with helpfulness:

app.listen(PORT, () => {
  console.log(`Server listening at localhost:${PORT}!`);
});
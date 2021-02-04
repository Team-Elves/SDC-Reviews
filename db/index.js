var Promise = require('bluebird')
const mysql = require('mysql');
// require('log-timestamp');

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

module.exports = {

  getReviewsByProduct: function(params, query, callback) {
    var querySQL1 = "SELECT reviews.reviewId AS `review id`, reviews.rating, reviews.summary, reviews.recommend, reviews.response, reviews.body, reviews.date, reviews.reviewerName AS `reviewer name`, reviews.helpfulness FROM reviews WHERE reviews.product = ? ;";
    var querySQL2 = "SELECT url FROM reviews_photos WHERE reviewId = ?;";
    // queries are async but callback-based, let's change that to promise-based:
    var asyncQuery = Promise.promisify(connection.query, {context: connection});
    asyncQuery(querySQL1, params.id)//, orderBy)
      // returns an array of promises....
      .then((results) => {
        // we'll need to wait for everything to resolve in this .then block before moving on, so:
        return Promise.all(results.map((reviewObj) => {
          // run the second (inner) query:
          return asyncQuery(querySQL2, reviewObj[`review id`])
            .then((photosObj) => {
              // adjust each reviewObj to your desired appearance:
              reviewObj.photos = photosObj.map((photo) => ( photo.url ))
              if (reviewObj.response.length === 0) {
                reviewObj.response = null;
              }
              // return it up this chain.... this goes back to the previous .map() one by one:
              return reviewObj;
            });
        }))
      })
      .then((modRevObj) => {
        var finalRevObj = {
          product: parseInt(params.id),
          page: params.page || 1,
          count: params.count || 5,
          results: modRevObj
        }
        callback(null, finalRevObj)
      })
      .catch((error) => {
        callback(error)
      })
  },

  getMetaByProduct: function(params, callback) {
    var querySQL3 = 'SELECT reviews.rating, reviews.recommend, characteristics.charId, characteristics.charName, characteristic_reviews.charRevValue FROM reviews LEFT JOIN characteristics ON reviews.product = characteristics.productId LEFT JOIN characteristic_reviews ON characteristic_reviews.charId=characteristics.charId WHERE reviews.product = ?;';
    var asyncQuery = Promise.promisify(connection.query, {context: connection});
    asyncQuery(querySQL3, params.id)
      .then((results) => {
        // prepare each part of the return object:
        var productId = '';
        var ratingsTallies = {};
        var rec = 0;
        var chars = {};
        results.map((object) => {
          // ratings tallies:
          if (!ratingsTallies[object.rating]) {
            ratingsTallies[object.rating] = 1;
          } else {
            ratingsTallies[object.rating]++;
          }
          // recommended tallies:
          if (object.recommend === 0) {
            rec++;
          }
          // characteristics:
          // if that characteristic name isn't already a property on the chars object:
          if (!chars[object.charName]) {
            // set it, and set up the inner values:
            chars[object.charName] = {
              charValuesArr: [object.charRevValue],
              id: object.charId,
              value: object.charRevValue
            }
          } else {
            // since it does exist, push in the next value:
            chars[object.charName].charValuesArr.push(object.charRevValue);
          }
        })
        // calculate averages for each characteristic, and ditch the array before sending back:
        for (key in chars) {
          chars[key].value = Math.floor((chars[key].charValuesArr.reduce((a, b) => a + b) / chars[key].charValuesArr.length) * 100) / 100;
          delete chars[key].charValuesArr;
        }
        var finalAnswer = {
          "product id": params.id,
          ratings: ratingsTallies || null,
          recommended: { 0: rec },
          characteristics: chars || null
        }
        callback(null, finalAnswer)
      })
      .catch((error) => {
        callback(error)
      })
    }

}

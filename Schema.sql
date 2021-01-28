DROP DATABASE IF EXISTS sdc_reviews;

CREATE DATABASE sdc_reviews;

USE sdc_reviews;

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  reviewId INT NOT NULL AUTO_INCREMENT,
  prodId INT NOT NULL,
  ratingNum INT NOT NULL,
  reviewDate VARCHAR(100) NOT NULL,
  summary VARCHAR(100) NOT NULL,
  body VARCHAR(500) NOT NULL,
  recommend INT NOT NULL,
  reported INT,
  reviewerName VARCHAR(100) NOT NULL,
  reviewerEmail VARCHAR(100),
  response VARCHAR(500),
  helpfulness INT,
  photo1 VARCHAR(300),
  photo2 VARCHAR(300),
  photo3 VARCHAR(300),
  characteristicSize INT,
  characteristicWidth INT,
  characteristicComfort INT,
  characteristicQuality INT,
  characteristicLength INT,
  characteristicFit INT,
  PRIMARY KEY (reviewId)
);

/* Heads up:
reviews.csv has fields coming in like this:
id,product_id,rating,date,summary,body,recommend,reported,reviewer_name,reviewer_email,response,helpfulness

reviews_photos.csv has fields coming in like this:
id,review_id,url

characteristics.csv has fields coming in like this:
id,product_id,name

characteristic_reviews.csv has fields coming in like this:
id,characteristic_id,review_id,value

...... so you can throw that schema right out the window.


/*  Execute this file from the command line by typing:
 *    mysql -u root < pathToHereWithinRepo/schema.sql
 *  to create the database and the tables.*/
DROP DATABASE IF EXISTS sdc_reviews;

CREATE DATABASE sdc_reviews;

USE sdc_reviews;

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id INT NOT NULL AUTO_INCREMENT,
  reviewId INT NOT NULL ,
  product INT NOT NULL,
  rating TINYINT NOT NULL,
  date VARCHAR(100) NOT NULL,
  summary VARCHAR(100) NOT NULL,
  body VARCHAR(500) NOT NULL,
  recommend TINYINT NOT NULL,
  reported TINYINT NOT NULL,
  reviewerName VARCHAR(100) NOT NULL,
  reviewerEmail VARCHAR(100) NOT NULL,
  response VARCHAR(500),
  helpfulness TINYINT NOT NULL,
  PRIMARY KEY (id)
  INDEX (product)
  INDEX (reviewId)
);

DROP TABLE IF EXISTS reviews_photos;

CREATE TABLE reviews_photos (
  id INT NOT NULL AUTO_INCREMENT,
  photoId INT NOT NULL,
  reviewId INT NOT NULL,
  url VARCHAR(500) NOT NULL,
  PRIMARY KEY (id)
  INDEX (reviewId)
);

DROP TABLE IF EXISTS characteristics;

CREATE TABLE characteristics (
  id INT NOT NULL AUTO_INCREMENT,
  charId INT NOT NULL,
  productId INT NOT NULL,
  charName VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
  INDEX (productId)
  INDEX (charId)
);

DROP TABLE IF EXISTS characteristic_reviews;

CREATE TABLE characteristic_reviews (
  id INT NOT NULL AUTO_INCREMENT,
  charRevId INT NOT NULL,
  charId INT NOT NULL,
  reviewId INT NOT NULL,
  charRevValue TINYINT NOT NULL,
  PRIMARY KEY (id)
  INDEX (reviewId)
  INDEX (charId)
);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
-- IGNORE 5777915 LINES
(reviewId, product, rating, date, summary, body, recommend, reported, reviewerName, reviewerEmail, response, helpfulness);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/reviews_photos.csv'
INTO TABLE reviews_photos
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
-- IGNORE 2742400 LINES
(photoId, reviewId, url);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/characteristics.csv'
INTO TABLE characteristics
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
-- IGNORE 3347000 LINES
(charId, productId, charName);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/characteristic_reviews.csv'
INTO TABLE characteristic_reviews
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
-- IGNORE 19337000 LINES
(charRevId, charId, reviewId, charRevValue);




/*  Execute this file from the command line by typing:
 *    mysql -u root -p < Schema.sql
 *  to create the database and the tables.
 *
 *  Re-execute this file from inside the MySQl shell by typing:
 *  source Schema.sql;
 */
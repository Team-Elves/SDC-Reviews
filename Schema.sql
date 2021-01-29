DROP DATABASE IF EXISTS sdc_reviews;

CREATE DATABASE sdc_reviews;

USE sdc_reviews;

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id INT NOT NULL AUTO_INCREMENT,
  origId INT,
  prodId INT,
  rating INT,
  date VARCHAR(100),
  summary VARCHAR(100),
  body VARCHAR(500),
  recommend INT,
  reported INT,
  reviewerName VARCHAR(100),
  reviewerEmail VARCHAR(100),
  response VARCHAR(500),
  helpfulness INT,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS reviews_photos;

CREATE TABLE reviews_photos (
  id INT NOT NULL AUTO_INCREMENT,
  origId INT,
  reviewId INT,
  url VARCHAR(500),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS characteristics;

CREATE TABLE characteristics (
  id INT NOT NULL AUTO_INCREMENT,
  origId INT NOT NULL,
  productId INT NOT NULL,
  charName VARCHAR(20),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS characteristic_reviews;

CREATE TABLE characteristic_reviews (
  id INT NOT NULL AUTO_INCREMENT,
  origId INT NOT NULL,
  characteristicId INT NOT NULL,
  reviewId INT NOT NULL,
  charValue INT,
  PRIMARY KEY (id)
);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
-- IGNORE 5777000 LINES
(origId, prodId, rating, date, summary, body, recommend, reported, reviewerName, reviewerEmail, response, helpfulness);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/reviews_photos.csv'
INTO TABLE reviews_photos
FIELDS TERMINATED BY ','
-- IGNORE 2742000 LINES
(origId, reviewId, url);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/characteristics.csv'
INTO TABLE characteristics
FIELDS TERMINATED BY ','
-- IGNORE 3347000 LINES
(origId, productId, charName);

LOAD DATA LOCAL INFILE '/Users/CaylaCardiff 1/Desktop/Work/HackReactor/HRATX53/CodingProjects/SDC-Reviews/giantCSVs/characteristic_reviews.csv'
INTO TABLE characteristic_reviews
FIELDS TERMINATED BY ','
-- IGNORE 19337000 LINES
(origId, characteristicId, reviewId, charValue);


/*  Execute this file from the command line by typing:
 *    mysql -u root -p < Schema.sql
 *  to create the database and the tables.
 *
 *  Re-execute this file from inside the MySQl shell by typing:
 *  source Schema.sql;
 */
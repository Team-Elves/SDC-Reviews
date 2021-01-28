DROP DATABASE IF EXISTS sdc_reviews;

CREATE DATABASE sdc_reviews;

USE sdc_reviews;

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id INT NOT NULL AUTO_INCREMENT,
  origReviewID INT NOT NULL,
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
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS reviews_photos;

CREATE TABLE reviews_photos (
  id INT NOT NULL AUTO_INCREMENT,
  origId INT NOT NULL,
  reviewID INT NOT NULL,
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


/*  Execute this file from the command line by typing:
 *    mysql -u root -p < Schema.sql
 *  to create the database and the tables.*/
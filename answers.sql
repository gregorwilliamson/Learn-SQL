CREATE DATABASE record_company;
USE record_company;

CREATE TABLE bands (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE albums (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  release_year INT,
  band_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (band_id) REFERENCES bands(id)
);

# 1. Create a Songs Table

CREATE TABLE songs (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
	length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);

SELECT * FROM songs;

# 2. Select only the Names of all the Bands

SELECT name AS 'Band Name' FROM bands;

# 3. Select the Oldest Album

SELECT * FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

# 4. Get all Bands that have Albums

SELECT * FROM albums;
SELECT * FROM bands;

SELECT DISTINCT bands.name AS 'Band Name'
FROM bands JOIN albums ON bands.id=albums.band_id;

# 5. Get all Bands that have No Albums

SELECT bands.name AS 'Band Name'
FROM bands LEFT JOIN albums ON bands.id=albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0;

# 6. Get the Longest Album

SELECT albums.name AS 'Name', albums.release_year as 'Year', SUM(songs.length) AS 'Duration'
FROM albums JOIN songs ON albums.id=songs.album_id
GROUP BY songs.album_id
ORDER BY SUM(songs.length) DESC
LIMIT 1;

# 7. Update the Release Year of the Album with no Release Year

SELECT * FROM albums
WHERE release_year IS NULL;

UPDATE albums
SET release_year = 1986 WHERE id = 4;

SELECT * FROM albums;

# 8. Insert a Record for your Favorite Band and one of their Albums

SELECT * FROM bands;

INSERT INTO bands (name)
VALUES('WU LYF');

SELECT * FROM albums;

INSERT INTO albums (name, release_year, band_id)
VALUES('Go tell fire to the mountain', 2011, (SELECT id FROM bands WHERE name='WU LYF'));

# 9. Delete the Band and Album you added in 8

DELETE FROM albums
WHERE id = 19;

DELETE FROM bands
WHERE id = 8;

# 10. Get the Average Length of all Songs

SELECT AVG(length) AS 'Average Song Duration'
FROM songs;

# 11. Select the longest Song of each Album

SELECT albums.name AS 'Album', albums.release_year AS 'Release Year', MAX(length) AS 'Duration'
FROM songs JOIN albums ON songs.album_id = albums.id
GROUP BY album_id;

# Get the number of albums for each band (which happens to be 3 for each)

SELECT bands.name AS 'Band', COUNT(albums.band_id) AS 'Number of albums'
FROM bands RIGHT JOIN albums ON albums.band_id = bands.id
GROUP BY bands.id;

# Get the number of songs for each album

SELECT albums.name AS 'Album', COUNT(songs.album_id) AS 'Number of songs'
FROM albums RIGHT JOIN songs ON songs.album_id = albums.id
GROUP BY albums.id;

# 12. Get the number of Songs for each Band

SELECT bands.name AS 'Band', COUNT(songs.album_id) AS 'Number of Songs' 
FROM bands RIGHT JOIN albums ON albums.band_id = bands.id
RIGHT JOIN songs ON songs.album_id = albums.id
GROUP BY bands.id;

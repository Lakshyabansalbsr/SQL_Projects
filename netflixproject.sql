-- Average IMDb scores for each genre of Netflix Originals--

SELECT g.Genre, 
       ROUND(AVG(n.IMDBScore), 2) AS Avg_IMDBScore
FROM project.netflixdata AS n
JOIN project.genredata AS g
  ON n.GenreID = g.GenreID
GROUP BY g.Genre
ORDER BY Avg_IMDBScore DESC;

-- genres have an average IMDB score higher than 7.5?--

SELECT round(AVG(n.IMDBScore),2) AS AVG_IMDBScore, g.Genre
FROM project.netflixdata AS n
JOIN project.genredata AS g
  ON n.GenreID = g.GenreID
GROUP BY g.Genre
Having AVG(n.IMDBScore) > 7.5
ORDER BY Avg_IMDBScore DESC;

-- List Netflix Original titles in descending order of their IMDB scores --

SELECT Title, IMDBScore
FROM project.netflixdata
ORDER BY IMDBScore DESC;

-- Retrieve the top 10 longest Netflix Originals by runtime --

SELECT Title, Runtime
FROM project.netflixdata
ORDER BY Runtime DESC
LIMIT 10;

-- Retrieve the titles of Netflix Originals along with their respective genres --

SELECT n.Title, g.Genre
FROM project.netflixdata as n
JOIN project.genredata AS g
  ON n.GenreID = g.GenreID;

-- Rank Netflix Originals based on their IMDB scores within each genre --

SELECT n.Title, g.Genre, n.IMDBScore, 
RANK() OVER (
        PARTITION BY g.Genre 
        ORDER BY n.IMDBScore DESC
    ) AS Rank_in_Genre
FROM project.netflixdata AS n
JOIN project.genredata AS g
  ON n.GenreID = g.GenreID
  LIMIT 10;
  
  -- Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles --

SELECT n.Title, g.Genre, n.IMDBScore
FROM project.netflixdata as n
JOIN project.genredata AS g
ON n.GenreID = g.GenreID
WHERE n.IMDBScore > ( SELECT AVG(n.IMDBScore) FROM project.netflixdata)
ORDER BY n.IMDBScore DESC;

-- How many Netflix Originals are there in each genre --

SELECT g.Genre, COUNT(*) AS Number_of_Titles
FROM project.netflixdata as n
JOIN project.genredata as g
ON n.GenreID = g.GenreID
GROUP BY g.Genre
ORDER BY Number_of_Titles DESC;

-- Which genres have more than 5 Netflix Originals with an IMDB score higher than 8 --

SELECT g.Genre, COUNT(*) AS Number_of_Titles
FROM project.netflixdata as n
JOIN project.genredata as g
ON n.GenreID = g.GenreID
WHERE n.IMDBScore > 8
GROUP BY g.Genre
HAVING count(*) > 5
ORDER BY Number_of_Titles DESC;

-- Whatare the top 3 genres with the highest average IMDb scores, and how many Netflix Originals do they have? --

SELECT g.Genre, AVG(n.IMDBScore) AS Average_IMDB_Score, COUNT(*) AS Number_of_Netflix_Originals
FROM project.netflixdata as n
JOIN project.genredata as g 
ON n.GenreID = g.GenreID
GROUP BY g.Genre
ORDER BY Average_IMDB_Score DESC
LIMIT 3;












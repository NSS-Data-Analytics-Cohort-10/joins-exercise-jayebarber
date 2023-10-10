-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT *
FROM specs
INNER JOIN revenue
ON revenue.movie_id = specs.movie_id



-- 2. What year has the highest average imdb rating?
SELECT release_year, AVG(rating.imdb_rating)
FROM specs
INNER JOIN rating
USING (movie_id)
GROUP BY release_year
ORDER BY AVG(rating.imdb_rating) desc;

-- ANSWER: 1991


-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT specs.film_title, specs.mpaa_rating, revenue.worldwide_gross
FROM specs 
INNER JOIN revenue USING (movie_id)
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC;
-- ANSWER: Toy Story 4

SELECT specs.film_title, distributors.company_name, specs.mpaa_rating, revenue.worldwide_gross
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

-- ANSWER: Walt Disney 


SELECT *
FROM distributors 

SELECT *
FROM specs

SELECT *
FROM revenue 





-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table
SELECT distributors.company_name, COUNT(specs.film_title) AS number_of_movies
FROM distributors
FULL JOIN specs ON specs.domestic_distributor_id = distributors.distributor_id
GROUP BY distributors.company_name
ORDER BY number_of_movies DESC;



-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, AVG(revenue.film_budget) AS avg_film_budget
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
GROUP BY distributors.company_name
ORDER BY avg_film_budget DESC
LIMIT 5;


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT COUNT(specs.movie_id)
FROM specs
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
WHERE distributors.headquarters NOT LIKE '%CA%'
----------------------
SELECT specs.film_title,distributors.company_name,distributors.headquarters, rating.imdb_rating
FROM specs
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN rating ON specs.movie_id = rating.movie_id
WHERE distributors.headquarters NOT LIKE '%CA%'

ANSWER: Dirty Dancing - 7.0

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT specs.film_title, AVG(rating.imdb_rating), specs.length_in_min
FROM specs
RIGHT JOIN rating ON specs.movie_id = rating.movie_id
GROUP BY specs.film_title, specs.length_in_min
ORDER BY specs.length_in_min DESC

-- ANSWER: Movies longer than 2 hours have the highest avg rating

SELECT specs.film_title, AVG(rating.imdb_rating), specs.length_in_min
FROM specs
RIGHT JOIN rating ON specs.movie_id = rating.movie_id
GROUP BY specs.film_title, specs.length_in_min, rating.imdb_rating
ORDER BY rating.imdb_rating DESC, specs.length_in_min DESC


SELECT AVG(rating.imdb_rating), specs.length_in_min
FROM specs
RIGHT JOIN rating ON specs.movie_id = rating.movie_id
WHERE specs.length_in_min > 120
GROUP BY specs.length_in_min, rating.imdb_rating
ORDER BY rating.imdb_rating DESC, specs.length_in_min DESC

SELECT AVG(rating.imdb_rating), specs.length_in_min
FROM specs
RIGHT JOIN rating ON specs.movie_id = rating.movie_id
WHERE specs.length_in_min < 120
GROUP BY specs.length_in_min, rating.imdb_rating
ORDER BY rating.imdb_rating DESC, specs.length_in_min DESC
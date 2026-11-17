--VERSION AS OF 11-16
CREATE TABLE game_dataset (
    name            varchar(100) CONSTRAINT name_key PRIMARY KEY,  
    primary_genre   varchar(30),                                   
    rating          numeric(3,2),                                  
    ratings_count   integer,                                       
    release_year    smallint,                                      
    metacritic      numeric(4,1),                                 
    playtime        integer,                                       
    genre_count     smallint,                                      
    game_type       varchar(20),                                  
    platform_count  smallint,                                      
    pc              boolean,                                       
    console         boolean,                                       
    mobile          boolean,                                       
    esrb_rating     varchar(20)                                    
);

COPY game_dataset
    FROM '/Users/risha/OneDrive/Documents/INST123/Project/game_dataset.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM game_dataset; -- I used this to test results

CREATE TABLE action_games AS
SELECT name,
       release_year,
       esrb_rating,
       game_type,
       pc,
       console,
       mobile,
       metacritic,
       rating
FROM game_dataset
WHERE primary_genre = 'Action'
  AND release_year BETWEEN 2000 AND 2025;

SELECT * FROM action_games; -- Same as above, used this to test output

--Below are some queries that answers some of our proposed questions
--Note: Because of developer information is not included, most of our proposed questions cannot be answered

SELECT *
FROM action_games
ORDER BY rating DESC; -- This one answers "Which action video games have the highest user reviews?"

SELECT release_year,
       count(*) AS num_games
FROM action_games
GROUP BY release_year
ORDER BY release_year; -- This one answers "How many action games were released per year from 2000-2025?"


SELECT 'PC' AS platform, count(*) AS num_games FROM action_games WHERE pc
UNION ALL
SELECT 'Console', count(*) FROM action_games WHERE console
UNION ALL
SELECT 'Mobile', count(*) FROM action_games WHERE mobile
ORDER BY num_games DESC; -- This one answers "Which platform(s) support the most action video games?"
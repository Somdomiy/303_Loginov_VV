#!/bin/bash
chcp 65001

sqlite3 movies_rating.db < db_init.sql

echo "1. Найти все драмы, выпущенные после 2005 года, которые понравились женщинам (оценка не ниже 4.5). Для каждого фильма в этом списке вывести название, год выпуска и количество таких оценок."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "select movies.title, movies.year, count(rating) as ratings_count from movies join ratings on movies.id = ratings.movie_id join users on ratings.user_id = users.id where (users.gender = 'female' and instr(movies.genres, 'Drama') > 0 and movies.year > 2005 and rating >= 4.5) group by movies.id;"
echo " "

echo "2. Провести анализ востребованности ресурса - вывести количество пользователей, регистрировавшихся на сайте в каждом году. Найти, в каких годах регистрировалось больше всего и меньше всего пользователей."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "create view tmp as select substr(users.register_date, 0, 5) as year, count(users.id) as registrations_count from users group by year;"
sqlite3 movies_rating.db -box -echo "select * from tmp;" 
sqlite3 movies_rating.db -box -echo "select max(registrations_count) as max_count, year from tmp;"
sqlite3 movies_rating.db -box -echo "select min(registrations_count) as min_count, year from tmp;"
sqlite3 movies_rating.db -box -echo "drop view tmp;"
echo " "

echo "3. Найти все пары пользователей, оценивших один и тот же фильм. Устранить дубликаты, проверить отсутствие пар с самим собой. Для каждой пары должны быть указаны имена пользователей и название фильма, который они ценили."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "select u1.name as User1, u2.name as User2, movies.title from ratings r1 join ratings r2 on (r1.movie_id = r2.movie_id and r1.id > r2.id) join movies on r1.movie_id = movies.id join users u1 on r1.user_id = u1.id join users u2 on r2.user_id = u2.id order by movies.id limit 100;"
echo " "

echo "4. Найти 10 самых старых оценок от разных пользователей, вывести названия фильмов, имена пользователей, оценку, дату отзыва в формате ГГГГ-ММ-ДД."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "select movies.title, users.name, ratings.rating, date(ratings.timestamp, 'unixepoch') as rating_date from ratings join movies on movies.id = ratings.movie_id join users on users.id = ratings.user_id group by users.name order by rating_date limit 10"
echo " "

echo "5. Вывести в одном списке все фильмы с максимальным средним рейтингом и все фильмы с минимальным средним рейтингом. Общий список отсортировать по году выпуска и названию фильма. В зависимости от рейтинга в колонке 'Рекомендуем' для фильмов должно быть написано 'Да' или 'Нет'."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "create view tmp as select movies.title, movies.year, avg_rating FROM movies join (select ratings.movie_id, AVG(ratings.rating) AS avg_rating FROM ratings group by ratings.movie_id) ratings on ratings.movie_id=movies.id;"
sqlite3 movies_rating.db -box -echo "select title, year, avg_rating, case when max_rating = avg_rating then 'Yes' else 'No' end as recommendation from (select *, MAX(avg_rating) OVER() as max_rating, MIN(avg_rating) over() AS min_rating from tmp) where avg_rating = max_rating or avg_rating = min_rating order by year, title;"
sqlite3 movies_rating.db -box -echo "drop view tmp;"
echo " "

echo "6. Вычислить количество оценок и среднюю оценку, которую дали фильмам пользователи-мужчины в период с 2011 по 2014 год."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "select count(*) as ratings_count, round(avg(ratings.rating), 3) as average_rating from ratings join users on ratings.user_id = users.id where users.gender = 'male' and date(timestamp, 'unixepoch') >= '2011-01-01' and date(timestamp, 'unixepoch') <= '2013-12-31';"
echo " "

echo "7. Составить список фильмов с указанием средней оценки и количества пользователей, которые их оценили. Полученный список отсортировать по году выпуска и названиям фильмов. В списке оставить первые 20 записей."
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "select title, year, round(avg(ratings.rating), 3) as average_rating, count(*) as ratings_count from movies join ratings on movies.id = ratings.movie_id group by movie_id order by movies.year, movies.title limit 20;"
echo " "

echo "8. Определить самый распространенный жанр фильма и количество фильмов в этом жанре"
echo "--------------------------------------------------"
sqlite3 movies_rating.db -box -echo "select genre, max(number_of_movies) from (with divided_genres(genre, combined_genres) as (select null, genres from movies union all select case when instr(combined_genres, '|') = 0 then combined_genres else substr(combined_genres, 1, instr(combined_genres, '|') - 1) end, case when instr(combined_genres, '|') = 0 then null else substr(combined_genres, instr(combined_genres, '|') + 1) end from divided_genres where combined_genres is not null) select genre, count(*) as number_of_movies from divided_genres where genre is not null group by genre);"
echo " "
pause
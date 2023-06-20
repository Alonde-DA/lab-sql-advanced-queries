-- List each pair of actors that have worked together.
select concat(a1.first_name, " ", a1.last_name) as "Actor 1", concat(a2.first_name, " ", a2.last_name) as "Actor 2", film.title
from actor a1
join actor a2 
on a1.actor_id <> a2.actor_id
join film_actor f1
on a1.actor_id = f1.actor_id
join film_actor f2
on a2.actor_id = f2.actor_id
join film 
on film.film_id = f1.film_id;

-- For each film, list actor that has acted in more films.

select f.film_id, a.first_name, a.last_name, COUNT(*) as film_count
from film f
join film_actor fa 
on f.film_id = fa.film_id
join actor a 
on fa.actor_id = a.actor_id
group by f.film_id, a.first_name, a.last_name
having COUNT(*) = (
select MAX(film_count)
from ( 
select f.film_id, COUNT(*) 
as film_count
from film f
join film_actor fa 
on f.film_id = fa.film_id
join actor a 
on fa.actor_id = a.actor_id
group by f.film_id
) as counts
where counts.film_id = f.film_id
);
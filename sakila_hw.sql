use sakila;

select *
from actor;

-- 1a. Display the first and last names of all actors from the table actor.
select first_name, last_name
from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters.
-- Name the column Actor Name.
select concat(first_name, " ", last_name) as "Actor Name"
from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, 
-- of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters GEN:
select actor_id, first_name, last_name
from actor
where last_name like "%gen%";

-- 2c. Find all actors whose last names contain the letters LI.
-- This time, order the rows by last name and first name, in that order:
select last_name, first_name
from actor
where last_name like "%li%";

-- 2d. Using IN, display the country_id and country columns of the
-- following countries: Afghanistan, Bangladesh, and China:
select country_id, country
from country
where country in ("Afghanistan", "Bangladesh", "China");

-- 3a. You want to keep a description of each actor. You don't think you will be performing
-- queries on a description, so create a column in the table actor named description and use
-- the data type BLOB (Make sure to research the type BLOB, as the difference between it and
-- VARCHAR are significant).
alter table actor
add description blob;
select *
from actor;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort.
-- Delete the description column.
alter table actor
drop description;

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name)
from actor
group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name,
-- but only for names that are shared by at least two actors.
select last_name, count(last_name)
from actor
group by last_name
having count(last_name)>1;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS.
-- Write a query to fix the record.
select actor_id, first_name, last_name
from actor
where first_name = "Groucho" and last_name = "Williams";

update actor
set first_name = "Harpo"
where actor_id = "172";

select actor_id, first_name, last_name
from actor
where actor_id = "172";

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO.
-- It turns out that GROUCHO was the correct name after all! In a single query,
-- if the first name of the actor is currently HARPO, change it to GROUCHO.
update actor
set first_name = "GROUCHO"
where first_name = "Harpo" and Last_name = "WILLIAMS";

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
show create table address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member.
-- Use the tables staff and address:
select s.first_name, s.last_name, a.address
from staff s
inner join address a on s.address_id = a.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005.
-- Use tables staff and payment.
select s.first_name, s.last_name, sum(p.amount) as revenue
from staff s
inner join payment p on s.staff_id = p.staff_id
where month(p.payment_date) = 8 and year(p.payment_date) = 2005
group by s.first_name, s.last_name;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film.
-- Use inner join.
--PRACTICE JOINS

SELECT *
FROM invoice 
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99

SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
FROM invoice
JOIN customer ON invoice.customer_id = customer.customer_id

SELECT customer.first_name, customer.last_name,
employee.first_name, employee.last_name
FROM customer
JOIN employee
ON customer.support_rep_id = employee.employee_id

SELECT album.title, artist.name
FROM album
JOIN artist ON album.artist_id = artist.artist_id

SELECT playlist_track.track_id
FROM playlist_track
JOIN playlist
ON playlist.playlist_id = playlist_track.playlist_id
WHERE playlist.name = 'Music'

SELECT track.name
FROM track 
JOIN playlist_track ON playlist_track.track_id = t.track_id
WHERE playlist_track.playlist_id = 5

SELECT track.name, playlist.name
FROM track
JOIN playlist_track
ON track.track_id = playlist_track.track_id
JOIN playlist 
ON playlist_track.playlist_id = playlist.playlist_id

SELECT track.name, album.title
FROM track
JOIN album
ON track.album_id = album.album_id
JOIN genre 
ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk'


--PRACTICE NESTED QUERIES
SELECT * FROM invoice
WHERE invoice_id in
(SELECT invoice_id FROM invoice_line 
 WHERE unit_price > 0.99)

 SELECT * FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id FROM playlist
 WHERE name = 'Music')

SELECT name
FROM track
WHERE track_id IN
(SELECT track_id FROM playlist_track 
 WHERE playlist_id = 5)

 SELECT * FROM track
WHERE genre_id IN 
(SELECT genre_id FROM genre
 WHERE name = 'Comedy')
 
 SELECT * FROM track
 WHERE album_id IN
 (SELECT album_id FROM album
  WHERE title = 'Fireball')

SELECT * FROM track
WHERE album_id IN
(SELECT album_id FROM album WHERE artist_id IN (
  SELECT artist_id FROM artist WHERE name = 'Queen')
 )

--PRACTICE UPDATING ROWS
UPDATE customer 
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett'

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (
  SELECT genre_id FROM genre WHERE name = 'Metal') 
AND composer IS NULL

-- GROUP BY
SELECT COUNT(*), genre.name
FROM track
JOIN genre
ON track.genre_id = genre.genre_id
GROUP BY genre.name;

SELECT COUNT(*), genre.name
FROM track
JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name

SELECT artist.name, COUNT(*)
FROM album
JOIN artist
ON artist.artist_id = album.artist_id
GROUP BY artist.name

-- USE DISTINCT
SELECT DISTINCT composer
FROM track

SELECT DISTINCT billing_postal_code
FROM invoice

SELECT DISTINCT company
FROM customer

--DELETE ROWS
DELETE
FROM practice_delete
WHERE type = 'bronze'

DELETE 
FROM practice_delete
WHERE type = 'silver'

DELETE
FROM practice_delete
WHERE value = 150

--ECOMM SIM
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(200),
  email VARCHAR(200)
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(200),
  email VARCHAR(200)
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  product_id INTEGER REFERENCES products(products_id),
  quantity INTEGER
);

INSERT INTO users (
  name, 
  email
)

VALUES 
('Izzy', 'iz@hotmail.com'),
('Chris', 'cbabs@gmail.com'),
('Cora', 'coracora@yahoo.com');

INSERT INTO product (
  name, 
  price
)

VALUES 
('BMW M4', 75000),
('Jeep', 60000),
('Subaru', 45000);

INSERT INTO orders (product_id)
VALUES 
(1),
(2),
(3); 

SELECT * FROM product 
JOIN orders
ON product.id = orders.product_id 
WHERE orders.id = 1;
  
SELECT * FROM product
JOIN orders
ON porduct.id = orders.product_id 
  
SELECT sum(product.price) 
FROM orders  
JOIN product 
ON orders.product_id = product.id;

ALTER TABLE orders
ADD column user_id INT 
REFERENCES users(id)

UPDATE orders 
SET user_id = 1
WHERE orders.id = 1

UPDATE orders 
SET user_id = 2
WHERE orders.id = 2

UPDATE orders 
SET user_id = 3
WHERE orders.id = 3

SELECT * FROM users
JOIN orders
ON users.id = orders.user_id 

SELECT users.name, COUNT(orders.id)
FROM orders
JOIN users
ON users.id = orders.user_id 
GROUP BY users.name
-- set timezone = 'Asia/Saigon';
-- We have to set timezone before select the column field data type timezone 
-- Genereate uuid (random id)
-- create database if not  exists shop_pet;

-- select to_char(created_at, 'YYYY/MM/dd HH24:MI:SS') from users;
-- Resources: https://www.postgresql.org/docs/current/functions-formatting.html

-- Get number of table in database
-- Cmd: select count(*) from information_schema.tables where table_schema = 'public';

/*

Description: 11 total number of tables in the database right away.

*/

-- use shop_pet;

create extension if not exists "uuid-ossp";

-- ENUM
create type role_enum as enum ('ADMIN', 'USER');
create type unit_product_enum as enum ('lb', 'bag', 'kg');
create type type_money_enum as enum ('USD', 'VND');

create table if not exists users (
    id uuid default uuid_generate_v4(),
    username varchar(45) not null,
    password char(60) not null,
    email varchar(45),
    phone varchar(20) default null,
    avatar_url varchar(200),
    gg_id varchar(50) default null,
    fb_id varchar(50) default null,
    role role_enum default 'USER' not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    primary key(id)
);

-- Need decoded password -> throw error if the password did not encode (security by spring boot)
insert into users (id, username, avatar_url, email, password, role) values 
('5c98778f-692f-4c94-a564-cb45662bfe41', 'thangphan', 'https://images-na.ssl-images-amazon.com/images/S/influencer-profile-image-prod/logo/influencer-275f68b5_1662012947804_original._CR0,3,576,576_._FMjpg_.jpeg', 'thangphan@gmail.com', '$2a$10$UVAD4O3IGOS0q1Ak1mmgp.6SdpUPQDzpukLkWAJ/akg9HprTVtEVO','ADMIN');


create table if not exists products (
  id serial,
  title VARCHAR(150),
  body text not null,
  price real not null,
  image_url varchar(100) not null,
  money_type type_money_enum default 'USD' not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(title),
  primary key(id)
);

insert into products (title, body, price, image_url, money_type) values
  ('Grand Canyon Hiking Tour', 'Experience the breathtaking beauty of the Grand Canyon with our guided hiking tour. Explore the stunning landscapes and enjoy spectacular views.', 250.00, 'https://example.com/grand-canyon-hiking.jpg', 'USD'),
  ('Zion National Park Adventure', 'Discover the wonders of Zion National Park with our thrilling adventure tour. Hike through majestic canyons and see incredible natural formations.', 350.00, 'https://example.com/zion-national-park.jpg', 'USD'),
  ('New England Foliage Tour', 'Experience the stunning fall foliage of New England with our guided tour. See the vibrant colors of the changing leaves and enjoy the charm of historic towns.', 450.00, 'https://example.com/new-england-foliage.jpg', 'USD'),
  ('Niagara Falls Boat Tour', 'Get up close and personal with the awe-inspiring Niagara Falls on our boat tour. Feel the mist on your face and marvel at the power of nature.', 150.00, 'https://example.com/niagara-falls-boat.jpg', 'USD'),
  ('Alaska Glacier Cruise', 'Embark on an unforgettable cruise through the glaciers of Alaska. See breathtaking scenery and abundant wildlife, including whales, sea lions, and eagles.', 750.00, 'https://example.com/alaska-glacier-cruise.jpg', 'USD'),
  ('New York City Walking Tour', 'Explore the city that never sleeps on foot with our expert guides. See famous landmarks and hidden gems while learning about the history and culture of New York.', 50.00, 'https://example.com/new-york-walking-tour.jpg', 'USD'),
  ('San Francisco Bike Tour', 'Discover the beauty of San Francisco on two wheels with our guided bike tour. Ride across the Golden Gate Bridge and see stunning views of the city.', 100.00, 'https://example.com/san-francisco-bike-tour.jpg', 'USD'),
  ('Las Vegas Nightlife Tour', 'Experience the excitement of Las Vegas at night with our guided tour. Visit the hottest clubs and bars and dance the night away.', 200.00, 'https://example.com/las-vegas-nightlife-tour.jpg', 'USD'),
  ('New Orleans Food Tour', 'Taste the flavors of New Orleans with our culinary tour. Sample Cajun and Creole dishes and learn about the history of the city cuisine.', 75.00, 'https://example.com/new-orleans-food-tour.jpg', 'USD'),
  ('Hawaii Volcano Tour', 'Witness the power of nature with our volcano tour in Hawaii. See active volcanoes and lava flows while learning about the geology of the islands.', 500.00, 'https://example.com/hawaii-volcano-tour.jpg', 'USD'),
  ('Washington D.C. Monuments Tour', 'Discover the history and significance of the monuments and memorials in our nation capital with our expert guides. See the Lincoln Memorial, Washington Monument, and more.', 40.00, 'https://example.com/washington-dc-monuments-tour.jpg', 'USD'),
  ('Yellowstone Wildlife Safari', 'Go on a safari through the wilderness of Yellowstone National Park with our experienced guides. See bears, wolves, bison, and more in their natural habitat.', 600.00, 'https://example.com/yellowstone-wildlife-safari.jpg', 'USD');

create table if not exists reviews (
  id serial,
  product_id serial,
  user_id uuid,
  title text not null,
  body text not null,
  rating integer not null check (rating between 1 and 5),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key(id),
  constraint fk_reviews_product foreign key(product_id) references products(id) on delete cascade,
  constraint fk_reviews_user foreign key(user_id) references users(id) on delete cascade
);


insert into reviews (product_id, user_id, title, body, rating) values 
(1, '5c98778f-692f-4c94-a564-cb45662bfe41', 'Great product!', 'I love this product. It works really well and looks great too.', 5),
(2, '5c98778f-692f-4c94-a564-cb45662bfe41', 'Not what I expected', 'This product did not meet my expectations. It was difficult to use and did not work as advertised.', 2),
(3, '5c98778f-692f-4c94-a564-cb45662bfe41', 'Good value for the price', 'This product is a great value for the price. It works well and is very affordable.', 4);

create table if not exists product_images (
  id serial,
  product_id integer not null,
  image_url varchar(255) not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (id),
  constraint fk_product_images_product foreign key(product_id) references products(id) on delete set null
);

INSERT INTO product_images (product_id, image_url) VALUES
  (1, 'https://picsum.photos/500'),
  (1, 'https://picsum.photos/501'),
  (2, 'https://picsum.photos/502'),
  (2, 'https://picsum.photos/503'),
  (3, 'https://picsum.photos/504'),
  (3, 'https://picsum.photos/505'),
  (4, 'https://picsum.photos/506'),
  (4, 'https://picsum.photos/507'),
  (5, 'https://picsum.photos/508'),
  (5, 'https://picsum.photos/509');

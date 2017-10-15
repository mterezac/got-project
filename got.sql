DROP TABLE IF EXISTS seasons cascade;
CREATE TABLE seasons (
  season_number integer PRIMARY KEY
);

CREATE TYPE gender AS ENUM ('f', 'm');

DROP TABLE IF EXISTS characters cascade;
CREATE TABLE characters (
  id SERIAL PRIMARY KEY, -- character id
  first_name text NOT NULL,
  last_name text,
  nickname text NULL, -- other name character is known
  character_gender gender
);

DROP TABLE IF EXISTS episodes cascade;
CREATE TABLE episodes (
  id SERIAL PRIMARY KEY, -- episodes unique identifier
  name text, -- episode name
  air_date date NULL, -- date episode was boradcast, NULL for season 8
  grade decimal, -- episode's grade
  runtime integer, -- the length of time
  episode_number integer NOT NULL, -- episode number
  season_number integer NOT NULL,
  FOREIGN KEY (season_number) REFERENCES seasons(season_number) -- no action on delete
);

DROP TABLE IF EXISTS actors cascade;
CREATE TABLE actors (
  id SERIAL PRIMARY KEY, -- actor primary KEY
  first_name text NOT NULL,
  last_name text NOT NULL,
  actor_gender gender,
  character_id integer NOT NULL,
  FOREIGN KEY (character_id) REFERENCES characters(id) -- no action on delete
);

DROP TABLE IF EXISTS regions cascade;
CREATE TABLE regions (
  name text PRIMARY KEY
);

DROP TABLE IF EXISTS houses cascade;
CREATE TABLE houses (
  name text PRIMARY KEY,
  founder text,
  region_name text NOT NULL,
  FOREIGN KEY (region_name) REFERENCES regions(name) -- no action on delete
);

DROP TABLE IF EXISTS wars cascade;
CREATE TABLE wars (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  start_date text NOT NULL, -- text type because it is another notion of time
  end_date text NULL -- if ongoing no end date
);

DROP TABLE IF EXISTS directors cascade;
CREATE TABLE directors (
  id SERIAL PRIMARY KEY,
  first_name text,
  last_name text
);

DROP TABLE IF EXISTS writers cascade;
CREATE TABLE writers (
  id SERIAL PRIMARY KEY,
  first_name text,
  last_name text
);

DROP TABLE IF EXISTS directed_by cascade;
CREATE TABLE directed_by (
  director_id integer NOT NULL,
  episode_id integer NOT NULL,
  PRIMARY KEY (director_id, episode_id),
  FOREIGN KEY (director_id) REFERENCES directors(id), -- no action on delete
  FOREIGN KEY (episode_id) REFERENCES episodes(id) -- no action on delete
);

DROP TABLE IF EXISTS written_by cascade;
CREATE TABLE written_by (
  writer_id integer NOT NULL,
  episode_id integer NOT NULL,
  PRIMARY KEY (writer_id, episode_id),
  FOREIGN KEY (writer_id) REFERENCES writers(id), -- no action on delete
  FOREIGN KEY (episode_id) REFERENCES episodes(id) -- no action on delete
);

DROP TABLE IF EXISTS performed_by cascade;
CREATE TABLE performed_by (
  episode_id integer NOT NULL,
  actor_id integer NOT NULL,
  PRIMARY KEY (episode_id, actor_id),
  FOREIGN KEY (episode_id) REFERENCES episodes(id), -- no action on delete
  FOREIGN KEY (actor_id) REFERENCES actors(id) -- no action on delete
);

DROP TABLE IF EXISTS house_by_birth cascade;
CREATE TABLE house_by_birth (
  house_name text,
  character_id integer,
  PRIMARY KEY (house_name, character_id),
  FOREIGN KEY (house_name) REFERENCES houses(name), -- no action on delete
  FOREIGN KEY (character_id) REFERENCES characters(id) -- no action on delete
);

DROP TABLE IF EXISTS deaths cascade;
CREATE TABLE deaths (
  character_id integer PRIMARY KEY,
  episode_id integer NULL,
  war_id integer NULL,
  FOREIGN KEY (character_id) REFERENCES characters(id),
  FOREIGN KEY (war_id) REFERENCES wars(id),
  FOREIGN KEY (episode_id) REFERENCES episodes(id)
);

CREATE TYPE combatants_type AS ENUM ('royalist', 'rebel', 'neutral');

DROP TABLE IF EXISTS war_participants cascade;
CREATE TABLE war_participants (
  character_id integer NOT NULL,
  war_id integer NOT NULL,
  type combatants_type NOT NULL,
  PRIMARY KEY (character_id, war_id),
  FOREIGN KEY (character_id) REFERENCES characters(id), -- no action on delete
  FOREIGN KEY (war_id) REFERENCES wars(id) -- no action on delete
);

DROP TABLE IF EXISTS war_regions cascade;
CREATE TABLE war_regions (
  war_id integer NOT NULL,
  region_name text NOT NULL,
  start_date text NOT NULL, -- text type because it is another notion of time
  end_date text NULL, -- if ongoing no  end date. start date in the given region
  PRIMARY KEY (war_id, region_name),
  FOREIGN KEY (war_id) REFERENCES wars(id), -- no action on delete
  FOREIGN KEY (region_name) REFERENCES regions(name) -- no action on delete
);

DROP TABLE IF EXISTS primary_relationship cascade;
CREATE TABLE primary_relationship (
  first_character_id integer NOT NULL,
  second_character_id integer NOT NULL,
  type text NOT NULL,
  PRIMARY KEY (first_character_id, second_character_id),
  FOREIGN KEY (first_character_id) REFERENCES characters(id), -- no action on delete
  FOREIGN KEY (second_character_id) REFERENCES characters(id), -- no action on delete
  CHECK (first_character_id < second_character_id)
);

INSERT INTO seasons (season_number) VALUES (1);
INSERT INTO seasons (season_number) VALUES (2);
INSERT INTO seasons (season_number) VALUES (3);
INSERT INTO seasons (season_number) VALUES (4);
INSERT INTO seasons (season_number) VALUES (5);
INSERT INTO seasons (season_number) VALUES (6);
INSERT INTO seasons (season_number) VALUES (7);
INSERT INTO seasons (season_number) VALUES (8);

INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Dragon and the Wolf', '2017-08-27', 9.6, 4800, 7, 7);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Pointy End', '2011-06-05', 9, 3540, 8, 1);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('Garden of Bones', '2012-04-22', 8.8, 3060, 4, 2);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
        VALUES ('Mhysa', '2013-06-09', 9.1, 3780, 10, 3);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('First of His Name', '2014-05-04', 8.8, 3180, 5, 4);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Wars to Come', '2015-04-12', 8.5, 3180, 1, 5);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('Battle of the Bastards', '2016-06-19', 9.9, 3600, 9, 6);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Spoils of War', '2017-08-06', 9.8, 3000, 4, 7);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('A Golden Crown', '2011-05-22', 9.2, 3180, 6, 1);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('Unbowed, Unbent, Unbroken', '2015-05-17', 8.1, 3240, 6, 5);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('Baelor', '2011-06-12', 9.6, 3420, 9, 1);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Rains of Castamere', '2013-06-02', 9.9, 3060, 9, 3);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('You Win or You Die', '2011-05-29', 9.3, 3480, 7, 1);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES('The Lion and the Rose', '2014-04-13', 9.7, 3120, 2, 4);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Winds of Winter', '2016-06-26', 9.9, 4080, 10, 6);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('The Ghost of Harrenhal', '2012-04-29', 8.9, 3300, 5, 2);
INSERT INTO episodes (name, air_date, grade, runtime, episode_number, season_number)
       VALUES ('Mother''s Mercy', '2015-06-14', 9, 3600, 10, 5);


INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Tyrion', 'Lannister', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Jaime', 'Lannister', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Cersei', 'Lannister', NULL, 'f');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Daenerys', 'Targaryen', 'khaleesi', 'f');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Eddard', 'Stark', 'Ned', 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Catelyn', 'Stark', NULL, 'f');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Petyr', 'Baelish', 'Littlefinger', 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Jon', 'Snow', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Davos', 'Seaworth', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Robert', 'Baratheon', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Joffrey', 'Baratheon', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Margaery', 'Tyrell', NULL, 'f');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Loras', 'Tyrell', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Renly', 'Baratheon', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Stannis', 'Baratheon', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Robb', 'Stark', NULL, 'm');
INSERT INTO characters (first_name, last_name, nickname, character_gender)
       VALUES ('Talisa', 'Stark', NULL, 'f');

INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Peter', 'Dinklage', 'm', 1);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Nikolaj', 'Coster-Waldau', 'm', 2);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Lena', 'Headey', 'f', 3);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Emilia', 'Clarke', 'f', 4);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Aidan', 'Gillen', 'm', 7);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Kit', 'Harington', 'm', 8);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Liam', 'Cunningham', 'm', 9);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Sean', 'Bean', 'm', 5);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
        VALUES ('Mark', 'Addy', 'm', 10);
INSERT INTO actors (first_name, last_name, actor_gender, character_id)
       VALUES ('Michelle', 'Fairley', 'f', 6);

INSERT INTO directors (first_name, last_name)
 		VALUES ('David', 'Benioff');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Daniel', 'Weiss');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Miguel', 'Sapochnik');
INSERT INTO directors (first_name, last_name)
 		VALUES ('David', 'Nutter');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Jeremy', 'Podeswa');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Michelle', 'MacLaren');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Alik', 'Sakharov');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Alan', 'Taylor');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Jack', 'Bender');
INSERT INTO directors (first_name, last_name)
 		VALUES ('Mark', 'Mylod');
INSERT INTO directors (first_name, last_name)
     VALUES ('Daniel', 'Minahan');
INSERT INTO directors (first_name, last_name)
     VALUES ('David', 'Petrarca');
INSERT INTO directors (first_name, last_name)
     VALUES ('Michael', 'Slovis');
INSERT INTO directors (first_name, last_name)
     VALUES ('Matt', 'Shakman');

INSERT INTO writers (first_name, last_name)
 		VALUES ('David', 'Benioff');
INSERT INTO writers (first_name, last_name)
 		VALUES ('Dave', 'Hill');
INSERT INTO writers (first_name, last_name)
 		VALUES ('Daniel', 'Weiss');
INSERT INTO writers (first_name, last_name)
 		VALUES ('Bryan', 'Cogman');
INSERT INTO writers (first_name, last_name)
 		VALUES ('George', 'Martin');
INSERT INTO writers (first_name, last_name)
 		VALUES ('Jane', 'Espenson');
INSERT INTO writers (first_name, last_name)
 		VALUES ('Vanessa', 'Taylor');

INSERT INTO regions (name)
 		VALUES ('The North');
INSERT INTO regions (name)
 		VALUES ('Faith of the Seven');
INSERT INTO regions (name)
 		VALUES ('Dragonstone');
INSERT INTO regions (name)
 		VALUES ('The Reach');
INSERT INTO regions (name)
 		VALUES ('Iron Islands');
INSERT INTO regions (name)
 		VALUES ('The Riverlands');
INSERT INTO regions (name)
 		VALUES ('The Vale of Arryn');
INSERT INTO regions (name)
 		VALUES ('The Stormlands');
INSERT INTO regions (name)
 		VALUES ('Dorne');
INSERT INTO regions (name)
 		VALUES ('Narrow Sea');
INSERT INTO regions (name)
 		VALUES ('Westeros');
INSERT INTO regions (name)
       VALUES ('The Wall');

INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Stark', 'Bran the Builder', 'The North');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Lannister','Lann the Clever','Faith of the Seven');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Targaryen','Aegon I Targaryen','Dragonstone');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Tyrell','Not Known','The Reach');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Greyjoy','Not Known','Iron Islands');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Tully','Axel Tully','The Riverlands');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Arryn','Artys Arryn','The Vale of Arryn');
INSERT INTO houses (name, founder, region_name)
		VALUES ('House Baratheon','Orys Baratheon','The Stormlands');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Martell', 'Not Known', 'Dorne');
INSERT INTO houses (name, founder, region_name)
 		VALUES ('House Frey', 'Frey', 'The Riverlands');

INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Dance of the Dragons',	'129AL', '131Al');
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Conquest of Dorne','157AL', '161AL');
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Robert Rebellion', '280AL','282AL');
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Greyjoy Rebellion','289AL','289AL');
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('War of the Five Kings','298AL','303AL');
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Conflict Beyond the Wall','298AL','304AL');
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Great War','304AL', NULL);
INSERT INTO wars (name, start_date, end_date)
 		VALUES ('Daenerys Targaryen invasion of Westeros', '304AL','304AL');

INSERT INTO war_participants (character_id, war_id, type)
     VALUES (1, 3, 'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (1, 4, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (1, 5, 'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (2, 3, 'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (2, 4, 'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (2, 5, 'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (2, 7, 'royalist');
INSERT INTO war_participants (character_id, war_id, type)
       VALUES (2, 8, 'royalist');
INSERT INTO war_participants (character_id, war_id, type)
      VALUES (3, 3,  'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (3, 4,  'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (3, 5,  'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (3, 7,  'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (3, 8,  'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (4, 7,  'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (4, 8,  'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (5, 3, 'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (5, 4, 'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (6, 3,  'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (6, 4,  'royalist');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (6, 5,  'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (7, 3, 'neutral');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (7, 5, 'rebel' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (8, 3, 'rebel');
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (8, 4, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (8, 5, 'rebel' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (8, 6, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (8, 7, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (9, 3, 'rebel' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (9, 5, 'rebel' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (9, 6, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (9, 7, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (10, 3, 'royalist' );
INSERT INTO war_participants (character_id, war_id, type)
     VALUES (10, 5, 'royalist' );

INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (1, 'Westeros', '129AL', '131AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (2, 'Dorne', '157AL', '161AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (2, 'Westeros', '157AL', '161AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (3,'Westeros', '280AL', '282AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (4,'Iron Islands', '289AL', '289AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (5,'Westeros', '298AL', '303AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (6,'The Wall', '298AL', '304AL');
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (7,'Westeros', '304AL', NULL);
INSERT INTO war_regions (war_id, region_name, start_date, end_date)
     VALUES (8,'Westeros', '304AL', '304AL');

INSERT INTO directed_by (director_id, episode_id)
    VALUES (5,1);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (11,2);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (12,3);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (4,4);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (6,5);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (13,6);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (3,7);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (14,8);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (11,9);
INSERT INTO directed_by (director_id, episode_id)
     VALUES (5,10);

INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,1);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,1);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(5,2);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(7,3);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,4);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,4);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,5);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,5);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,6);
 INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,6);
 INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,7);
 INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,7);
 INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,8);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,8);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(6,9);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(1,9);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(3,9);
INSERT INTO written_by (writer_id, episode_id)
     VALUES(4,10);


INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Lannister', 1);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Lannister', 2);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Lannister', 3);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Targaryen', 4);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Stark', 5);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Stark', 6);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Targaryen', 8);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Baratheon', 9);
INSERT INTO house_by_birth (house_name, character_id)
       VALUES('House Baratheon', 10);

INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (5, 11, NULL);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (6, 12, 5);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (10, 13, NULL);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (11, 14, NULL);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (12, 15, NULL);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (13, 15, NULL);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (14, 16, NULL);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (15, 17, 5);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (16, 12, 5);
INSERT INTO deaths (character_id, episode_id, war_id)
       VALUES (17, 12, 5);

INSERT INTO primary_relationship(first_character_id, second_character_id, type)
        VALUES (1, 2, 'siblings');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (1, 3, 'siblings');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (2, 3, 'siblings');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (5, 6, 'married');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (6, 16, 'parent');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (16, 17, 'married');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (5, 16, 'parent');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (13, 14, 'lovers');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (12, 13, 'siblings');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (11, 12, 'divorced');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (5, 8, 'uncle');
INSERT INTO primary_relationship(first_character_id, second_character_id, type)
       VALUES (14, 15, 'siblings');

INSERT INTO performed_by (episode_id, actor_id)
      VALUES (1, 1);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (16, 1);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (16, 3);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (16, 10);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (16, 4);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (6, 1);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (6, 2);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (6, 3);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (6, 4);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (11, 8);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (11, 10);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (11, 2);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (11, 3);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (17, 1);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (17, 2);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (17, 3);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (17, 4);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (15, 1);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (15, 2);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (15, 3);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (15, 6);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (4, 1);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (4, 2);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (4, 3);
INSERT INTO performed_by (episode_id, actor_id)
      VALUES (4, 4);

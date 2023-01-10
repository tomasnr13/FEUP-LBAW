-----------------------------------------

-- DROP SCHEMA lbaw2241 CASCADE;

-- CREATE SCHEMA lbaw2241;

SET search_path TO lbaw2241;

-----------------------------------------


-----------------------------------------
-- Drop old schema
-----------------------------------------

DROP TABLE IF EXISTS banned_user CASCADE;
DROP TABLE IF EXISTS administrator CASCADE;
DROP TABLE IF EXISTS group_member CASCADE;
DROP TABLE IF EXISTS friend_request_notification CASCADE;
DROP TABLE IF EXISTS friend_request CASCADE;
DROP TABLE IF EXISTS friends CASCADE;
DROP TABLE IF EXISTS group_request CASCADE;
DROP TABLE IF EXISTS rating CASCADE;
DROP TABLE IF EXISTS comment_notification CASCADE;
DROP TABLE IF EXISTS comment CASCADE;
DROP TABLE IF EXISTS post CASCADE;
DROP TABLE IF EXISTS groups CASCADE;
DROP TABLE IF EXISTS authenticated_user CASCADE;

DROP TYPE IF EXISTS media_t;
DROP TYPE IF EXISTS reactions_t;
DROP DOMAIN IF EXISTS DATE_NOW;

DROP INDEX IF EXISTS post_by_author;
DROP INDEX IF EXISTS post_by_date;
DROP INDEX IF EXISTS post_comment;

-----------------------------------------
-- Types
-----------------------------------------

CREATE TYPE media_t AS ENUM ('Photo', 'Video', 'Text');

CREATE TYPE reactions_t AS ENUM ('smile', 'funny', 'sad');

CREATE DOMAIN DATE_NOW AS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP CHECK(VALUE <= CURRENT_TIMESTAMP);

-----------------------------------------
-- Tables
-----------------------------------------

CREATE TABLE authenticated_user (
  id SERIAL PRIMARY KEY,
  username TEXT NOT NULL,
  birth_date DATE NOT NULL CHECK(date_part('year', CURRENT_TIMESTAMP) - date_part('year', birth_date) >= 14),
  email TEXT NOT NULL CHECK(email LIKE '_%@_%.__%'),
  phone TEXT NOT NULL,
  bio TEXT,
  password TEXT NOT NULL,
  public BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE(email)
);

CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  id_group_owner INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  security BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE post (
  id SERIAL PRIMARY KEY,  
  id_author INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE,
  id_group INTEGER REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE,
  description TEXT NOT NULL,
  date_of_post DATE_NOW,
  type media_t NOT NULL
);


CREATE TABLE comment (
  id SERIAL PRIMARY KEY,
  id_comment_author INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE,
  id_post INTEGER NOT NULL REFERENCES post (id) ON UPDATE CASCADE ON DELETE CASCADE,
  description TEXT NOT NULL,
  date_of_post DATE_NOW
);

CREATE TABLE comment_notification (
  id SERIAL PRIMARY KEY, 
  id_comment INTEGER NOT NULL REFERENCES comment (id) ON UPDATE CASCADE ON DELETE CASCADE,
  description TEXT NOT NULL,
  date_of_notification DATE_NOW
);

CREATE TABLE rating (
  id SERIAL PRIMARY KEY, 
  id_rating_author INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_post INTEGER NOT NULL REFERENCES post (id) ON UPDATE CASCADE ON DELETE CASCADE, 
  liked BOOLEAN NOT NULL DEFAULT TRUE,
  type reactions_t NOT NULL,
  UNIQUE(id_rating_author, id_post)
);

CREATE TABLE group_request (
  id SERIAL PRIMARY KEY, 
  id_group INTEGER NOT NULL REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_user INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  date_of_request DATE_NOW,
  UNIQUE(id_group, id_user)
);

CREATE TABLE friends (
  id SERIAL PRIMARY KEY, 
  id_friend1 INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_friend2 INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE friend_request (
  id SERIAL PRIMARY KEY, 
  id_sender INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_receiver INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  date_of_request DATE_NOW,
  UNIQUE(id_sender, id_receiver),
  CHECK(id_sender != id_receiver)
);

CREATE TABLE friend_request_notification (
  id SERIAL PRIMARY KEY, 
  id_friend_request INTEGER NOT NULL REFERENCES friend_request (id) ON UPDATE CASCADE ON DELETE CASCADE,
  description TEXT NOT NULL,
  date_of_notification DATE_NOW
);

CREATE TABLE group_member (
  id_member INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_group INTEGER NOT NULL REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (id_member, id_group)
);

CREATE TABLE administrator (
  id_admin INTEGER PRIMARY KEY REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE
);
  
CREATE TABLE banned_user (
  id SERIAL PRIMARY KEY, 
  id_banned_user INTEGER NOT NULL REFERENCES authenticated_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_admin INTEGER NOT NULL REFERENCES administrator (id_admin) ON UPDATE CASCADE ON DELETE CASCADE, 
  ban_reason TEXT NOT NULL,
  date_of_ban DATE_NOW
);

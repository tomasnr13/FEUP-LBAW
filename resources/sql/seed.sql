CREATE SCHEMA IF NOT EXISTS lbaw2241;

SET search_path TO lbaw2241;

-----------------------------------------
-- Drop old schema
-----------------------------------------


DROP TABLE IF EXISTS administrators CASCADE;
DROP TABLE IF EXISTS group_members CASCADE;
DROP TABLE IF EXISTS friend_requests CASCADE;
DROP TABLE IF EXISTS friends CASCADE;
DROP TABLE IF EXISTS group_requests CASCADE;
DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS posts CASCADE;
DROP TABLE IF EXISTS groups CASCADE;
DROP TABLE IF EXISTS users CASCADE;

DROP TYPE IF EXISTS media_t;
DROP TYPE IF EXISTS reactions_t;
DROP DOMAIN IF EXISTS DATE_NOW;


-----------------------------------------
-- Types
-----------------------------------------

CREATE TYPE media_t AS ENUM ('Photo', 'Video', 'Text');

CREATE TYPE reactions_t AS ENUM ('smile', 'funny', 'sad');

CREATE DOMAIN DATE_NOW AS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-----------------------------------------
-- Tables
-----------------------------------------

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username TEXT NOT NULL,
  birth_date DATE NOT NULL CHECK(date_part('year', CURRENT_TIMESTAMP) - date_part('year', birth_date) >= 14),
  email TEXT NOT NULL CHECK(email LIKE '_%@_%.__%'),
  phone TEXT NOT NULL,
  bio TEXT,
  password TEXT NOT NULL,
  public BOOLEAN NOT NULL DEFAULT TRUE,
  remember_token TEXT,
  UNIQUE(email)
);

CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  id_group_owner INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  security BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE group_requests (
  id SERIAL PRIMARY KEY,
  id_group INTEGER NOT NULL REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  date_of_request DATE_NOW,
  UNIQUE(id_group, id_user)
);


CREATE TABLE group_members (
  id SERIAL PRIMARY KEY,
  id_member INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_group INTEGER NOT NULL REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  id_author INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  id_group INTEGER REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE,
  description TEXT NOT NULL,
  date_of_post DATE_NOW,
  type media_t NOT NULL
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  id_comment_author INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  id_post INTEGER NOT NULL REFERENCES posts (id) ON UPDATE CASCADE ON DELETE CASCADE,
  description TEXT NOT NULL,
  date_of_post DATE_NOW
);

CREATE TABLE ratings (
  id SERIAL PRIMARY KEY,
  id_rating_author INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_post INTEGER NOT NULL REFERENCES posts (id) ON UPDATE CASCADE ON DELETE CASCADE,
  liked BOOLEAN NOT NULL DEFAULT TRUE,
  type reactions_t NOT NULL,
  UNIQUE(id_rating_author, id_post)
);

CREATE TABLE administrators (
  id_admin INTEGER PRIMARY KEY REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE friends (
  id SERIAL PRIMARY KEY,
  id_friend1 INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_friend2 INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE friend_requests (
  id SERIAL PRIMARY KEY,
  id_sender INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  id_receiver INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
  date_of_request DATE_NOW,
  UNIQUE(id_sender, id_receiver),
  CHECK(id_sender != id_receiver)
);

INSERT INTO users (username,birth_date,email,phone,bio,password,public)
VALUES
  ('Burton James','Jul 5, 2003','james@burton.com','(544) 449-4357', 'I am a surfer, like to skate and extreme activities.','$2y$10$HfzIhGCCaxqyaIdGgjARSuOKAcm1Uy82YfLuNaajn6JrjLWy9Sj/W','No'),
  ('Hop Wooten','Mar 3, 2002','ultrices@hotmail.couk','1-678-889-3629', 'I am a singer for Norway, not very popular but trying to make a career',5531,'Yes'),
  ('Stacey Anderson','Jun 6, 2002','senectus@outlook.org','(856) 562-3491', 'Entrepeneur without a job, looking for my next business venture',1193,'Yes'),
  ('Brock Donovan','Oct 17, 2003','accumsan.interdum@google.com','1-680-784-0313', 'Actor for twenty years, played roles in popular sitcoms',9585,'No'),
  ('Kylan Valentine','Apr 7, 2003','ipsum.primis@icloud.org','(746) 864-6619', 'E sports legend, been gaming since forever and will be until I die',4664,'Yes'),
  ('Abigail Harvey','Jun 8, 2003','odio.etiam@icloud.net','1-757-335-7851','I come from Australia and enjoy various activities related to the see',9040,'No'),
  ('Kareem Sosa','Jul 10, 2003','ac@yahoo.edu','1-865-872-3594','Just one small positive thought in the morning can change your whole day.',9887,'No'),
  ('Lars Shepherd','Mar 28, 2003','aenean.egestas@aol.edu','1-667-561-3380', 'It is never too late to be what you might have been.',1683,'No'),
  ('Richard Cunningham','May 7, 2003','lobortis.quis.pede@google.ca','(312) 283-1799', 'Be yourself; everyone else is already taken.','$2y$10$HfzIhGCCaxqyaIdGgjARSuOKAcm1Uy82YfLuNaajn6JrjLWy9Sj/W','No'),
  ('Rhiannon Burt','Aug 31, 2003','felis.donec@aol.net','(104) 443-4131', 'Look, if you had one shot, Or one opportunity, To seize everything you ever wanted,One moment,Would you capture it, or just let it slip?',8167,'Yes');

INSERT INTO groups (id_group_owner,name,description,security)
VALUES
  (4,'Group1','consectetuer, cursus et,','Yes'),
  (7,'Group2','sit ame2,','No'),
  (10,'Group3','elit, pretium et, rutrum','No'),
  (2,'Group4','lorem semper auctor. Mauris','Yes'),
  (9,'Group5','sodales at,','Yes');

INSERT INTO group_members (id_member,id_group)
VALUES
  (4,4),
  (8,3),
  (9,2),
  (4,2),
  (6,2),
  (7,5),
  (6,1),
  (2,3),
  (5,5),
  (3,4),
  (10,3),
  (8,2),
  (9,1),
  (8,5),
  (4,5),
  (1,5);

INSERT INTO group_requests (id_group,id_user,date_of_request)
VALUES
  (4,8,'Dec 14, 2021'),
  (2,7,'May 27, 2023'),
  (3,9,'Feb 3, 2022'),
  (4,5,'Sep 5, 2023'),
  (3,7,'May 22, 2022'),
  (1,7,'Apr 7, 2022'),
  (4,10,'Aug 1, 2022'),
  (2,3,'Feb 4, 2023'),
  (1,8,'Jul 3, 2022'),
  (2,1,'Jan 8, 2022');

--put nulls in id_group
INSERT INTO posts (id_author,id_group,date_of_post,description,type)
VALUES
  (6,2,'May 8, 2021','pharetra ut, pharetra','Photo'),
  (5,1,'Apr 11, 2021','id, erat. Etiam vestibulum massa','Photo'),
  (1,3,'Oct 28, 2021','nulla at sem molestie sodales. Mauris blandit enim consequat','Photo'),
  (6,4,'Nov 28, 2021','dolor. Fusce feugiat. Lorem','Photo'),
  (7,1,'Jan 3, 2021','facilisis non,','Photo'),
  (9,5,'Oct 14, 2021','Nam interdum enim non nisi. Aenean eget','Photo'),
  (8,2,'Jul 8, 2021','dui quis accumsan convallis,','Photo'),
  (1,3,'Feb 14, 2021','congue turpis. In condimentum. Donec at','Photo'),
  (1,3,'Aug 29, 2021','ipsum. Curabitur consequat,','Video'),
  (7,3,'Dec 12, 2021','ligula. Nullam enim. Sed','Video'),
  (2,2,'Apr 12, 2021','mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris','Video'),
  (4,1,'Sep 23, 2022','Pellentesque','Video'),
  (2,2,'May 7, 2021','dis','Video'),
  (2,1,'Oct 10, 2022','Integer tincidunt aliquam arcu. Aliquam ultrices iaculis','Video'),
  (5,1,'Apr 15, 2021','volutpat ornare,','Video'),
  (9,2,'Nov 8, 2021','euismod','Video'),
  (8,4,'Dec 13, 2021','elit. Aliquam','Video'),
  (8,3,'Apr 30, 2022','odio. Phasellus at augue id ante dictum cursus.','Video'),
  (3,4,'Dec 23, 2021','velit. Cras lorem','Video'),
  (1,4,'Aug 31, 2021','egestas rhoncus. Proin nisl sem, consequat nec, mollis','Video');

INSERT INTO comments (id_comment_author,id_post,description,date_of_post)
VALUES
  (6,2,'Mauris quis turpis vitae purus gravida sagittis. Duis gravida.','Oct 18, 2023'),
  (8,2,'vel, mauris. Integer sem elit, pharetra ut,','Jul 3, 2022'),
  (5,12,'Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede.','Nov 10, 2022'),
  (1,10,'auctor velit. Aliquam nisl. Nulla eu','Jul 31, 2022'),
  (6,18,'felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus.','Jun 23, 2022'),
  (1,13,'faucibus id, libero.','Nov 22, 2022'),
  (8,13,'Duis ac arcu. Nunc mauris. Morbi non sapien','Mar 29, 2023'),
  (8,15,'Donec egestas. Duis ac arcu.','Mar 14, 2023'),
  (1,4,'quis, tristique ac, eleifend vitae, erat.','Jan 2, 2022'),
  (2,17,'ligula elit, pretium','Feb 3, 2022'),
  (2,12,'ut eros non enim commodo hendrerit. Donec porttitor tellus','Nov 1, 2022'),
  (3,5,'cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut,','Jan 15, 2023'),
  (10,4,'Morbi sit amet massa. Quisque porttitor eros nec tellus.','Jul 10, 2023'),
  (10,17,'diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est','Jul 4, 2022'),
  (10,12,'Donec egestas. Duis ac arcu. Nunc','Dec 9, 2021'),
  (5,13,'nec enim. Nunc ut erat. Sed nunc est,','Jun 8, 2022'),
  (10,10,'convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum','Feb 16, 2022'),
  (3,15,'suscipit nonummy. Fusce fermentum fermentum arcu.','Jan 3, 2023'),
  (8,15,'egestas. Sed pharetra, felis eget','Dec 14, 2021'),
  (10,10,'Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet','Jun 18, 2023');

INSERT INTO ratings (id_rating_author,id_post,liked,type)
VALUES
  (4,10,'Yes','smile'),
  (9,3,'Yes','smile'),
  (8,4,'Yes','funny'),
  (9,7,'Yes','funny'),
  (2,7,'Yes','sad'),
  (9,12,'Yes','smile'),
  (6,10,'Yes','funny'),
  (7,15,'Yes','sad'),
  (1,6,'Yes','sad'),
  (3,6,'No','smile'),
  (6,3,'Yes','smile'),
  (9,13,'Yes','funny'),
  (10,3,'Yes','funny'),
  (3,16,'Yes','sad'),
  (4,6,'Yes','sad'),
  (1,11,'Yes','smile'),
  (5,13,'Yes','sad'),
  (4,20,'No','sad'),
  (4,19,'Yes','sad'),
  (8,13,'Yes','smile'),
  (1,17,'Yes','sad'),
  (9,6,'Yes','funny'),
  (2,10,'Yes','sad'),
  (3,5,'Yes','smile'),
  (2,16,'Yes','funny'),
  (3,4,'Yes','smile'),
  (7,8,'Yes','funny'),
  (9,16,'Yes','sad'),
  (6,2,'Yes','funny'),
  (8,5,'No','funny');

INSERT INTO administrators (id_admin)
VALUES
  (8),
  (9);

INSERT INTO friends (id_friend1,id_friend2)
VALUES
  (5,7),
  (7,5),
  (10,4),
  (4,10),
  (6,5),
  (5,6),
  (2,5),
  (5,2),
  (9,4),
  (4,9),
  (7,10),
  (10,7),
  (4,8),
  (8,4),
  (3,10),
  (10,3),
  (1,5),
  (5,1),
  (3,6),
  (6,3),
  (4,7),
  (7,4),
  (2,4),
  (4,2),
  (1,8),
  (8,1);

INSERT INTO friend_requests (id_sender,id_receiver,date_of_request)
VALUES
  (10,5,'Apr 25, 2021'),
  (4,9,'Jul 2, 2021'),
  (2,8,'Mar 8, 2021'),
  (8,9,'Oct 13, 2021'),
  (7,5,'Jun 11, 2021'),
  (2,6,'Nov 30, 2021'),
  (10,9,'Feb 28, 2021'),
  (4,5,'Dec 7, 2021'),
  (7,6,'Jun 23, 2021'),
  (5,9,'Nov 11, 2021'),
  (3,2,'Aug 1, 2021'),
  (3,4,'Jan 8, 2021'),
  (9,5,'Nov 25, 2021'),
  (5,6,'Feb 6, 2021'),
  (6,8,'Aug 25, 2021'),
  (6,1,'Aug 25, 2021');

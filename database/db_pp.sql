DELETE FROM authenticated_user;
DELETE FROM groups;
DELETE from post;
DELETE from comment;
DELETE from comment_notification;
DELETE from rating;
DELETE from group_request;
DELETE from friends;
DELETE from friend_request;
DELETE from friend_request_notification;
DELETE from group_member;
DELETE from administrator;
DELETE from banned_user;


INSERT INTO authenticated_user (id,username,birth_date,email,phone,bio,password,public)
VALUES
  (1,'Burton James','Jul 5, 2023','enim.curabitur.massa@outlook.ca','(544) 449-4357', 'I am a surfer, like to skate and extreme activities.',3736,'No'),
  (2,'Hop Wooten','Mar 3, 2022','ultrices@hotmail.couk','1-678-889-3629', 'I am a singer for Norway, not very popular but trying to make a career',5531,'Yes'),
  (3,'Stacey Anderson','Jun 6, 2022','senectus@outlook.org','(856) 562-3491', 'Entrepeneur without a job, looking for my next business venture',1193,'Yes'),
  (4,'Brock Donovan','Oct 17, 2023','accumsan.interdum@google.com','1-680-784-0313', 'Actor for twenty years, played roles in popular sitcoms',9585,'No'),
  (5,'Kylan Valentine','Apr 7, 2023','ipsum.primis@icloud.org','(746) 864-6619', 'E sports legend, been gaming since forever and will be until I die',4664,'Yes'),
  (6,'Abigail Harvey','Jun 8, 2023','odio.etiam@icloud.net','1-757-335-7851','I come from Australia and enjoy various activities related to the see',9040,'No'),
  (7,'Kareem Sosa','Jul 10, 2023','ac@yahoo.edu','1-865-872-3594','Just one small positive thought in the morning can change your whole day.',9887,'No'),
  (8,'Lars Shepherd','Mar 28, 2023','aenean.egestas@aol.edu','1-667-561-3380', 'It is never too late to be what you might have been.',1683,'No'),
  (9,'Richard Cunningham','May 7, 2023','lobortis.quis.pede@google.ca','(312) 283-1799', 'Be yourself; everyone else is already taken.',5424,'No'),
  (10,'Rhiannon Burt','Aug 31, 2023','felis.donec@aol.net','(104) 443-4131', 'Look, if you had one shot, Or one opportunity, To seize everything you ever wanted,One moment,Would you capture it, or just let it slip?',8167,'Yes');

INSERT INTO groups (id,id_group_owner,name,description,security)
VALUES
  (1,4,'Group1','consectetuer, cursus et,','Yes'),
  (2,7,'Group2','sit ame2,','No'),
  (3,10,'Group3','elit, pretium et, rutrum','No'),
  (4,2,'Group4','lorem semper auctor. Mauris','Yes'),
  (5,9,'Group5','sodales at,','Yes');

--put nulls in id_group
INSERT INTO post (id,id_author,id_group,date_of_post,description,type)
VALUES
  (1,6,2,'May 8, 2023','pharetra ut, pharetra','Photo'),
  (2,5,1,'Apr 11, 2023','id, erat. Etiam vestibulum massa','Photo'),
  (3,1,3,'Oct 28, 2021','nulla at sem molestie sodales. Mauris blandit enim consequat','Photo'),
  (4,6,4,'Nov 28, 2022','dolor. Fusce feugiat. Lorem','Photo'),
  (5,7,1,'Jan 3, 2022','facilisis non,','Photo'),
  (6,9,5,'Oct 14, 2023','Nam interdum enim non nisi. Aenean eget','Photo'),
  (7,8,2,'Jul 8, 2022','dui quis accumsan convallis,','Photo'),
  (8,1,3,'Feb 14, 2023','congue turpis. In condimentum. Donec at','Photo'),
  (9,1,3,'Aug 29, 2022','ipsum. Curabitur consequat,','Video'),
  (10,7,3,'Dec 12, 2022','ligula. Nullam enim. Sed','Video'),
  (11,2,2,'Apr 12, 2023','mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris','Video'),
  (12,4,1,'Sep 23, 2022','Pellentesque','Video'),
  (13,2,2,'May 7, 2023','dis','Video'),
  (14,2,1,'Oct 10, 2022','Integer tincidunt aliquam arcu. Aliquam ultrices iaculis','Video'),
  (15,5,1,'Apr 15, 2023','volutpat ornare,','Video'),
  (16,9,2,'Nov 8, 2021','euismod','Video'),
  (17,8,4,'Dec 13, 2022','elit. Aliquam','Video'),
  (18,8,3,'Apr 30, 2022','odio. Phasellus at augue id ante dictum cursus.','Video'),
  (19,3,4,'Dec 23, 2021','velit. Cras lorem','Video'),
  (20,1,4,'Aug 31, 2023','egestas rhoncus. Proin nisl sem, consequat nec, mollis','Video');

INSERT INTO comment (id,id_comment_author,id_post,description,date_of_post)
VALUES
  (1,6,2,'Mauris quis turpis vitae purus gravida sagittis. Duis gravida.','Oct 18, 2023'),
  (2,8,2,'vel, mauris. Integer sem elit, pharetra ut,','Jul 3, 2022'),
  (3,5,12,'Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede.','Nov 10, 2022'),
  (4,1,10,'auctor velit. Aliquam nisl. Nulla eu','Jul 31, 2022'),
  (5,6,18,'felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus.','Jun 23, 2022'),
  (6,1,13,'faucibus id, libero.','Nov 22, 2022'),
  (7,8,13,'Duis ac arcu. Nunc mauris. Morbi non sapien','Mar 29, 2023'),
  (8,8,15,'Donec egestas. Duis ac arcu.','Mar 14, 2023'),
  (9,1,4,'quis, tristique ac, eleifend vitae, erat.','Jan 2, 2022'),
  (10,2,17,'ligula elit, pretium','Feb 3, 2022'),
  (11,2,12,'ut eros non enim commodo hendrerit. Donec porttitor tellus','Nov 1, 2022'),
  (12,3,5,'cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut,','Jan 15, 2023'),
  (13,10,4,'Morbi sit amet massa. Quisque porttitor eros nec tellus.','Jul 10, 2023'),
  (14,10,17,'diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est','Jul 4, 2022'),
  (15,10,12,'Donec egestas. Duis ac arcu. Nunc','Dec 9, 2021'),
  (16,5,13,'nec enim. Nunc ut erat. Sed nunc est,','Jun 8, 2022'),
  (17,10,10,'convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum','Feb 16, 2022'),
  (18,3,15,'suscipit nonummy. Fusce fermentum fermentum arcu.','Jan 3, 2023'),
  (19,8,15,'egestas. Sed pharetra, felis eget','Dec 14, 2021'),
  (20,10,10,'Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet','Jun 18, 2023');

INSERT INTO comment_notification (id,id_comment,description,date_of_notification)
VALUES
  (1,10,'eget, ipsum. Donec sollicitudin','Nov 9, 2022'),
  (2,10,'risus varius orci, in','May 13, 2023'),
  (3,6,'Duis ac arcu. Nunc mauris. Morbi non','Aug 24, 2022'),
  (4,11,'Fusce mollis. Duis','Jan 2, 2023'),
  (5,8,'hendrerit neque. In ornare sagittis felis.','Apr 25, 2022'),
  (6,7,'tristique ac, eleifend','May 14, 2023'),
  (7,14,'congue a, aliquet vel,','Sep 23, 2022'),
  (8,17,'sed consequat auctor, nunc nulla','Jul 18, 2022'),
  (9,7,'a mi fringilla mi lacinia','Sep 24, 2022'),
  (10,7,'elit erat vitae risus.','Feb 23, 2023'),
  (11,12,'orci, adipiscing non,','May 30, 2022'),
  (12,2,'Nunc ut erat. Sed nunc','Sep 12, 2022'),
  (13,11,'eu odio tristique pharetra. Quisque ac libero nec','Sep 9, 2023'),
  (14,4,'non, bibendum','Jun 23, 2022'),
  (15,12,'non,','Mar 18, 2023'),
  (16,11,'adipiscing elit. Curabitur sed tortor.','Aug 12, 2022'),
  (17,10,'fames ac turpis egestas.','Jun 17, 2023'),
  (18,18,'nec, cursus a,','May 28, 2023'),
  (19,13,'ornare sagittis felis. Donec tempor,','Jan 5, 2023'),
  (20,13,'ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci,','Mar 5, 2022');

INSERT INTO rating (id,id_rating_author,id_post,liked,type)
VALUES
  (1,4,10,'Yes','smile'),
  (2,9,3,'Yes','smile'),
  (3,8,4,'Yes','funny'),
  (4,9,7,'Yes','funny'),
  (5,2,7,'Yes','sad'),
  (6,9,12,'Yes','smile'),
  (7,6,10,'Yes','funny'),
  (8,7,15,'Yes','sad'),
  (9,1,6,'Yes','sad'),
  (10,3,6,'No','smile'),
  (11,6,3,'Yes','smile'),
  (12,9,13,'Yes','funny'),
  (13,10,3,'Yes','funny'),
  (14,3,16,'Yes','sad'),
  (15,4,6,'Yes','sad'),
  (16,1,11,'Yes','smile'),
  (17,5,13,'Yes','sad'),
  (18,4,20,'No','sad'),
  (19,4,19,'Yes','sad'),
  (20,8,13,'Yes','smile'),
  (21,1,17,'Yes','sad'),
  (22,9,6,'Yes','funny'),
  (23,2,10,'Yes','sad'),
  (24,3,5,'Yes','smile'),
  (25,2,16,'Yes','funny'),
  (26,3,4,'Yes','smile'),
  (27,7,8,'Yes','funny'),
  (28,9,16,'Yes','sad'),
  (29,6,2,'Yes','funny'),
  (30,8,5,'No','funny');

INSERT INTO group_request (id,id_group,id_user,date_of_request)
VALUES
  (1,4,8,'Dec 14, 2021'),
  (2,2,7,'May 27, 2023'),
  (3,3,9,'Feb 3, 2022'),
  (4,4,5,'Sep 5, 2023'),
  (5,3,7,'May 22, 2022'),
  (6,1,7,'Apr 7, 2022'),
  (7,4,10,'Aug 1, 2022'),
  (8,2,3,'Feb 4, 2023'),
  (9,1,8,'Jul 3, 2022'),
  (10,2,1,'Jan 8, 2022');

INSERT INTO friends (id_friend1,id_friend2)
VALUES
  (5,7),
  (10,4),
  (6,6),
  (2,5),
  (9,4),
  (7,10),
  (2,2),
  (4,8),
  (3,10),
  (1,5),
  (3,5),
  (4,7),
  (2,4),
  (10,3),
  (2,3);

INSERT INTO friend_request (id,id_sender,id_receiver,date_of_request)
VALUES
  (1,10,5,'Apr 25, 2023'),
  (2,4,9,'Jul 2, 2022'),
  (3,2,8,'Mar 8, 2023'),
  (4,8,9,'Oct 13, 2022'),
  (5,7,5,'Jun 11, 2023'),
  (6,2,6,'Nov 30, 2022'),
  (7,10,9,'Feb 28, 2022'),
  (8,4,4,'Dec 7, 2022'),
  (9,7,6,'Jun 23, 2022'),
  (10,5,9,'Nov 11, 2022'),
  (11,3,2,'Aug 1, 2022'),
  (12,3,3,'Jan 8, 2022'),
  (13,9,5,'Nov 25, 2022'),
  (14,5,6,'Feb 6, 2023'),
  (15,6,8,'Aug 25, 2023');

INSERT INTO friend_request_notification (id,id_friend_request,description,date_of_notification)
VALUES
  (1,11,'arcu iaculis enim, sit amet ornare lectus justo eu','Jan 19, 2022'),
  (2,8,'blandit mattis. Cras eget nisi dictum augue','Aug 15, 2023'),
  (3,4,'a, scelerisque sed, sapien.','Nov 19, 2022'),
  (4,13,'turpis. In condimentum.','Sep 18, 2022'),
  (5,10,'Cras dictum ultricies','Mar 26, 2023'),
  (6,4,'vehicula aliquet libero. Integer in magna. Phasellus','May 12, 2022'),
  (7,2,'sagittis. Nullam vitae diam. Proin','Sep 8, 2022'),
  (8,11,'Nunc sed orci lobortis augue scelerisque mollis. Phasellus','Nov 20, 2021'),
  (9,15,'vitae odio sagittis semper. Nam tempor diam dictum sapien.','Mar 4, 2023'),
  (10,15,'commodo tincidunt nibh. Phasellus nulla. Integer vulputate,','Sep 14, 2022'),
  (11,9,'dolor elit, pellentesque a, facilisis non, bibendum','Nov 22, 2022'),
  (12,12,'Nullam feugiat placerat','Aug 10, 2022'),
  (13,5,'nisi nibh lacinia orci,','Aug 26, 2023'),
  (14,14,'neque sed dictum eleifend, nunc','Mar 18, 2022'),
  (15,9,'diam lorem, auctor quis, tristique ac, eleifend vitae, erat.','Sep 2, 2023');

INSERT INTO group_member (id_member,id_group)
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
  (4,5);

INSERT INTO administrator (id_administrator)
VALUES
  (8),
  (9);

INSERT INTO banned_user (id,id_banned_user,id_admin,ban_reason,date_of_ban)
VALUES
  (1,6,8,'eget tincidunt dui augue eu tellus. Phasellus elit pede,','Jul 14, 2022'),
  (2,7,9,'non, luctus sit amet, faucibus ut,','Apr 24, 2023');
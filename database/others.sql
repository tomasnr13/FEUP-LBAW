-----------------------------------------
-- INDEXES
-----------------------------------------

CREATE INDEX post_by_author ON post USING hash (id_author);
CREATE INDEX post_by_date ON post USING btree (date_of_post);
CREATE INDEX post_comment ON comment USING hash (id_post);

-----------------------------------------
-- INDEXES FTS
-----------------------------------------

-- Add ts_vectors column to store the calculated tsvectors in the post table
ALTER TABLE post ADD COLUMN ts_vectors TSVECTOR;

-- Create a function to automatically calculate tsvector when a post is inserted/updated
CREATE OR REPLACE FUNCTION post_creation_update_tsvectors() RETURNS TRIGGER AS
$BODY$
DECLARE
	concat TEXT;
BEGIN
  SELECT string_agg(comment_desc, ' ') INTO concat FROM
  ( SELECT comment.description AS comment_desc FROM comment
  WHERE comment.id_post = NEW.id) AS comments_list;

  NEW.ts_vectors = setweight(to_tsvector('english', coalesce(NEW.description, '')), 'A') ||
  setweight(to_tsvector('english', coalesce(concat, '')), 'B');
  RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

-- Create a trigger before insert or update on post
CREATE TRIGGER post_insert_update_tsvectors
    BEFORE INSERT OR UPDATE ON post
    FOR EACH ROW
    EXECUTE PROCEDURE post_creation_update_tsvectors();

-- Create a function to automatically calculate tsvector when a comment is inserted/updated
CREATE OR REPLACE FUNCTION post_comment_creation_update_tsvectors() RETURNS TRIGGER AS
$BODY$
DECLARE
	concat TEXT;
	post_desc TEXT;
BEGIN
  SELECT string_agg(comment_desc, ' ') INTO concat FROM
  ( SELECT comment.description AS comment_desc FROM comment
  WHERE comment.id_post = NEW.id_post) AS comments_list;

  SELECT CONCAT (NEW.description, ' ', concat) INTO concat;

  SELECT string_agg(description, ' ') INTO post_desc FROM post
  WHERE post.id = NEW.id_post;

  UPDATE post
  SET ts_vectors = setweight(to_tsvector('english', coalesce(post_desc, '')), 'A') ||
  setweight(to_tsvector('english', coalesce(concat, '')), 'B')
  WHERE id = NEW.id_post;

  RETURN NEW;
END

$BODY$
LANGUAGE plpgsql;

-- Create a trigger before insert or update on comment
CREATE TRIGGER post_insert_update_tsvectors
    BEFORE INSERT OR UPDATE ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE post_comment_creation_update_tsvectors();


-- Create a GiST index on the ts_vectors column
CREATE INDEX post_search_index ON post USING GiST (ts_vectors);

-------------------------------------------------------------------------------

-- Add ts_vectors column to store the calculated tsvectors in the authenticated_user table
ALTER TABLE authenticated_user ADD COLUMN ts_vectors TSVECTOR;

-- Create a function to automatically calculate tsvector
CREATE OR REPLACE FUNCTION authenticated_user_tsvectors() RETURNS TRIGGER AS
$BODY$
BEGIN
  NEW.ts_vectors = setweight(to_tsvector('english', coalesce(NEW.username, '')), 'A') ||
  setweight(to_tsvector('english', coalesce(NEW.bio)), 'B');
  RETURN NEW;
END

$BODY$
LANGUAGE plpgsql;

-- Create a trigger before insert or update on authenticated_user
CREATE TRIGGER authenticated_user_tsvectors
    BEFORE INSERT OR UPDATE ON authenticated_user
    FOR EACH ROW
    EXECUTE PROCEDURE authenticated_user_tsvectors();

-- Create a GiST index on the ts_vectors column
CREATE INDEX user_search_index ON authenticated_user USING GiST (ts_vectors);


-----------------------------------------
-- TRIGGERS
-----------------------------------------

--Trigger 1: friend cant send friend requests to  his friends

CREATE FUNCTION exc_friend_request() RETURNS TRIGGER AS
$BODY$
BEGIN
  IF EXISTS (SELECT * FROM friends WHERE (NEW.id_friend1 = id_friend1 AND NEW.id_friend2 = id_friend2)
   OR (NEW.id_friend1 = id_friend2 AND NEW.id_friend2 = id_friend1)) THEN
      RAISE EXCEPTION 'The friendship relation already exists';
  END IF;
  RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER trig_friend_request
  BEFORE INSERT OR UPDATE ON friend_request
  FOR EACH ROW
  EXECUTE PROCEDURE exc_friend_request();

--Trigger 2: A group owner cannot send a group request to other group members

CREATE FUNCTION exc_group_request() RETURNS TRIGGER AS
$BODY$
BEGIN
  IF EXISTS (SELECT * FROM group_member WHERE NEW.id_user = id_member) THEN
      RAISE EXCEPTION 'An owner cannot send a group request to the group members.';
  END IF;
  RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER trig_group_request
  BEFORE INSERT OR UPDATE ON group_request
  FOR EACH ROW
  EXECUTE PROCEDURE exc_group_request();

--Trigger 3: An admin cannot ban other admins

CREATE FUNCTION exc_ban_admin() RETURNS TRIGGER AS
$BODY$
BEGIN
  IF EXISTS (SELECT * FROM administrator WHERE NEW.id_banned_user = id_admin) THEN
      RAISE EXCEPTION 'An administrator cannot be banned';
  END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER trig_ban_admin
  BEFORE INSERT OR UPDATE ON banned_user
  FOR EACH ROW
  EXECUTE PROCEDURE exc_ban_admin();

--Trigger 4: Create friend request notification

CREATE FUNCTION create_fr_notification() RETURNS TRIGGER AS
$BODY$
BEGIN
  INSERT INTO friend_request_notification(id_friend_request, description)
  VALUES (NEW.id_friend_request, 'You got a new friend request!');
  RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER friend_notification
  AFTER INSERT OR UPDATE ON friend_request
  FOR EACH ROW
  EXECUTE PROCEDURE create_fr_notification();

--Trigger 5: Create comment notification

CREATE FUNCTION create_c_notification() RETURNS TRIGGER AS
$BODY$
BEGIN
  INSERT INTO comment_notification(id_commentt, description)
  VALUES (NEW.id_comment, 'You got a new comment!');
  RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER comment_notification
  AFTER INSERT OR UPDATE ON comment
  FOR EACH ROW
  EXECUTE PROCEDURE create_c_notification();

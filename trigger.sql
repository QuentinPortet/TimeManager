DROP TRIGGER IF EXISTS clocks_trig on clocks;
DROP FUNCTION IF EXISTS clocks_to_worktime;

CREATE FUNCTION clocks_to_worktime() RETURNS trigger AS $clocks_to_worktime$
	BEGIN 
		IF ( (SELECT COUNT(*) FROM clocks) > 2) THEN
			RETURN NULL;
		END IF;
		IF (NEW.status != (SELECT status from clocks where user_id = NEW.user_id ORDER BY inserted_at DESC LIMIT 1)) THEN
			INSERT INTO workingtimes VALUES ((select id from workingtimes ORDER BY inserted_at DESC LIMIT 1) + 1, NEW.time, (SELECT time from clocks where user_id = NEW.user_id ORDER BY inserted_at DESC LIMIT 1), NEW.user_id, NOW(), NOW());
			RETURN NEW;
		END IF;
		RETURN NEW;
	END;


$clocks_to_worktime$ LANGUAGE plpgsql;
		


CREATE TRIGGER clocks_trig BEFORE INSERT OR UPDATE ON clocks
	FOR EACH ROW EXECUTE PROCEDURE clocks_to_worktime();
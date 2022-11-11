---------------------------------------------------------------------------

-----------------------------
-- Inheritance:
--	A table can inherit from zero or more tables.  A query can reference
--	either all rows of a table or all rows of a table plus all of its
--	descendants.
-----------------------------

-- For example, the capitals table inherits from cities table. (It inherits
-- all data fields from cities.)

CREATE TABLE cities (
	name		text,
	population	float8,
	altitude	int		-- (in ft)
);

CREATE TABLE capitals (
	state		char(2)
) INHERITS (cities);

-- Now, let's populate the tables.
INSERT INTO cities VALUES ('San Francisco', 7.24E+5, 63);
INSERT INTO cities VALUES ('Las Vegas', 2.583E+5, 2174);
INSERT INTO cities VALUES ('Mariposa', 1200, 1953);
INSERT INTO cities VALUES ('New York', 8.4E+5, 68);
INSERT INTO cities VALUES ('Los Angels', 3.583E+5, 2174);
INSERT INTO cities VALUES ('Columbus', 1800, 1983);
INSERT INTO cities VALUES ('New Jersy', 9.24E+5, 83);
INSERT INTO cities VALUES ('Capetown', 2.583E+5, 2174);
INSERT INTO cities VALUES ('Delhi', 18760, 1953);
INSERT INTO cities VALUES ('Moraco', 8.24E+5, 63);
INSERT INTO cities VALUES ('Kolkata', 2.583E+5, 2174);
INSERT INTO cities VALUES ('Chennai', 1200, 1953);
INSERT INTO cities VALUES ('Hyderabad', 7.24E+5, 63);
INSERT INTO cities VALUES ('Bangalore', 2.583E+5, 2174);
INSERT INTO cities VALUES ('Vijayawada', 1200, 1953);


INSERT INTO capitals VALUES ('Sacramento', 3.694E+5, 30, 'CA');
INSERT INTO capitals VALUES ('Madison', 1.913E+5, 845, 'WI');
INSERT INTO capitals VALUES ('Austria', 3.694E+5, 30, 'CA');
INSERT INTO capitals VALUES ('Swizerland', 1.913E+5, 845, 'WI');
INSERT INTO capitals VALUES ('Greenland', 3.694E+5, 30, 'CA');
INSERT INTO capitals VALUES ('Australia', 1.913E+5, 845, 'WI');
INSERT INTO capitals VALUES ('Neazland', 3.694E+5, 30, 'CA');
INSERT INTO capitals VALUES ('Sydney', 1.913E+5, 845, 'WI');
INSERT INTO capitals VALUES ('Hong kong', 3.694E+5, 30, 'CA');
INSERT INTO capitals VALUES ('Singapore', 1.913E+5, 845, 'WI');
INSERT INTO capitals VALUES ('India', 3.694E+5, 30, 'CA');

SELECT * FROM cities;
SELECT * FROM capitals;

-- You can find all cities, including capitals, that
-- are located at an altitude of 500 ft or higher by:

SELECT c.name, c.altitude
FROM cities c
WHERE c.altitude > 500;

-- To scan rows of the parent table only, use ONLY:

SELECT name, altitude
FROM ONLY cities
WHERE altitude > 500;


-- clean up (you must remove the children first)
DROP TABLE capitals;
DROP TABLE cities;
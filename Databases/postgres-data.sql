-- create table syntax for postgres
CREATE TABLE new_table_name ( table_column_title TYPE_OF_DATA column_constraints, next_column_title 
TYPE_OF_DATA column_constraints, table_constraint table_constraint ) 
INHERITS existing_table_to_inherit_from;

CREATE TABLE pg_equipment ( equip_id serial PRIMARY KEY, type varchar (50) NOT NULL, 
color varchar (25) NOT NULL, location varchar(25) 
check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')), 
install_date date );
-- \d
-- How to Change Table Data in PostgreSQL

ALTER TABLE table_name Action_TO_Take;
ALTER TABLE pg_equipment ADD COLUMN functioning bool;
ALTER TABLE

-- \d pg_equipment
ALTER TABLE pg_equipment ALTER COLUMN functioning SET DEFAULT 'true';
ALTER TABLE pg_equipment ALTER COLUMN functioning SET NOT NULL;
ALTER TABLE pg_equipment RENAME COLUMN functioning TO working_order;
ALTER TABLE pg_equipment DROP COLUMN working_order;
ALTER TABLE pg_equipment RENAME TO playground_equip;

-- Deleting Tables in PostgreSQL
DROP TABLE playground_equip;
DROP TABLE
DROP TABLE IF EXISTS playground_equip;



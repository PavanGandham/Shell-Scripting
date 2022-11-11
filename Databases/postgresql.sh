#!/bin/bash

# How To Install and Use PostgreSQL on Ubuntu 20.04
# https://www.tecmint.com/install-postgresql-and-pgadmin-in-ubuntu/

#Step 1 — Installing PostgreSQL
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service

#Step 2 — Using PostgreSQL Roles and Databases
#Switching Over to the postgres Account
sudo -i -u postgres
# psql
# \q
#Accessing a Postgres Prompt Without Switching Accounts
sudo -u postgres psql

#Step 3 — Creating a New Role
createuser --interactive
sudo -u postgres createuser --interactive

#Output
# Enter name of role to add: sammy
# Shall the new role be a superuser? (y/n) y

# Step 4 — Creating a New Database
createdb sammy
sudo -u postgres createdb sammy

# Step 5 — Opening a Postgres Prompt with the New Role
sudo adduser sammy
sudo -i -u sammy
psql
sudo -u sammy psql
psql -d postgres

# \conninfo
# Output
# You are connected to database "sammy" as user "sammy" via socket in "/var/run/postgresql" at port "5432".

# Step 6 — Creating and Deleting Tables
# CREATE TABLE table_name (
#     column_name1 col_type (field_length) column_constraints,
#     column_name2 col_type (field_length),
#     column_name3 col_type (field_length)
# );
CREATE TABLE playground (
    equip_id serial PRIMARY KEY,
    type varchar (50) NOT NULL,
    color varchar (25) NOT NULL,
    location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')),
    install_date date
);

# \d
# Output
#                   List of relations
#  Schema |          Name           |   Type   | Owner 
# --------+-------------------------+----------+-------
#  public | playground              | table    | sammy
#  public | playground_equip_id_seq | sequence | sammy
# (2 rows)

# \dt
# Output
#           List of relations
#  Schema |    Name    | Type  | Owner 
# --------+------------+-------+-------
#  public | playground | table | sammy
# (1 row)

# Step 7 — Adding, Querying, and Deleting Data in a Table
INSERT INTO playground (type, color, location, install_date) VALUES ('slide', 'blue', 'south', '2017-04-28');
INSERT INTO playground (type, color, location, install_date) VALUES ('swing', 'yellow', 'northwest', '2018-08-16');

SELECT * FROM playground;
# Output
#  equip_id | type  | color  | location  | install_date 
# ----------+-------+--------+-----------+--------------
#         1 | slide | blue   | south     | 2017-04-28
#         2 | swing | yellow | northwest | 2018-08-16
# (2 rows)

DELETE FROM playground WHERE type = 'slide';
SELECT * FROM playground;
# Output
#  equip_id | type  | color  | location  | install_date 
# ----------+-------+--------+-----------+--------------
#         2 | swing | yellow | northwest | 2018-08-16
# (1 row)

# Step 8 — Adding and Deleting Columns from a Table
ALTER TABLE playground ADD last_maint date;
SELECT * FROM playground;
# Output
#  equip_id | type  | color  | location  | install_date | last_maint 
# ----------+-------+--------+-----------+--------------+------------
#         2 | swing | yellow | northwest | 2018-08-16   | 
# (1 row)

ALTER TABLE playground DROP last_maint;

# Step 9 — Updating Data in a Table
UPDATE playground SET color = 'red' WHERE type = 'swing';
SELECT * FROM playground;
# Output
#  equip_id | type  | color | location  | install_date 
# ----------+-------+-------+-----------+--------------
#         2 | swing | red   | northwest | 2018-08-16
# (1 row)


# Postgresql Data Directory /var/lib/postgresql/12/main
# Configurations files are stored in the /etc/postgresql/12/main directory
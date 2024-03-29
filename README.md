
# Salon Appointment Scheduler

## Project Goal
Build a Salon Appointment Scheduler using Bash nd PostgreSQL database. <br/>
:copyright: [freeCodeCamp](https://www.freecodecamp.org/learn/relational-database/) Relational Database Course  <br/>

Check the code here... [salon.sh](salon.sh)


## Complete the tasks below

**1. Connect to your psql server:** <br/> 
- You should create a database named salon
~~~~~~~~~~~~~~~~~~~~
  CREATE DATABASE salon;
~~~~~~~~~~~~~~~~~~~~

- You should connect to your database, then create tables named `customers`, `appointments` , and `services`
~~~~~~~~~~~~~~~~~~~~
  \c salon 
  CREATE TABLE customers(); 
  CREATE TABLE appointments(); 
  CREATE TABLE services();
~~~~~~~~~~~~~~~~~~~~

- Each table should have a primary key column that automatically increments <br/>
- Each primary key column should follow the naming convention, `table_name_id`. For example, the customers table should have a `customer_id` key. <br/>
  Note that there’s no s at the end of customer. <br/>
~~~~~~~~~~~~~~~~~~~~
ALTER TABLE customers ADD COLUMN customer_id SERIAL PRIMARY KEY; 
ALTER TABLE appointments ADD COLUMN appointment_id SERIAL PRIMARY KEY;
ALTER TABLE services ADD COLUMN service_id SERIAL PRIMARY KEY;
~~~~~~~~~~~~~~~~~~~~

- Your appointments table should have a customer_id foreign key that references the customer_id column from the customers table
~~~~~~~~~~~~~~~~~~~~  
ALTER TABLE appointments ADD COLUMN customer_id INT NOT NULL; 
ALTER TABLE appointments ADD FOREIGN KEY(customer_id) REFERENCES customers(customer_id);
~~~~~~~~~~~~~~~~~~~~

- Your appointments table should have a service_id foreign key that references the service_id column from the services table
~~~~~~~~~~~~~~~~~~~~
ALTER TABLE appointments ADD COLUMN service_id INT NOT NULL  REFERENCES services(service_id);
~~~~~~~~~~~~~~~~~~~~

- Your customers table should have phone that is a VARCHAR and must be unique
~~~~~~~~~~~~~~~~~~~~
ALTER TABLE customers ADD COLUMN phone VARCHAR(15) UNIQUE;
~~~~~~~~~~~~~~~~~~~~

- Your customers and services tables should have a name column
~~~~~~~~~~~~~~~~~~~~
ALTER TABLE customers ADD COLUMN name VARCHAR(40);
ALTER TABLE services ADD COLUMN name VARCHAR(40);
~~~~~~~~~~~~~~~~~~~~

- Your appointments table should have a time column that is a VARCHAR
~~~~~~~~~~~~~~~~~~~~
ALTER TABLE appointments ADD COLUMN time VARCHAR(10);
~~~~~~~~~~~~~~~~~~~~

- You should have at least three rows in your services table for the different services you offer, one with a service_id of 1
~~~~~~~~~~~~~~~~~~~~
INSERT INTO services(name) 
VALUES ('cut'), 
       ('color'),
       ('perm'),
       ('style'),
       ('trim'),
       ('spa');
~~~~~~~~~~~~~~~~~~~~


**2. Split your terminal into a Bash terminal:** <br/>
- You should create a script file named salon.sh in the project folder
~~~~~~~~~~~~~~~~~~~~
touch salon.sh
~~~~~~~~~~~~~~~~~~~~

- Your script file should have a “shebang” that uses bash when the file is executed (use `#! /bin/bash`) <br/>
- Your script file should have executable permissions
~~~~~~~~~~~~~~~~~~~~
chmod +x salon.sh
~~~~~~~~~~~~~~~~~~~~

- You should not use the clear command in your script
- You should display a numbered list of the services you offer before the first prompt for input, each with the format #) <service>. 
  For example, 1) cut, where 1 is the service_id
<br/>

**More ...**

- If you pick a service that doesn't exist, you should be shown the same list of services again

- Your script should prompt users to enter a `service_id`, `phone numbe`r, a `name` if they aren’t already a customer, and a `time`.  <br/>
  You should use read to read these inputs into variables named `SERVICE_ID_SELECTED`, `CUSTOMER_PHONE`, `CUSTOMER_NAME`, and `SERVICE_TIME`

- If a phone number entered doesn’t exist, you should get the customers name and enter it, and the phone number, into the customers table

- You can create a row in the appointments table by running your script and entering `1, 555-555-5555, Fabio, 10:30 ` at each request for input if that phone number isn’t in the customers table. 
  The row should have the customer_id for that customer, and the `service_id` for the service entered

- You can create another row in the appointments table by running your script and entering `2, 555-555-5555, 11am` at each request for input if that phone number is already in the customers table. 
  The row should have the `customer_id` for that customer, and the `service_id` for the service entered

- After an appointment is successfully added, you should output the message `'I have put you down for a <service> at <time>, <name>'`. 
  For example, if the user chooses cut as the service, 10:30 is entered for the time, and their name is Fabio in the database the output would be 
  `'I have put you down for a cut at 10:30, Fabio.'` <br/>
  Make sure your script finishes running after completing any of the tasks above, or else the tests won't pass.

  <br/>

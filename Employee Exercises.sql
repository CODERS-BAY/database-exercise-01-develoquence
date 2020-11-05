SELECT * FROM employees;
SELECT first_name, last_name FROM employees;
SELECT last_name FROM employees ORDER BY  last_name ASC;
SELECT DISTINCT manager_id FROM employees;
SELECT first_name, last_name FROM employees WHERE manager_id = 100;
SELECT country_name FROM countries;
SELECT city, country_id FROM locations;
SELECT job_title, job_id FROM jobs ORDER BY job_title ASC;
SELECT DISTINCT location_id FROM  departments;


SELECT max(salary), job_id FROM employees
GROUP BY job_id;

SELECT min(salary), job_id FROM employees
GROUP BY job_id;

SELECT avg(salary), job_id FROM employees
GROUP BY job_id;

SELECT round(salary) AS "Gerundets Gehalt", job_id FROM employees
GROUP BY job_id;

SELECT count(*) FROM regions;

SELECT length(first_name), first_name FROM employees;
SELECT lcase(first_name), first_name FROM employees;
SELECT ucase(first_name), first_name FROM employees;

SELECT concat(first_name, ' ', last_name) AS "Name" FROM employees;
SELECT concat_ws(',', first_name, last_name) AS "Name" FROM employees;
SELECT hire_date FROM employees WHERE hire_date < now();

SELECT first_name, last_name FROM employees WHERE first_name LIKE 'K%';
SELECT first_name, last_name FROM employees WHERE first_name <> 'Peter' AND first_name <> 'Eleni';
SELECT first_name, last_name FROM employees WHERE salary > 10000;
SELECT department_id FROM departments WHERE location_id  = 1700;
SELECT first_name, last_name, phone_number FROM employees WHERE phone_number LIKE '%121%';

SELECT min(salary), department_id FROM employees GROUP BY department_id;


/* Übung 6 */

-- 1
SELECT employee_id, CONCAT(first_name, ' ', last_name) as Name, job_id, hire_date AS "STARTDATE" FROM employees ORDER BY employee_id;
-- 2
SELECT DISTINCT job_id FROM employees;
-- 3
SELECT employee_id AS "Emp#", last_name AS Employee, job_id AS "Job", hire_date AS start_date FROM employees ORDER BY employee_id;
-- 4
SELECT last_name, salary from employees WHERE salary > 12000;
-- 5
SELECT last_name, department_id from employees WHERE employee_id = 176;
-- 6
SELECT last_name, job_id, hire_date from employees ORDER BY hire_date ASC;
-- 7
SELECT last_name, department_id FROM employees WHERE department_id = 20 ORDER BY last_name ASC;
-- 8
SELECT UCASE(last_name) AS Employee, salary AS monthly_salary, CONCAT(ROUND(commission_pct*100), '%') AS Comisson FROM employees WHERE commission_pct = 0.2;

-- 201023

SELECT start_date, end_date from job_history where employee_id = 143;
SELECT last_name, department_id from employees where salary < 4.000;
SELECT CONCAT (last_name, ' ', first_name) AS name, 'Wohlverdiener' from employees WHERE salary>(1000*12);
SELECT manager_id from employees WHERE hire_date > '1991-01-01-' AND hire_date < '1998-12-31'; -- alle zwischen 1991 und 1998
SELECT manager_id from employees WHERE hire_date LIKE '1991%'; -- alle aus den 90er Jahren

-- JOIN

SELECT e.last_name, d.department_name
FROM employees e -- e steht jetzt für employees
JOIN departments d -- d steht jetzt für departments
ON e.department_id = d.department_id;

-- Übung Folien

SELECT d.department_name, l.postal_code, l.city, c.country_name
-- SELECT * = alles anzeigen
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
JOIN countries c
ON l.country_id = c.country_id;

# Liste mit allen Nachnamen der Mitarbeiter und den Namen des Managers
SELECT CONCAT(e.first_name, ' ', e.last_name) as Mitarbeiter, m.last_name as Manager
FROM employees e
JOIN employees m-- wird gehandhabt wie weitere Tabelle
ON e.manager_id = m.employee_id;

-- Übung 07

-- 1
SELECT j.job_title, SUM(e.salary) FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
GROUP BY e.job_id ORDER BY SUM(e.salary) DESC;

-- 2
SELECT AVG(salary) AS Durschnittsgehalt
from employees;

-- 3
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- 4
SELECT d.department_name, l.postal_code, l.city, l.street_address, l.state_province
FROM departments d
JOIN locations l
ON d.location_id = l.location_id;

-- 5
SELECT d.department_name, l.postal_code, l.city, l.street_address, l.state_province, c.country_name
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
JOIN countries c
ON c.country_id = l.country_id;

-- 6
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Manager, d.department_name,l.postal_code, l.city, l.state_province, l.street_address, c.country_name
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
JOIN countries c
ON c.country_id = l.country_id
JOIN employees e
ON d.manager_id = e.employee_id;

-- 7
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name, j.job_title AS Job, e.salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN jobs j;

-- 8
SELECT CONCAT(m.first_name, ' ', m.last_name), CONCAT(e.first_name, ' ', e.last_name)
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id;

-- alle Mitarbeiter, die in Europa arbeiten
SELECT last_name, region_name FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
JOIN countries c
ON l.country_id = c.country_id
JOIN regions r
ON c.region_id = r.region_id
WHERE region_name = 'Europe';

-- alle Mitarbeiter, die den Manager 'Steven King' haben
SELECT m.last_name as Manager, CONCAT(e.first_name, ' ', e.last_name) as Unterstellter FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE m.last_name = 'King';

/* UPDATE

   UPDATE table_name
   SET column1 = value, column2 = value
   WHERE condition;
 */

-- Region ID von Deutschland umstellen
SELECT * from countries;

UPDATE countries
SET region_id = 2
WHERE country_name = 'Germany';

-- Vornamen von Steven King in John ändern
SELECT * from employees
WHERE first_name= 'Steven';

UPDATE employees
SET first_name = 'John'
WHERE first_name='Steven' AND last_name='King';

-- Alle mit einem Gehalt unter 6000 bekommen eine Gehaltserhöhung um 100 Euro
UPDATE employees
SET salary = salary + 100
WHERE salary < 6000;

-- Alle mit einem Gehalt über 6000 bekommen eine Gehaltserhöhung von 50 Euro
UPDATE employees
SET salary = salary + 50
WHERE salary >= 6000;

-- Die Telefonnummer von Bruce ändert sich auf: 590.444.4568
UPDATE employees
SET phone_number = '590.444.4568'
WHERE first_name = 'Bruce';

-- Matos wechselt die Abteilung zu den Sales Representatives
UPDATE employees
SET job_id = (SELECT job_id from jobs
WHERE job_title = 'Sales Representative') -- Verschachtelung, eher vermeiden
WHERE last_name = 'Matos';

/*
besser und einfacher:

UPDATE employees
SET job_id = 'SA_REP'
WHERE last_name = 'Matos;

*/

-- Das min.Gehalt von allen Jobs erhöht sich um 500, jedoch nicht beim Präsidenten
SELECT j.job_id, min_salary from employees
JOIN jobs j on employees.job_id = j.job_id;

UPDATE jobs
SET min_salary = min_salary + 500
WHERE job_title <> 'President';

-- Shelley Higgins wird Manager von Contracting
SELECT department_name, manager_id FROM departments
WHERE department_name = 'Contracting';

UPDATE departments
SET manager_id = 205
WHERE department_name = 'Contracting';
/*
UPDATE departments
SET manager_id = (SELECT employee_id FROM employees WHERE first_name='Shelley' AND last_name='Higgins')
WHERE department_name = 'Contracting';
*/

-- Peter Vargas erhält zukünftig eine Provision von 15%
SELECT last_name, commission_pct FROM employees
WHERE last_name = 'Vargas';

UPDATE employees
SET commission_pct = 0.15
WHERE first_name = 'Peter' AND last_name = 'Vargas';

-- Der Standort in Seattle ändert seine Adresse zu: 113 Cherry St
SELECT street_address, city from locations
WHERE city = 'Seattle';

UPDATE locations
SET street_address = '113 Cherry St'
WHERE city = 'Seattle';

/* INSERT INTO

   INSERT INTO tablename(att1, att2, att3) VALUES ('value1', 'value2', ('value3');

 */

 -- neuen Standort hinzufügen
SELECT * from locations;
INSERT INTO countries (country_id, country_name, region_id) VALUES ('AT', 'AUSTRIA', 1);
INSERT INTO locations(location_id, street_address, postal_code, city, state_province, country_id) VALUES (2600, 'Holzstr 15', '4020', 'Linz', 'OÖ', 'DE'), (2700, 'Mitterberg 46', '8962', 'Gröbming', 'STMK', 'AT');

UPDATE locations
SET country_id='AT'
WHERE location_id=2600;

DELETE FROM locations
WHERE location_id=2600;

-- neuen Mitarbeiter anlegen 207
SELECT * from employees;

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (207, 'Martina', 'Giselbrecht', 'MGISELBRECHT', '699.106.0201', '2020-10-30', 'IT_PROG', 50000.00, 0.20, 103, 60 );

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (208, 'Andreas', 'Maringer', 'andreaslmar2018@gmail.com', '0676 39 66 326', '2000-01-01', 'SA_MAN', 10000, 0.15, 205, 90);

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (209,'Aleksandar','Kolic','kolicaleksandar90','0667764355147','2020-12-01','SA_REP',4600,null,null,null);

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (211, 'John', 'Rambo', 'john.rambo@gmx.de', '111222333','1982-06-06', 'SA_MAN', 10, 0.9, 205, 110);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (210, 'Max', 'Powers', 'MPWRS', '011.444.1844.479265', '1996-12-11', 'SA_MAN', 15000.00, 0.20, 100, 80);


/* CREATE TABLE
   ALTER TABLE
 */

CREATE DATABASE diary;
USE diary;
/*
 DIARYUSER -- nicht nur USER verwenden, sonst kann es  zu Verwechslungen kommen
 user_name varchar(30) NOT NULL
 user_id int auto_increment (Datenbank zählt von selbst nach oben, bei künstlich erzeugten IDs immer verwenden) NOT NULL
 birthdate date

 ENTRY
 entry_id int NOT NULL
 user_id (FK) int NOT NULL
 text text
 date date DEFAULT CURRENT_DATE (automatisch als Default-Wert aktuelles Datum verwenden)
 */

 CREATE TABLE diaryuser (
     user_id int auto_increment NOT NULL,
     user_name varchar(30) NOT NULL ,
     birtdate date,
     PRIMARY KEY (user_id)
 );
# Foreign Key mit automatischer Constraintnamensgebung (entry_ibfk_1)
CREATE TABLE entry (
    entry_id int auto_increment NOT NULL,
    user_id int NOT NULL,
    text text,
    date date DEFAULT CURRENT_DATE,
    PRIMARY KEY (entry_id),
    FOREIGN KEY (user_id) REFERENCES diaryuser(user_id)
);

# Foreign Key mit selbst gewähltem Name
CREATE TABLE entry (
    entry_id int auto_increment NOT NULL,
    user_id int NOT NULL,
    text text,
    date date DEFAULT CURRENT_DATE,
    PRIMARY KEY (entry_id),
    CONSTRAINT my_foreign_key FOREIGN KEY (user_id) REFERENCES diaryuser(user_id), -- Constraint geht auf Foreign Key
    INDEX (text) -- Index rauslegen, wenn man etwas schnell finden möchte
);

DROP TABLE entry; -- Tabelle löschen

SELECT * from diaryuser, entry;

ALTER TABLE entry ADD FOREIGN KEY (user_id) REFERENCES diaryuser(user_id); -- Tabelle verändern und zB Foreign Key hinzufügen


# Datenbank für Leichtathletik Übung

SELECT * from veranstaltung, ergebnis, austragungsort, helfer, athlet, athletenveranstaltungsliste, helferveranstaltungsliste;

CREATE DATABASE leichtathletik;
USE leichtathletik;

CREATE TABLE veranstaltung (
    veranstaltungs_id int auto_increment NOT NULL, -- PK
    disziplin varchar(30),
    zeitpunkt date NOT NULL,
    austragungsort_id int NOT NULL -- FK
    PRIMARY KEY (veranstaltungs_id),
    FOREIGN KEY (austragungsort_id) REFERENCES austragungsort (austragungsort_id)
);

CREATE TABLE ergebnis (
    ergebnis_id int NOT NULL, -- PK
    rang int NOT NULL,
    wert int NOT NULL,
    athlet varchar(30) -- FK
    PRIMARY KEY (ergebnis_id),
    FOREIGN KEY (athlet) REFERENCES athlet (athlet_id)
);

CREATE TABLE austragungsort (
    austragungsort_id int auto_increment NOT NULL, -- PK
    stadt varchar(30),
    plz int,
    strasse varchar(30),
    hausnummer int
    PRIMARY KEY (austragungsort_id)
);

CREATE TABLE helfer (
    helfer_id int auto_increment NOT NULL , -- PK
    name varchar(30),
    art varchar(30),
    PRIMARY KEY (helfer_id)
);

CREATE TABLE athlet (
    athlet_id int auto_increment NOT NULL , -- PK
    teilnehmernummer int NOT NULL,
    name varchar(30),
    nation varchar(30),
    PRIMARY KEY (athlet_id)
);

CREATE TABLE athletenveranstaltungsliste (
    athlet_id int NOT NULL, -- PK & FK
    veranstaltungs_id int NOT NULL -- PK & FK
    PRIMARY KEY (athlet_id, veranstaltungs_id),
    FOREIGN KEY (athlet_id) REFERENCES athlet(athlet_id),
    FOREIGN KEY (veranstaltungs_id) REFERENCES veranstaltung(veranstaltungs_id);

CREATE TABLE helferveranstaltungsliste (
    helfer_id int NOT NULL, -- PK & FK
    veranstaltungs_id int NOT NULL -- PK & FK
    PRIMARY KEY (helfer_id, veranstaltungs_id),
    FOREIGN KEY (helfer_id) REFERENCES helfer (helfer_id),
    FOREIGN KEY (veranstaltungs_id) REFERENCES veranstaltung(veranstaltungs_id);
;
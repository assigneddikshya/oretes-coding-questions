-- SECTION: Advanced SQL Topics

--  MySQL Triggers

# By definition, a MySQL trigger is a type of stored program, associated with a table, 
# that will be activated automatically once a specific event related to the table of association occurs. 

# This event must be related to one of the following three DML statements: INSERT, UPDATE, or DELETE. 
# Therefore, triggers are a powerful and handy tool where database consistency 
# and integrity are concerned.

# Moreover, to any of these DML statements, one of two types of triggers can be assigned – a “before”, or an “after” trigger.

# In other words, a trigger is a MySQL object that can “trigger” a specific action or calculation ‘before’ or ‘after’ an INSERT, 
# UPDATE, or DELETE statement has been executed. For instance, a trigger can be activated before a new record is inserted into a table, 
# or after a record has been updated.

# Perfect! Let’s execute some code.  

# First, in case you are just starting Workbench, select “Employees” as your default database.
USE employees;

# Then, execute a COMMIT statement, because the triggers we are about to create will make some changes to 
# the state of the data in our database. At the end of the exercise, we will ROLLBACK up to the moment of this COMMIT.  
COMMIT;

# We said triggers are a type of stored program. Well, one could say the syntax resembles that of stored procedures, couldn’t they?

# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# After stating we want to CREATE a TRIGGER and then indicating its name, we must indicate its type and the name of the table 
# to which it will be applied. In this case, we devised a “before” trigger, which will be activated whenever new data is inserted 
# in the “Salaries” table. 

# Great!

# Then, an interesting phrase follows – “for each row”. It designates that before the trigger is activated, MySQL will perform a #
# check for a change of the state of the data on all rows. In our case, a change in the data of the “Salaries” table will be caused 
# by the insertion of a new record. 

# Within the BEGIN-END block, you can see a piece of code that is easier to understand if you just read it without focusing on 
# the syntax.

# The body of this block acts as the core of the “before_salaries_insert” trigger. Basically, it says that if the newly inserted 
# salary is of negative value, it will be set as 0.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF;
*/

# From a programmer’s perspective, there are three things to note about these three lines of code.

# First, especially for those of you who are familiar with some programming, this is an example of a conditional. The IF statement 
# starts the conditional block. Then, if the condition for negative salary is satisfied, one must use the keyword THEN before showing 
# what action should follow. The operation is terminated by the END IF phrase and a semi-colon. 

# The second thing to be noted here is even more interesting. That’s the use of the keyword NEW. In general, it refers to a row that 
# has just been inserted or updated. In our case, after we insert a new record, “NEW dot salary” will refer to the value that will 
# be inserted in the “Salary” column of the “Salaries” table.

# The third part of the syntax regards the SET keyword. As you already know, it is used whenever a value has to be assigned to a 
# certain variable. Here, the variable is the newly inserted salary, and the value to be assigned is 0. 

# All right! Let’s execute this query. 
# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# Let’s check the values of the “Salaries” table for employee 10001.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# Now, let’s insert a new entry for employee 10001, whose salary will be a negative number.
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');
INSERT INTO salaries VALUES ('10001', -92891, '2011-06-22', '9999-01-01');

# Let’s run the same SELECT query to see whether the newly created record has a salary of 0 dollars per year.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# You can see that the “before_salaries_insert” trigger was activated automatically. It corrected the value of minus 92,891 
# we tried to insert. 

# Fantastic!

# Now, let’s look at a BEFORE UPDATE trigger. The code is similar to the one of the trigger we created above, with two 
# substantial differences.
# BEFORE UPDATE
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;

# First, we indicated that this will be a BEFORE UPDATE trigger.  
/*
BEFORE UPDATE ON salaries
*/

# Second, in the IF conditional statement, instead of setting the new value to 0, we are basically telling MySQL to keep the old value. 
# Technically, this is achieved by setting the NEW value in the “Salary” column to be equal to the OLD one. This is a good example of 
# when the OLD keyword needs to be used.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF;
*/

# Create the “before_salaries_update” trigger by executing the above statement. 

# Then, run the following UPDATE statement, with which we will modify the salary value of employee 10001 with another positive value.
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2011-06-22';
        
# Execute the following SELECT statement to see that the record has been successfully updated.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

select *        
FROM 
   salaries
WHERE
    emp_no = '10001'
        AND from_date = '2011-06-22';
        
# Now, let’s run another UPDATE statement, with which we will try to modify the salary earned by 10001 with a negative value, minus 50,000.
UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
        
UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2011-06-22';
        
# Let’s run the same SELECT statement to check if the salary value was adjusted.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2011-06-22';
        
# No, it wasn’t. Everything remained intact. So, we can conclude that only an update with a salary higher than zero dollars per year 
# would be implemented.


# All right. For the moment, you know you have created only two triggers. But how could you prove that to someone who is seeing your 
# script for the first time?
# Well, in the ‘info’ section of the “employees” database, you can find a tab related to triggers. When you click on its name, 
# MySQL will show you the name, the related event, table, timing, and other characteristics regarding each trigger currently in use.  

# Awesome!

# Let’s introduce you to another interesting fact about MySQL. You already know there are pre-defined system variables, but system 
# functions exist too! 
# System functions can also be called built-in functions. 
# Often applied in practice, they provide data related to the moment of the execution of a certain query.

# For instance, SYSDATE() delivers the date and time of the moment at which you have invoked this function.
SELECT SYSDATE();

# Another frequently employed function, “Date Format”, assigns a specific format to a given date. For instance, the following query 
# could extract the current date, quoting the year, the month, and the day. 
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

# Of course, there are many other ways in which you could format a date; what we showed here was just an example.
# So, using system functions seems cool, doesn’t it?

# Wonderful! You already know how to work with the syntax that allows you to create triggers. 

# As an exercise, try to understand the following query. Technically, it regards the creation of a more complex trigger. 
#It is of the size that professionals often have to deal with.

DELIMITER $$
drop trigger if exists trig_ins_dept_mng;

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

# After you are sure you have understood how this query works, please execute it and then run the following INSERT statement.  
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');

# SELECT the record of employee number 111534 in the ‘dept_manager’ table, and then in the ‘salaries’ table to see how the output was affected. 
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = 111534;
commit;
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = 111534;

# Conceptually, this was an ‘after’ trigger that automatically added $20,000 to the salary of the employee who was just promoted as a manager. 
# Moreover, it set the start date of her new contract to be the day on which you executed the insert statement.

# Finally, to restore the data in the database to the state from the beginning of this lecture, execute the following ROLLBACK statement. 
ROLLBACK;

# End.



-- Excercise
-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
drop trigger if exists trig_hire_date;
DELIMITER $$
drop trigger if exists trig_hire_date;
CREATE TRIGGER trig_hire_date  
BEFORE INSERT ON employees
FOR EACH ROW  
BEGIN  
IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN     
SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');     
END IF;  
END $$  
DELIMITER ;  
  

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  
INSERT employees VALUES ('999104', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01'); 

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC; 


# Indexes

use employees;
select * from employees where hire_date > '2000-01-01';

create index  i_index_hire_date on employees(hire_date);
--  now lets run the same statement again it will run faster than earlier.
select * from employees where hire_date > '2000-01-01';


# Select all employees whose name bearing georgi facello

select * from employees where first_name ='Georgi' and last_name = 'Facello';

-- now lets create an index

Create index i_composite on employees(first_name, last_name);
select * from employees where first_name ='Georgi' and last_name = 'Facello';

-- how do i know the list of index

show indexes from employees;

-- Drop the ‘i_hire_date’ index.
ALTER TABLE employees
DROP INDEX i_index_hire_date; 

# Task
-- Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
-- Then, create an index on the ‘salary’ column of that table, and check 
-- if it has sped up the search of the same SELECT statement. 

SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;


CREATE INDEX i_salary ON salaries(salary);


SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000; 
    


-- Case statement

select emp_no, first_name, last_name from employees;

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'm' THEN 'male'
        ELSE 'Female'
    END AS gender
FROM
    employees;


# Similar to the exercises done in the lecture, obtain a result set containing the employee number, first name, and last name 
-- of all employees with a number higher than 109990. Create a fourth column in the query, indicating whether this employee 
-- is also a manager, according to the data provided in the dept_manager table, or a regular employee.     
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990; 
    
#Extract a dataset containing the following information about the managers: employee number, first name, and last name. 
# Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
# and another one saying whether this salary raise was higher than $30,000 or NOT.
# If possible, provide more than one solution. 

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;  

   

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by more then $30,000',
        'Salary was NOT raised by more then $30,000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no; 
    
    


-- Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
-- called “current_employee” saying “Is still employed” if the employee is still working in the company, or 
-- “Not an employee anymore” if they aren’t.
-- Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.   

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

    




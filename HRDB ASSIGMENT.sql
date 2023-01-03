use hrdb;

select * from countries ;
select * from departments ; 
select * from dependents ;
select * from employees;
select * from jobs ;
select * from locations ;
select * from regions ;


#ASSIGNMENT (bassic)

# 1).Display all information in the tables EMP and DEPT.

	select * from employees  ;
    
    select * from departments ;
    
 # 2. Display only the hire date and emplovee name for each employee.
 
	 select hire_date , concat(first_name, "  " , last_name) as emplyees_name 
	 from employees ;
     
# 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title.

	select concat(job_id,"  , ",first_name," , ",last_name) as employee_title
	from employees ;

# 4. Display the hire date, name and department number for sales.

	select e.hire_date , e.first_name , d.department_id 
	from employees e 
	join departments d
	on e.department_id = d.department_id
	where department_name = "sales"  ;


# 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT.

	select concat(employee_id," , ",first_name," , ",last_name," , ",email," , ",phone_number," , ",hire_date," , ",job_id," , ",salary," , ",manager_id," , ",department_id) as THE_OUTPUT
	from employees;

# 6. Display the names and salaries of all employees with a salary greater than 2000.

	select first_name , salary 
	from employees
	where salary >=2000 ;

# 7. Display the names and dates of employees with the column headers "Name and "Start Date

	select first_name as names , hire_date as start_date
	from employees ;

# 8. Disolay the names and hire dates of all emplovees in the order they were hired.

	select first_name as names, hire_date 
	from employees
    order by hire_date ;
    
# 9. Display the names and salaries of all employees in reverse salary order.

	select first_name as names , salary
	from employees
	order by salary desc;

# 10. Display 'ename and 'deptno who are all earned commission and display salary in reverse order.

	select first_name as names ,department_id, count(salary)
	from employees
	group by  emp_commission
	order by  count(salary) desc;

# 11. Display the last name and job title of all employees who do not have a manger .

	select e.last_name , j.job_title, j.job_id
	from employees e
	join jobs j
	on e.job_id=j.job_id
	where  job_title not in ("stock manager") ; 


#12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary 
#    is not equal to $2,500, $3,500, or $5.000.

	select last_name, job_id, salary
	from employees
	where job_id in ('18')
	and salary not in (4500,3500, 5000);

		#ASSIGNMENT-2(Aggregator)
        
# 1) Display the maximum, minimum and average salary and commission earned.

	select max(salary),min(salary),avg(salary),max(emp_commission),min(emp_commission),avg(emp_commission)
	from employees ;

# 2) Display the department number, total salary payout and total commission payout for each department.

	Select department_id, sum(salary),sum(emp_commission)
	from employees 
	group by  department_id;
    
# 3) Display the department number and number of employees in each department.

	select department_id , COUNT(*) as number_of_employees
	from employees
	group by department_id;
    
#4) Display the department number and total salary of employees in each department.

	select department_id , sum(salary) as total_salary
	from employees
	group by department_id;

#5) Display the employee's name who doesn't ear a commission. Order the result set without using the column name.

	select  concat(first_name,"  ",last_name) as employee_Name , emp_commission 
	from employees
	where emp_commission is null;

#6) Display the employees name, department id and commission. If an Employee doesn't earn the commission,
#   then display as 'No commission' Name the columns appropriately.

	select  concat(first_name,"  ",last_name) as employee_Name, case when emp_commission is NULL then 'No commission' else emp_commission end as c
	from employees ;
    




#7) Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, 
# 	 then display as 'No commission! Name the columns appropriately.
	select  concat(first_name,"  ",last_name) as employee_Name, case when emp_commission is NULL then 'No commission' else emp_commission*2 end as c
	from employees ;
	


#8) Display the employee's name, department id who have the first name same as another employee in the same department.

	select   concat(first_name,"  ",last_name) as employee_Name, department_id,
	(select department_name from departments d
	 where e.department_id = d.department_id) department 
	 from employees e 
	 order by department;


#9) Display the sum of salaries of the employees working under each Manager.

	select SUM(salary) , j.job_title
	from employees e
    join jobs j
    on e.job_id=j.job_id
	where job_title ='Stock Manager';

#10) Select the Managers name, the count of employees working under and the department ID of the manager.


#11) Select the employee name, department id, and the salary. Group the result with the manager name and the employee last 
#	 name should have second letter 'a!.

		select first_name, last_name , department_id, salary 
		from employees 
		where first_name like "_a%";

#12) Display the average of sum of the salaries and group the result with the department id. 
#	 Order the result with the department id.

	select department_id, avg(salary),sum(salary)
	from employees 
	group by department_id;

#13) Select the maximum salary of each department along with the department id.

	  select department_id, max(salary) 
	  from employees
	  group by department_id;

#14) Display the commission, if not null display 10% of salary, if null display a default value 1.

select emp_commission*0.10,
    (salary + ((salary*emp_commission) / 100)) as "total_salary" 
from employees;


		#3 assignment (string)

#1. Write a query that displays the employee's last names only from the string's 2-5th position with the 
#   first letter capitalized and all other letters lowercase, Give each column an appropriate label.

	select concat(upper(substring(last_name,2,1)),lower(substring(last_name,2,5)))
    from employees;
    


# 2. Write a query that displays the employee's first name and last name along with a ' in between for e.g.: first name: Ram; last name: Kumar then Ram-Kumar.
#    Also displays the month on wich the employee has joined.

	select concat(first_name,"-",last_name),hire_date
	from employees ;

#3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. 
# Provide each column an appropriate label.

select last_name , if ((salary/2)>10000,(salary+salary*0.10)+1500,(salary+salary*11.5/100)+1500)
from employees;

#4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager 
#name all in Upper case, if the Manager name consists of 'z' replace it with 'S.



#5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names,
# for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names

	select substring(first_name,1,6) as name ,
	length(first_name) as length_of_name 
	from employees
	where first_name like "J%"
	or first_name like "M%"
	or first_name like "A%"
	order by last_name ;


# 6. Create a query to display the last name and salary for all employees. 
#    Format the salary to be 15 characters long, left-padded with S. Label the column SALARY

	select first_name,
	lpad(salary, 15, 's') as SALARY
	from employees;
    
    
#7. Display the emplovee's name if it is a palindrome.

#8.Display First names of all employees with initcaps.

	select upper(first_name) 
	from employees;

#9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.

select concat("_","_",street_address) as STREET_ADDRESS
	from locations;

#10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end.
# Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.

select concat(substring(first_name,1,1),last_name ,last_name,"@systechusa.com") as email_adress
from employees ;


#11. Display the names and job titles of all employees with the same job as Trenna.

	select E.first_name, E.last_name, j.job_title
	from employees E 
	join jobs j
	on E.job_id = j.job_id
	and j.job_title = 'Sales Representative';


#12) Display the names and department name of all employees working in the same city as Trenna.

	select E.first_name, E.last_name, E.department_id 
	from employees E 
	join employees S
	on E.department_id = S.department_id
	and S.last_name = 'Taylor';
    
#13 Display the name of the employee whose salary is the lowest.

	select *from employees
	order by salary asc limit 1;
	 

#14. Display the names of all employees except the lowest paid.

	select  first_name from employees
	order by salary asc limit 1;
    
    
    #ASSIGMENT(3.JOIN)
    
#1. Write a query to display the last name, department number, department name for all employees.

	select e.last_name, e.department_id, d.department_name
	from employees e, departments d
	where e.department_id = d.department_id;

#2. Create a unique list of all jobs that are in department 4. Include the location of the department in the output.

	select distinct job_id, location_id
	from employees, departments
	where employees.department_id = departments.department_id
	and employees.department_id = 4;
    
#3. Write a query to display the employee last name,department name ,location id and city of all employees who earn commission.

	select e.last_name, d.department_name, d.location_id, l.city
	from employees e, departments d, locations l
	where e.department_id = d.department_id
	and d.location_id = l.location_id
	and e.commission_pct is not null;
    
#4. Display the employee last name and department name of all employees who have an 'a' in their last name

	select last_name, department_name
	from employees, departments
	where employees.department_id = departments.department_id
	and last_name like "%a%";
    
#5. Write a query to display the last name ,job,department number and department name for all employees who work in toronto.

	select 	e.last_name, e.job_id, e.department_id,d.department_name
	from 	employees e 
    join departments d
	on 	(e.department_id = d.department_id)
	join 	locations l
	on 	(d.location_id = l.location_id)
	where 	lower(l.city) = "toronto";
    
#6. Display the employee last name and employee number along with their manager's last name and manager number.
	select e.last_name as emp_name, e.employee_id as emp_id ,m.last_name as Manager , m.employee_id as m_id
	from employees e join employees m
	on(e.manager_id = m.employee_id);

#7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).

	select e.last_name as emp_name, e.employee_id as emp_id ,m.last_name as Manager , m.employee_id as m_id
	from employees e
	left outer join employees m
	ON (e.manager_id = m.employee_id);
    
#8. Create a query that displays employees last name ,department number,and all the employees who work in the same department as a given employee.


	select e.department_id department, e.last_name employee,c.last_name 
	from employees e 
    join employees c
	on (e.department_id = c.department_id)
	where e.employee_id <> c.employee_id
	order  by e.department_id, e.last_name, c.last_name;
    
#9. Create a query that displays the name ,job,department name ,salary,grade for all employees

	select e.last_name, e.job_id, d.department_name,e.salary
	from employees e 
    join departments d
	on (e.department_id = d.department_id);

#10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date.
#Label the columns as Employee name, emp_hire_date,manager name,man_ hire_date.


	select w.last_name, w.hire_date, m.last_name, m.hire_date
	from employees w join employees m
	on (w.manager_id = m.employee_id)
	where w.hire_date < m.hire_date;
	
    
	#assignment(4 SUB-QUERY)
    
#1).Write a query to display the last name and hire date of any employee in the same department as SALES.

	select last_name, hire_date
	from employees
	where department_id = (select department_id
	from employees
	where last_name = "popp")
	and last_name <> "popp";
    
#2. Create a query to display the employee numbers and last names of all employees who earn more than the average salary.
# Sort the results in ascending order of salary.

	select employee_id ,last_name
	from employees
	where salary > (select avg(salary) from employees)
	order by salary asc;
    
#3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee
# whose last name contains a 'u'.

	select employee_id, last_name
	from employees
	where department_id in (select department_id from employees where last_name like "%u%");
    
    
#4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.

	 select last_name, department_id, job_id
	from employees
	where department_id in (select department_id from departments where location_id = 1700);
    
#5. Display the last name and salary of every employee who reports to FILLMORE.

	select last_name, salary
	from employees
	where manager_id = (select employee_id from employees where last_name = "king");

#6. Display the department number, last name, and job ID for every employee in the OPERATIONS department.

	select department_id, last_name, job_id
	from employees
	where department_id in (select department_id from departments where department_name = "IT");
    
#7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average 
#salary and who work in a department with any employee with a 'u'in their name.

	select employee_id, last_name, salary
	from employees
	where department_id in (select department_id from employees where last_name like "%u%")
	and salary > (select avg(salary)from employees);

#8.Display the names of all employees whose job title is the same as anyone in the sales dept.

SELECT  employee_id,  first_name, last_name,  
CASE job_id  
WHEN 'sales' THEN 'SALESMAN'  
 ELSE job_id  
END AS designation,  salary 
FROM employees;

#9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. 
#   Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, 
#   employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.




#10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.

	select last_name,salary
	from employees
	order by salary desc limit 3;

#11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column

	select  concat(first_name,"  ",last_name) as employee_Name, case when emp_commission is NULL then '0' else emp_commission end as commission, salary
	from employees ;
    
#12. Display the Managers (name) with top three salaries along with their salaries and department information.



		#ASSIGNMENT(DATA_FUNCTION)


#1) Find the date difference between the hire_date and resignation_date for all the employees. Display in no. of days, months and year(1 year 3 months 5 days).
#Emp_ID Hire_Date Resignation_Date


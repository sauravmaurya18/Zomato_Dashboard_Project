create database Project;
use project;
create table employee(
emp_no int unique not null,
ename varchar (50),
job varchar(50) default "clerk",
mgr int,
hiredate date,
sal int check(sal>0),
comm int,
deptno int,
foreign key (deptno) references Dept(deptno)
); 

insert into employee values
(7369,"Smith","CLERK",7902,"1890-12-17",800,null,20),
(7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600,300,30),
(7521,"WARD","SALESMAN",7698,"1981-02-22",1250,500,30),
(7566,"JONES","MANAGER",7839,"1981-04-02",2975,null,20),
(7654,"MARTIN","SALESMAN",7698,"1981-09-28",1250,1400,30),
(7698,"BLAKE","MANAGER",7839,"1981-05-01",2850,null,30),
(7782,"CLARK","MANAGER",7839,"1981-06-09",2450,null,10),
(7788,"SCOTT","ANALYST",7566,"1987-04-19",3000,null,20),
(7839,"KING","PRESIDENT",null,"1981-11-17",5000,null,10),
(7844,"TURNER","SALESMAN",7698,"1981-09-08",1500,0,30),
(7876,"ADAMS","CLERK",7788,"1987-05-23",1100,null,20),
(7900,"JAMES","CLERK",7698,"1981-12-03",950,null,30),
(7902,"FORD","ANALYST",7566,"1981-12-03",3000,null,20),
(7934,"MILLER","CLERK",7782,"1982-01-23",1300,null,10);

select * from employee;

-------------------- Q2 ----------------------
#2.	  Create the Dept Table as below

create table dept(
dept_no int primary key,
dname varchar(50),
loc varchar(50)
);
 
insert into dept values
(10, "OPERATIONS", "BOSTON"),
(20,"RESEARCH","DALLAS"),
(30,"SALES","CHICAGO"),
(40,"ACCOUNTING","NEW YORK");

select * from dept ; 

-------------------- Q3 ----------------------
#3.	List the Names and salary of the employee whose salary is greater than 1000

select ename,sal from employee
where sal > 1000;

-------------------- Q4 ----------------------
#4.	List the details of the employees who have joined before end of September 81.

select * from employee;
select ename,hiredate from employee
where hiredate < "1981-09-30";

-------------------- Q5 ----------------------
#5.	List Employee Names having I as second character.

select ename from employee
where ename like '_I%';

-------------------- Q6 ----------------------
/* 6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary.
 Also assign the alias name for the columns */
 
 select ename,sal,(0.4*sal) as Allownaces ,(0.1*sal) as P_f, ((sal+(0.4*sal))-(0.1*sal)) as "Net_Salary" from employee; 
 
 -------------------- Q7 ----------------------
 #7. List Employee Names with designations who does not report to anybody
 select * from employee;
select ename,job from employee
where mgr is null;

 -------------------- Q8 ----------------------
 #8.	List Empno, Ename and Salary in the ascending order of salary.
 
 select emp_no, ename, sal from employee 
 order by 3 ;

 -------------------- Q9 ----------------------
#9.	How many jobs are available in the Organization ?

select count(distinct job)  as Jobs_Available  from employee;

 -------------------- Q10 ----------------------
 #10.	Determine total payable salary of salesman category
 
 select * from employee;
 select sum(sal) from employee 
 where job = "salesman";
 
  -------------------- Q11 ----------------------
  #11.	List average monthly salary for each job within each department   
  
  select * from dept;
  select * from employee;
  
  select d.dname,e.job, avg(e.sal) as avg_monthly_salary from employee e 
  join dept d on d.dept_no = e.deptno
  group by 1 , 2 ;
  
 -------------------- Q12 ----------------------
 #12.Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
 
 select * from dept;
 select * from employee;
 
 select ename, sal, dname from employee e 
 join dept d on d.dept_no = e.deptno;
 
 -------------------- Q13 ----------------------
 #13.Create the Job Grades Table as below
 
 create table Job_Grades(
 grade varchar(50),
 lowest_sal int,
 highest_sal int
 );
 
 insert into Job_Grades values
 ('A', 0, 999),
 ('B',1000,1999),
 ('C',2000,2999),
 ('D',3000,3999),
 ('E',4000,5000);
 
 select * from Job_Grades;

 -------------------- Q14 ----------------------
#14.Display the last name, salary and  Corresponding Grade.

select * from employee;
select ename, sal,
case when sal<=999 then 'A'
	 when sal<=1999 then 'B'
     when sal<=2999 then 'C'
     when sal<=3999 then 'D'
     when sal<=5000 then 'E'
end as grade 
from employee;

 -------------------- Q15 ----------------------
 #15.Display the Emp name and the Manager name under whom the Employee works in the below format .

select * from employee;

select concat(e.ename,"Report to ", m.ename) as Reporting 
from employee e join employee m on e.mgr = m.emp_no;

 -------------------- Q16 ----------------------
 #16.Display Empname and Total sal where Total Sal (sal + Comm)
 
 select ename, (sal+ifnull(comm,0)) as total_sal 
 from employee;

 -------------------- Q17 ----------------------
#17.Display Empname and Sal whose empno is a odd number

select emp_no,ename,sal from employee
where emp_no % 2=1 ; 

 -------------------- Q18 ----------------------
 #18.Display Empname , Rank of sal in Organisation , Rank of Sal in their department
 
 select ename,
		rank() over (order by sal desc) as oraganization_rank,
        rank() over (partition by deptno order by sal desc ) as dept_rank 
from employee;

 -------------------- Q19 ----------------------
 #19.Display Top 3 Empnames based on their Salary
 
 select ename, sal from employee
 order by sal desc
 limit 3;

 -------------------- Q20 ----------------------
#20. Display Empname who has highest Salary in Each Department 

select * from employee;
select * from dept;
select ename,sal,dname from employee e 
join dept d  on d.dept_no = e.deptno
where (e.deptno,e.sal) in (
select deptno,max(sal) from employee
group by deptno );
 
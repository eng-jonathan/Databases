<a name="TOP"></a>

# Databases 
___
<a name="p1"></a>
 
### [Cuustom Procedures](https://github.com/eng-jonathan/Databases/tree/main/Project%201)
* [Project Specifications](https://github.com/eng-jonathan/Databases/blob/main/Project%201/Project%20One%20Specifications.pdf)
* [Personal Queries](https://github.com/eng-jonathan/Databases/blob/main/Project%201/Query%20Files/Jonathan%20Eng/Group%204%20-%20Jonathan%20Eng.sql)      
* [Presentation](https://github.com/eng-jonathan/Databases/blob/main/Project%201/Presentation/1045%20-%20Group%204%20-%20Group%20Project%201.pdf)
* Develop problems that can be given to a developer and create solutions. 
* Highlight(s)
```
/*Q10. Show Products that are no longer in stock (Quantity Zero)*/
USE AdventureWorks2017;
SELECT PP.ProductID,
       PP.Name,
       PINV.Quantity
FROM Production.[Product] AS PP
    LEFT OUTER JOIN Production.[ProductInventory] AS PINV
        ON PP.ProductID = PINV.ProductID
GROUP BY PP.ProductID,
         PP.Name,
         PINV.Quantity
HAVING SUM(PINV.Quantity) = 0;
```
<img src = "Project%201/Images/P01_1.png" width = "350">

___
<a name="p2"></a>

### [Star Schema Recreation](https://github.com/eng-jonathan/Databases/tree/main/Project%202)
* [Project Specifications](https://github.com/eng-jonathan/Databases/blob/main/Project%201/Project%20One%20Specifications.pdf) 
* Personal Stored Procedures: [Load_DimProductCategory](https://github.com/eng-jonathan/Databases/blob/main/Project%202/Stored%20Procedures/Jonathan%20Eng/Project2.Load_DimProductCategory.sql) | [Load_DimProductSubCategory](https://github.com/eng-jonathan/Databases/blob/main/Project%202/Stored%20Procedures/Jonathan%20Eng/Project2.Load_DimProductSubCategory.sql)
* Presentations: [JDBC](https://github.com/eng-jonathan/Databases/blob/main/Project%202/Presentations/1045_G4_Group_Project_2%20(JDBC).pdf) | [System Lifecycle & SSMS](https://github.com/eng-jonathan/Databases/blob/main/Project%202/Presentations/1045_G4_Group_Project_2%20(System%20Lifecycle%20%26%20SSMS).pdf)
* Recreate the *BIClass Database Star Schema* using the Original Data Table. Modify all primary keys to eliminate the identity key and use sequence objects in thier place. 
___ 
<a name="p3"></a>

### [School Database Designing](https://github.com/eng-jonathan/Databases/tree/main/Project%203)
* [Project Specifications](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Project%203%20Specifications.pdf)
* Personal Stored Procedure: [Department.Instructor](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Stored%20Procedures/Jonathan%20Eng/G10_4.uvw_Instructor.sql)
* Personal Queries: [Multi_Department_Insturctors](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Queries/Jonathan%20Eng/Query1.Mult_Dept_Instructors.sql) | [%Instructors_Per_Department](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Queries/Jonathan%20Eng/FreeQuery.Percent_Instructor_PerDept.sql)
* Design and Create a new Databse (*QueensClassScheduleCurrentSemester*) from the single table (*CoursesCurrentSemester*). Create and Document stored procedures to load each of the individual tables based on your databse design.
* Highlight(s)
```
/*Q1: Shows Instructors that teach in Multiiple Departments*/
SELECT DISTINCT Multi_Department_Instructors.InstructorFullName, 
MAX(Multi_Department_Instructors.Quantity) AS Num_Departments
FROM (
	SELECT DISTINCT InstructorFullName, 
	DENSE_RANK() OVER
		(PARTITION BY InstructorFullName ORDER BY DepartmentName) AS Quantity
	FROM Department.[Instructor]
	GROUP BY InstructorFullName,
			 DepartmentName
	HAVING InstructorFullName <> 'TBA') AS Multi_Department_Instructors
GROUP BY Multi_Department_Instructors.InstructorFullName
HAVING MAX(Multi_Department_Instructors.Quantity) > 1
ORDER BY Num_Departments DESC
```
<img src = "Project%203/Images/P03_01.png" width = "250">

```
/*Q2: Shows the Amount & Percentage of Professors Teaching in Each Department*/
SELECT DISTINCT DepartmentName, COUNT(InstructorFullName) AS Num_Intstructors, 
CONCAT( CAST(COUNT(InstructorFullName) * 100.00/ 
	(SELECT COUNT(InstructorFullName) FROM Department.Instructor) AS DECIMAL (5,2) ), '%') 
	AS Pct_Of_Instructors

FROM Department.[Instructor]
GROUP BY DepartmentName
ORDER BY Num_Intstructors DESC
```
<img src = "Project%203/Images/P03_02.png" width = "250">

___
<a name="overview"></a>

### Course Overview:
[Syllabus](https://github.com/eng-jonathan/Databases/blob/main/syllabus/syllabus.pdf)
* Develop SQL Querying solutions through critical thinking skills in a professional work environment as a team member or leader
* Understanding how to write relational calculi expressions based upon your TSQL querying knowledge
* Understanding and working with metadata and taxonomies
* Creating indexes and foreign keys on your physical database design
* Create ERD diagrams of logical models
* Understanding subject areas in ERD diagrams and how to create them within the SSMS database environment
* Importing and exporting data to/from the database
* Creating reports using SSRS/ReportBuilder 2016
___

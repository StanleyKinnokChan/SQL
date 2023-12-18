USE myPlayground
GO

Create Table employees
(
	id int primary key identity, 
	name varchar(50),
	email varchar(50),
	department varchar(50)
)

GO


--turn off count for better performance
SET NOCOUNT ON

DECLARE @counter int = 1

--use while loop to create 10000 rows

WHILE(@counter<=10000)
Begin
	DECLARE @name varchar(50) = 'ABC' + RTRIM(@counter)
	DECLARE @email varchar(50) = 'abc' + RTRIM(@counter) + '@gmail.com'
	DECLARE @department varchar(50) = 'Dept' + RTRIM(@counter)

	INSERT INTO employees values (@name, @email, @department)

	SET @counter = @counter+1

	IF (@counter%1000 = 0)
		PRINT RTRIM(@counter) + 'rows inserted' 
END



CREATE CLUSTERED INDEX IX_employees_id on employees (id ASC);
CREATE NONCLUSTERED INDEX IX_employees_name on employees (name ASC);
GO

DROP INDEX employees.IX_employees_id;
DROP INDEX employees.IX_employees_name;
GO

--include/ exclude actual execution plan to see the query performance (ctrl+M)
select name from employees where name like 'ABC5000';
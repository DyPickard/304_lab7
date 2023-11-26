## Question 1
### Part 1:
```
/Depts/Dept[budget<400000]
```

### Part 2:
```
Q2. /Depts/Dept[name="Management"]/Emp[name > 'K']
```

### Part 3:
```
Q3. data(/Depts/Dept[name="Consulting"]/Emp[2]/@eno)```
```

## Question 2
### Part 1:
```sql
CREATE VIEW deptSummary (dno, dname, totalEmp, totalSalary) AS
SELECT dept.dno, dname, COUNT(eno) AS totalEmp, SUM(salary) AS totalSalary
FROM emp JOIN dept ON emp.dno = dept.dno
GROUP BY dno;
```

### Part 2:
```sql
CREATE VIEW empSummary (eno, ename, salary, bdate, dno, totalProj, totalHours) AS
SELECT emp.eno, ename, salary, bdate, dno, t2.totalProj, t2.totalHours
FROM emp LEFT JOIN
(SELECT eno, COUNT(pno) as totalProj, SUM(hours) AS totalHours FROM workson GROUP BY eno) AS t2
ON emp.eno = t2.eno
WHERE (dno = 'D1' OR dno ='D2' OR dno='D3') AND bdate>'1966-06-08';
```

## Question 3
### Part 1:
```sql

DELIMITER //

CREATE TRIGGER updateBudget AFTER INSERT 
ON workson
FOR EACH ROW
BEGIN
    UPDATE proj
    SET budget = budget + 1000
    WHERE proj.pno = NEW.pno;
END;
//
DELIMITER ;
```

### Part 2:

```sql

DELIMITER //

CREATE TRIGGER ee BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
    IF NEW.salary < 50000 THEN
        SET NEW.salary = (SELECT AVG(salary) FROM emp WHERE title = new.title) + 5000;
    END IF;
END; //

DELIMITER ;
```

INSERT INTO emp (eno, title, salary) VALUES ('E10', 'ME', '5000');

## Question 4

```json
{
    "proj": [
        {
            "pno": "P1",
            "pname": "Instruments",
            "budget": 150000,
            "dno": "D1"
        },
        {
            "pno": "P2",
            "pname": "DB Develop",
            "budget": 135000,
            "dno": "D2"
        },
        {
            "pno": "P3",
            "pname": "Budget",
            "budget": 150000,
            "dno": "D3"
        },
        {
            "pno": "P4",
            "pname": "Maintenance",
            "budget": 150000,
            "dno": "D2"
        },
        {
            "pno": "P5",
            "pname": "CAD/CAM",
            "budget": 150000,
            "dno": "D2"
        }
    ],
    "dept": [
        {
            "dno": "D1",
            "dname": "Management",
            "mgreno": "E8"
        },
        {
            "dno": "D2",
            "dname": "Consulting",
            "mgreno": "E7"
        },
        {
            "dno": "D3",
            "dname": "Accounting",
            "mgreno": "E5"
        },
        {
            "dno": "D4",
            "dname": "Development",
            "mgreno": null
        }
    ]
}
```
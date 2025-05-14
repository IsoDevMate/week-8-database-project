# Student Records Management System Documentation

## Overview
This project implements a comprehensive Student Records Management System using MySQL. The system is designed to track and manage student information, course enrollments, faculty assignments, and academic programs in an educational institution.

## Entity Relationship Diagram (ERD)

![Screenshot 2025-05-14 155651](https://github.com/user-attachments/assets/1a2cd0f8-a87f-479a-84cc-6bb664896650)


## Entity Relationships

1. **Departments to Programs**: One-to-Many (1:M)
   - A department can offer multiple programs
   - Each program belongs to exactly one department

2. **Departments to Faculty**: One-to-Many (1:M)
   - A department can have multiple faculty members
   - Each faculty member belongs to exactly one department

3. **Departments to Courses**: One-to-Many (1:M)
   - A department can offer multiple courses
   - Each course is offered by exactly one department

4. **Programs to Students**: One-to-Many (1:M)
   - A program can have multiple enrolled students
   - Each student is enrolled in exactly one program

5. **Students to Enrollments**: One-to-Many (1:M)
   - A student can have multiple enrollments
   - Each enrollment is associated with exactly one student

6. **Courses to Enrollments**: One-to-Many (1:M)
   - A course can have multiple enrollments
   - Each enrollment is associated with exactly one course

7. **Semesters to Enrollments**: One-to-Many (1:M)
   - A semester can have multiple enrollments
   - Each enrollment is associated with exactly one semester

8. **Courses to Course_Faculty**: One-to-Many (1:M)
   - A course can be taught by multiple faculty members (in different semesters)
   - Each course-faculty assignment is for exactly one course

9. **Faculty to Course_Faculty**: One-to-Many (1:M)
   - A faculty member can teach multiple courses (in different semesters)
   - Each course-faculty assignment is for exactly one faculty member

10. **Semesters to Course_Faculty**: One-to-Many (1:M)
    - A semester can have multiple course-faculty assignments
    - Each course-faculty assignment is for exactly one semester

## Database Normalization

The database schema follows normalization principles to minimize redundancy and maintain data integrity:

### First Normal Form (1NF)
- All tables have a primary key (either single column or composite)
- No repeating groups or arrays
- Each column contains atomic values

### Second Normal Form (2NF)
- All tables are in 1NF
- All non-key attributes are fully dependent on the primary key
- No partial dependencies

### Third Normal Form (3NF)
- All tables are in 2NF
- No transitive dependencies (non-key attributes depend only on the primary key)

## Key Design Decisionsv

1. **Constraints**: 
   - Primary and foreign key constraints to maintain referential integrity
   - UNIQUE constraints on critical fields (email, course_code, etc.)
   - CHECK constraints for data validation (e.g., grades, credit hours)
3. **Relationship Handling**: 
   - Used junction tables (COURSE_FACULTY) for many-to-many relationships
   - Used foreign keys for one-to-many relationships
4. **Data Types**: 
   - VARCHAR for text fields
   - DATE for date fields
   - TEXT for longer descriptions
   - INT for numeric values

## System Access Control and Privileges

The database implements a comprehensive security model with both traditional user-based security and role-based access control (available in MySQL 8.0+):

### User Types and Permissions

1. **Admin User**
   - Full access to all database objects and operations
   - Can create, modify, and delete tables, views, and other structures
   - Can manage user accounts and privileges

2. **Registrar User**
   - Full access (SELECT, INSERT, UPDATE, DELETE) to student and enrollment data
   - Read-only access to courses, programs, departments, faculty, and semesters
   - Responsible for student registration and record management

3. **Faculty User**
   - Read-only access to most tables (students, courses, programs, etc.)
   - Can view enrollments for their courses
   - Can update only the grade field in enrollments table

4. **Student User**

   - Can view their personal information, enrollments, and grades
   - Read-only access to course catalog, program, and department information

### Role-Based Access Control (RBAC)

The system also implements roles that can be assigned to users:

- **admin_role**: Full system access
- **registrar_role**: Student and enrollment management
- **faculty_role**: Course teaching and grading
- **student_role**:  access to own records



## Db Setup Instructions

3. Import the SQL script:
   ```
   mysql -u username -p < answers.sql
   ```


## Sample Queries

The SQL script includes sample queries that demonstrate typical operations:

1. Retrieving a student's course history
2. Finding faculty teaching in a specific semester
3. Counting enrollments by department
4. Calculating student GPA
5. Identifying popular courses

## Future Enhancements

1. Implement views for common data access patterns
2. Create stored procedures for complex operations
3. Implement backup and recovery mechanisms

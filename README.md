# Student Records Management System - README

## Project Title
Student Records Management System for Educational Institutions

## Description
This project implements a comprehensive database system for managing student records, course enrollments, faculty assignments, and academic programs. The system is designed for educational institutions to efficiently track and manage academic data while maintaining data integrity through proper relationships and constraints.

## Features
- Student information management
- Course catalog and enrollment tracking
- Faculty assignment to courses
- Program and department organization
- Academic semester management
- Comprehensive data querying capabilities

## ERD Diagram
The database schema includes the following entities with their relationships:

```
DEPARTMENTS (1) ----< PROGRAMS (M)
DEPARTMENTS (1) ----< FACULTY (M)
DEPARTMENTS (1) ----< COURSES (M)
PROGRAMS (1) ----< STUDENTS (M)
STUDENTS (1) ----< ENROLLMENTS (M)
COURSES (1) ----< ENROLLMENTS (M)
SEMESTERS (1) ----< ENROLLMENTS (M)
FACULTY (M) >---- COURSE_FACULTY ----< COURSES (M) [with semester context]
SEMESTERS (1) ----< COURSE_FACULTY (M)
```

## Setup Instructions

### Prerequisites
- MySQL Server (version 5.7 or higher)
- MySQL client (MySQL Workbench or command line)

### Installation
1. Clone this repository
   ```
   git clone https://github.com/yourusername/student-records-management.git
   ```

2. Import the SQL script
   ```
   mysql -u username -p < student_records_management.sql
   ```
   
   Or using MySQL Workbench:
   - Open MySQL Workbench
   - Connect to your MySQL server
   - Go to File > Open SQL Script
   - Navigate to student_records_management.sql
   - Execute the script (lightning bolt icon or Ctrl+Shift+Enter)

3. Verify installation
   ```
   mysql -u username -p -e "USE student_records_db; SHOW TABLES;"
   ```

## Project Structure
- `student_records_management.sql`: Complete SQL script for creating and populating the database
- `documentation.md`: Detailed documentation of the database design and implementation
- `README.md`: This file

## Sample Queries
The SQL file includes example queries for common operations:
- Retrieving student course history
- Finding faculty assignments by semester
- Counting enrollments by department
- Calculating student GPA
- Identifying popular courses

## Database Schema
The database consists of the following tables:
- departments
- programs
- students
- faculty
- semesters
- courses
- enrollments
- course_faculty

Each table includes appropriate constraints (primary keys, foreign keys, unique constraints) to maintain data integrity.

## Screenshot
![alt text](<Screenshot 2025-05-14 155651.png>)

## License
This project is available for educational purposes.

## Author
[Your Name]
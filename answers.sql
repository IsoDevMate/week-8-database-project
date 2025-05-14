DROP DATABASE IF EXISTS student_records_db;
CREATE DATABASE student_records_db;
USE student_records_db;

-- ========================================================================
-- Table structure for DEPARTMENTS
-- ========================================================================
CREATE TABLE departments (
    dept_id VARCHAR(10) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    phone VARCHAR(20)
);

-- ========================================================================
-- Table structure for PROGRAMS
-- ========================================================================
CREATE TABLE programs (
    program_id VARCHAR(10) NOT NULL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    dept_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ========================================================================
-- Table structure for STUDENTS
-- ========================================================================
CREATE TABLE students (
    student_id VARCHAR(10) NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    program_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs (program_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ========================================================================
-- Table structure for FACULTY
-- ========================================================================
CREATE TABLE faculty (
    faculty_id VARCHAR(10) NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    dept_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ========================================================================
-- Table structure for SEMESTERS
-- ========================================================================
CREATE TABLE semesters (
    semester_id VARCHAR(10) NOT NULL PRIMARY KEY,
    semester_name VARCHAR(50) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (end_date > start_date)
);

-- ========================================================================
-- Table structure for COURSES
-- ========================================================================
CREATE TABLE courses (
    course_id VARCHAR(10) NOT NULL PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    credit_hours INT NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (credit_hours > 0)
);

-- ========================================================================
-- Table structure for ENROLLMENTS
-- ========================================================================
CREATE TABLE enrollments (
    enrollment_id VARCHAR(20) NOT NULL PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    semester_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    UNIQUE (student_id, course_id, semester_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (semester_id) REFERENCES semesters (semester_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'W', 'I', NULL))
);

-- ========================================================================
-- Table structure for COURSE_FACULTY (Many-to-Many relationship between courses and faculty per semester)
-- ========================================================================
CREATE TABLE course_faculty (
    faculty_id VARCHAR(10) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    semester_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (faculty_id, course_id, semester_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty (faculty_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (semester_id) REFERENCES semesters (semester_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

SHOW TABLES;

-- ========================================================================
--  SAMPLE DATA i have used 
-- ========================================================================

-- Insert departments
INSERT INTO departments VALUES
('DEPT001', 'Computer Science', 'Building A, Floor 2', '123-456-7890'),
('DEPT002', 'Mathematics', 'Building B, Floor 1', '123-456-7891'),
('DEPT003', 'Business Administration', 'Building C, Floor 3', '123-456-7892');

-- Insert programs
INSERT INTO programs VALUES
('PROG001', 'Bachelor of Science in Computer Science', 'Four-year undergraduate program in computer science', 'DEPT001'),
('PROG002', 'Master of Science in Data Science', 'Two-year graduate program in data science', 'DEPT001'),
('PROG003', 'Bachelor of Science in Mathematics', 'Four-year undergraduate program in mathematics', 'DEPT002'),
('PROG004', 'Bachelor of Business Administration', 'Four-year undergraduate program in business', 'DEPT003');

-- Insert students
INSERT INTO students VALUES
('STU001', 'John', 'Doe', '2000-05-15', 'john.doe@example.com', '555-123-4567', '123 College St, City', 'PROG001'),
('STU002', 'Jane', 'Smith', '1999-08-22', 'jane.smith@example.com', '555-234-5678', '456 University Ave, City', 'PROG001'),
('STU003', 'Michael', 'Johnson', '2001-02-10', 'michael.j@example.com', '555-345-6789', '789 Campus Rd, City', 'PROG003'),
('STU004', 'Emily', 'Brown', '1998-11-30', 'emily.b@example.com', '555-456-7890', '101 Education Dr, City', 'PROG004'),
('STU005', 'David', 'Wilson', '2000-07-19', 'david.w@example.com', '555-567-8901', '202 Learning Ln, City', 'PROG002');

-- Insert faculty
INSERT INTO faculty VALUES
('FAC001', 'Robert', 'Johnson', 'robert.j@university.edu', '555-987-6543', 'DEPT001'),
('FAC002', 'Sarah', 'Miller', 'sarah.m@university.edu', '555-876-5432', 'DEPT001'),
('FAC003', 'Thomas', 'Williams', 'thomas.w@university.edu', '555-765-4321', 'DEPT002'),
('FAC004', 'Patricia', 'Davis', 'patricia.d@university.edu', '555-654-3210', 'DEPT003');

-- Insert semesters
INSERT INTO semesters VALUES
('SEM2023F', 'Fall 2023', '2023-09-01', '2023-12-15'),
('SEM2024S', 'Spring 2024', '2024-01-15', '2024-05-10'),
('SEM2024F', 'Fall 2024', '2024-09-01', '2024-12-15');

-- Insert courses
INSERT INTO courses VALUES
('CRS001', 'CS101', 'Introduction to Programming', 'Basic concepts of programming using Python', 3, 'DEPT001'),
('CRS002', 'CS202', 'Data Structures', 'Advanced data structures and algorithms', 4, 'DEPT001'),
('CRS003', 'MATH101', 'Calculus I', 'Introduction to calculus', 4, 'DEPT002'),
('CRS004', 'BUS101', 'Introduction to Business', 'Fundamentals of business management', 3, 'DEPT003'),
('CRS005', 'CS303', 'Database Systems', 'Principles of database design and SQL', 3, 'DEPT001');

-- Insert enrollments
INSERT INTO enrollments VALUES
('ENR001', 'STU001', 'CRS001', 'SEM2023F', '2023-08-15', 'A'),
('ENR002', 'STU001', 'CRS003', 'SEM2023F', '2023-08-15', 'B'),
('ENR003', 'STU002', 'CRS001', 'SEM2023F', '2023-08-16', 'A'),
('ENR004', 'STU002', 'CRS002', 'SEM2024S', '2024-01-05', 'B'),
('ENR005', 'STU003', 'CRS003', 'SEM2023F', '2023-08-14', 'A'),
('ENR006', 'STU004', 'CRS004', 'SEM2023F', '2023-08-17', 'A'),
('ENR007', 'STU005', 'CRS005', 'SEM2024S', '2024-01-06', NULL),
('ENR008', 'STU001', 'CRS002', 'SEM2024S', '2024-01-05', 'A'),
('ENR009', 'STU003', 'CRS005', 'SEM2024S', '2024-01-07', NULL);

-- Insert course-faculty assignments
INSERT INTO course_faculty VALUES
('FAC001', 'CRS001', 'SEM2023F'),
('FAC002', 'CRS002', 'SEM2024S'),
('FAC002', 'CRS005', 'SEM2024S'),
('FAC003', 'CRS003', 'SEM2023F'),
('FAC004', 'CRS004', 'SEM2023F'),
('FAC001', 'CRS001', 'SEM2024F');



-- ========================================================================
-- USERS AND PRIVILEGES
-- ========================================================================

-- Create users (with placeholder passwords - change in production)
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'admin_password';
CREATE USER IF NOT EXISTS 'registrar_user'@'localhost' IDENTIFIED BY 'registrar_password';
CREATE USER IF NOT EXISTS 'faculty_user'@'localhost' IDENTIFIED BY 'faculty_password';
CREATE USER IF NOT EXISTS 'student_user'@'localhost' IDENTIFIED BY 'student_password';

-- Grant privileges to admin user (full access)
GRANT ALL PRIVILEGES ON * TO 'admin_user'@'localhost';

-- Grant privileges to registrar user
GRANT SELECT, INSERT, UPDATE, DELETE ON students TO 'registrar_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON enrollments TO 'registrar_user'@'localhost';
GRANT SELECT ON courses TO 'registrar_user'@'localhost';
GRANT SELECT ON programs TO 'registrar_user'@'localhost';
GRANT SELECT ON departments TO 'registrar_user'@'localhost';
GRANT SELECT ON faculty TO 'registrar_user'@'localhost';
GRANT SELECT ON semesters TO 'registrar_user'@'localhost';
GRANT SELECT ON course_faculty TO 'registrar_user'@'localhost';

-- Grant privileges to faculty user
-- Faculty can view most data but can only update grades
GRANT SELECT ON students TO 'faculty_user'@'localhost';
GRANT SELECT ON courses TO 'faculty_user'@'localhost';
GRANT SELECT ON programs TO 'faculty_user'@'localhost';
GRANT SELECT ON departments TO 'faculty_user'@'localhost';
GRANT SELECT ON faculty TO 'faculty_user'@'localhost';
GRANT SELECT ON semesters TO 'faculty_user'@'localhost';
GRANT SELECT ON course_faculty TO 'faculty_user'@'localhost';
GRANT SELECT ON enrollments TO 'faculty_user'@'localhost';
GRANT UPDATE (grade) ON enrollments TO 'faculty_user'@'localhost';


-- Grant specific privileges to student user
GRANT SELECT ON courses TO 'student_user'@'localhost';
GRANT SELECT ON departments TO 'student_user'@'localhost';
GRANT SELECT ON programs TO 'student_user'@'localhost';
GRANT SELECT ON semesters TO 'student_user'@'localhost';

FLUSH PRIVILEGES;

-- ========================================================================
-- ROLES (MySQL 8.0+ only)
-- ========================================================================

-- Create roles
CREATE ROLE IF NOT EXISTS 'admin_role', 'registrar_role', 'faculty_role', 'student_role';

-- Grant privileges to roles
GRANT ALL PRIVILEGES ON * TO 'admin_role';

GRANT SELECT, INSERT, UPDATE, DELETE ON students TO 'registrar_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON enrollments TO 'registrar_role';
GRANT SELECT ON courses TO 'registrar_role';
GRANT SELECT ON programs TO 'registrar_role';
GRANT SELECT ON departments TO 'registrar_role';
GRANT SELECT ON faculty TO 'registrar_role';
GRANT SELECT ON semesters TO 'registrar_role';
GRANT SELECT ON course_faculty TO 'registrar_role';

GRANT SELECT ON students TO 'faculty_role';
GRANT SELECT ON courses TO 'faculty_role';
GRANT SELECT ON programs TO 'faculty_role';
GRANT SELECT ON departments TO 'faculty_role';
GRANT SELECT ON faculty TO 'faculty_role';
GRANT SELECT ON semesters TO 'faculty_role';
GRANT SELECT ON course_faculty TO 'faculty_role';
GRANT SELECT ON enrollments TO 'faculty_role';
GRANT UPDATE (grade) ON enrollments TO 'faculty_role';

GRANT SELECT ON courses TO 'student_role';
GRANT SELECT ON departments TO 'student_role';
GRANT SELECT ON programs TO 'student_role';
GRANT SELECT ON semesters TO 'student_role';


-- Assign roles to users
GRANT 'admin_role' TO 'admin_user'@'localhost';
GRANT 'registrar_role' TO 'registrar_user'@'localhost';
GRANT 'faculty_role' TO 'faculty_user'@'localhost';
GRANT 'student_role' TO 'student_user'@'localhost';

-- Set default roles
SET DEFAULT ROLE 'admin_role' TO 'admin_user'@'localhost';
SET DEFAULT ROLE 'registrar_role' TO 'registrar_user'@'localhost';
SET DEFAULT ROLE 'faculty_role' TO 'faculty_user'@'localhost';
SET DEFAULT ROLE 'student_role' TO 'student_user'@'localhost';





-- ========================================================================
-- Example Queries
-- ========================================================================



SELECT * FROM students;
SELECT * FROM  course_faculty;
SELECT * FROM enrollments;
SELECT * FROM courses;
SELECT * FROM semesters;
SELECT * FROM faculty;
SELECT * FROM programs;
SELECT * FROM departments;


-- 1. Get all courses taken by a specific student
SELECT course_code, title, semester_name, grade
FROM enrollments 
JOIN courses USING (course_id)
JOIN semesters USING (semester_id)
WHERE student_id = 'STU001'
ORDER BY start_date;

-- 2. Find faculty members teaching in a specific semester
SELECT first_name, last_name, course_code, title
FROM course_faculty
JOIN faculty USING (faculty_id)
JOIN courses USING (course_id)
WHERE semester_id = 'SEM2024S'
ORDER BY last_name, course_code;

-- 3. Count enrollments by department for each semester
SELECT dept_name, semester_name, COUNT(*) AS enrollment_count
FROM enrollments
JOIN courses USING (course_id)
JOIN departments USING (dept_id)
JOIN semesters USING (semester_id)
GROUP BY dept_id, semester_id
ORDER BY start_date, dept_name;

-- 4. Calculate GPA for a student (assuming A=4, B=3, C=2, D=1, F=0)
SELECT 
    student_id,
    CONCAT(first_name, ' ', last_name) AS student_name,
    SUM(
        CASE 
            WHEN grade = 'A' THEN 4 * credit_hours
            WHEN grade = 'B' THEN 3 * credit_hours
            WHEN grade = 'C' THEN 2 * credit_hours
            WHEN grade = 'D' THEN 1 * credit_hours
            WHEN grade = 'F' THEN 0
            ELSE NULL
        END
    ) / SUM(
        CASE 
            WHEN grade IN ('A', 'B', 'C', 'D', 'F') THEN credit_hours
            ELSE 0
        END
    ) AS gpa
FROM 
    students
JOIN 
    enrollments USING (student_id)
JOIN 
    courses USING (course_id)
WHERE 
    student_id = 'STU001'
    AND grade IN ('A', 'B', 'C', 'D', 'F')
GROUP BY 
    student_id, student_name;

-- 5. Find the most popular courses (by enrollment count)
SELECT course_code, title, COUNT(*) AS enrollment_count
FROM enrollments
JOIN courses USING (course_id)
GROUP BY course_id
ORDER BY enrollment_count DESC
LIMIT 5;


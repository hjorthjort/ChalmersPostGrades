-- The main table, modelling official data
CREATE TABLE Results (
    course CHAR(6),
    course_name VARCHAR(255),
    owner CHAR(10),
    owner_name VARCHAR(255),
    test INT,
    test_name VARCHAR(255),
    credits FLOAT,
    date DATE,
    grade CHAR(4),
    takers INT,
    proportion INT,
    PRIMARY KEY (course, date, test, grade)

);

-- Import data into table
COPY Results
    FROM '--WORKINGDIR--/rawdata.csv'
    WITH DELIMITER ';';

-- A view that only shows grades for exams without letter grades
CREATE OR REPLACE VIEW GradedExams AS (
    SELECT course, course_name, test_name, date, takers,
        -- Replace grade 'U' with 0
        CAST ((CASE grade
            WHEN 'U' THEN '0'
            ELSE grade
    END) AS int) as gradeNbr
    FROM Results
    WHERE test_name LIKE 'Tentamen%' AND course NOT IN
        -- Remove courses with letter grades (happen to be grades that have 'G' in them)
        (SELECT course
            FROM Results
                WHERE test_name LIKE 'Tentamen%'
            GROUP BY course, test_name
            HAVING array_to_string(array_agg(grade), ',') LIKE '%G%')
    ORDER BY course, date, grade
);

-- Average grade for courses in GradedExams
CREATE OR REPLACE VIEW GradedExamsAverages AS (
        SELECT course, course_name AS name, date, SUM(takers) AS takers,
            SUM(takers * CAST(gradeNbr AS NUMERIC)) / SUM(takers) AS average
        FROM GradedExams
        GROUP BY course, course_name, date
);


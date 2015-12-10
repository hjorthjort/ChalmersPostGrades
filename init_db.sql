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

COPY Results
    FROM '--WORKINGDIR--/rawdata.csv'
    WITH DELIMITER ';';

CREATE OR REPLACE VIEW GradedExams AS (
    SELECT course, course_name, test_name, date, takers, 
        CASE grade
            WHEN 'U' THEN '0'
            ELSE grade
        END as gradeNbr
    FROM Results
    WHERE test_name LIKE 'Tentamen%'
        AND grade <> 'G'
    ORDER BY course, date, grade
); 

CREATE OR REPLACE VIEW Over20TakersExams AS (
    SELECT course, date, SUM(takers) AS takers
    FROM GradedExams
    GROUP BY course, date
    HAVING SUM(takers) >= 20
    ORDER BY takers
);

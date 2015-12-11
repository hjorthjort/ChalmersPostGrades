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
        CASE grade
            WHEN 'U' THEN '0'
            ELSE grade
        END as gradeNbr
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

-- All exams that more than 20 people took
CREATE OR REPLACE VIEW Over20TakersExams AS (
    SELECT course, date, SUM(takers) AS takers
    FROM GradedExams
    GROUP BY course, date
    HAVING SUM(takers) >= 20
    ORDER BY takers
);

-- Average grade for courses in GradedExams
CREATE OR REPLACE VIEW GradedExamsAverages AS (
        SELECT course, course_name AS name, date, SUM(takers) AS takers,
            SUM(takers * CAST(gradeNbr AS NUMERIC)) / SUM(takers) AS average
        FROM GradedExams
        WHERE (course, date) IN (SELECT course, date FROM Over20TakersExams)
        GROUP BY course, course_name, date
);


-- The population used for our statisticla analysis
CREATE OR REPLACE VIEW ThePopulation AS (
    SELECT row_number() OVER () as row, GradedExamsAverages.* 
    FROM GradedExamsAverages 
        WHERE date > '2013-07-01'
);

-- The random sample of courses we use for our analysis
CREATE OR REPLACE VIEW TheRandomSample AS (
    SELECT *
    FROM ThePopulation
        WHERE 
            row = 563 OR
            row = 1223 OR
            row = 1091 OR
            row = 1282 OR
            row = 875 OR
            row = 603 OR
            row = 1006 OR
            row = 28 OR
            row = 623 OR
            row = 995 OR
            row = 916 OR
            row = 1283 OR
            row = 1489 OR
            row = 172 OR
            row = 1304 OR
            row = 588 OR
            row = 1522 OR
            row = 233 OR
            row = 1526 OR
            row = 338 OR
            row = 764 OR
            row = 341 OR
            row = 253 OR
            row = 1341 OR
            row = 287 OR
            row = 825 OR
            row = 1004 OR
            row = 251 OR
            row = 1447 OR
            row = 627
        );

-- The women
CREATE OR REPLACE VIEW TheWomenSample AS (
    SELECT * 
    FROM ThePopulation
        WHERE 
            row = 903 OR
            row = 1005 OR
            row = 805
);

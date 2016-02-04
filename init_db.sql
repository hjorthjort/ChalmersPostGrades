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


-- The population used for our statisticla analysis
CREATE OR REPLACE VIEW ThePopulation AS (
    SELECT row_number() OVER () as row, GradedExamsAverages.* 
    FROM GradedExamsAverages 
);

-- The random sample of courses we use for our analysis
CREATE OR REPLACE VIEW TheRandomSample AS (
    SELECT *
    FROM ThePopulation
        WHERE 
            row = 3002 OR
            row = 662 OR
            row = 1925 OR
            row = 1475 OR
            row = 4245 OR
            row = 1321 OR
            row = 8348 OR
            row = 8238 OR
            row = 5557 OR
            row = 11169 OR
            row = 874 OR
            row = 4046 OR
            row = 6734 OR
            row = 11995 OR
            row = 5270 OR
            row = 8536 OR
            row = 3227 OR
            row = 2655 OR
            row = 6170 OR
            row = 3293 OR
            row = 1049 OR
            row = 209 OR
            row = 4948 OR
            row = 1048 OR
            row = 5314 OR
            row = 2880 OR
            row = 4811 OR
            row = 1616 OR
            row = 4584 OR
            row = 1480 OR
            row = 781 OR
            row = 12826 OR
            row = 4265 OR
            row = 8116 OR
            row = 3836 OR
            row = 8966 OR
            row = 10550 OR
            row = 9482 OR
            row = 4339 OR
            row = 957 OR
            row = 5682 OR
            row = 5338 OR
            row = 6920 OR
            row = 130 OR
            row = 9263 OR
            row = 11550 OR
            row = 3370 OR
            row = 8580 OR
            row = 8514 OR
            row = 7514 OR
            row = 11174 OR
            row = 1811 OR
            row = 2752 OR
            row = 5809 OR
            row = 5112 OR
            row = 2299 OR
            row = 2113 OR
            row = 6305 OR
            row = 12577 OR
            row = 12097 OR
            row = 484 OR
            row = 1235 OR
            row = 1330 OR
            row = 4571 OR
            row = 5392 OR
            row = 12009 OR
            row = 9412 OR
            row = 12286 OR
            row = 11662 OR
            row = 2902 OR
            row = 10675 OR
            row = 11992 OR
            row = 9698 OR
            row = 301 OR
            row = 3496 OR
            row = 7519 OR
            row = 6048 OR
            row = 1156 OR
            row = 6237 OR
            row = 12319 OR
            row = 7257 OR
            row = 7502 OR
            row = 5409 OR
            row = 2660 OR
            row = 3971 OR
            row = 9932 OR
            row = 8523 OR
            row = 9751 OR
            row = 4278 OR
            row = 10361 OR
            row = 10962 OR
            row = 10967 OR
            row = 5278 OR
            row = 9477 OR
            row = 4271 OR
            row = 3380 OR
            row = 2606 OR
            row = 8028 OR
            row = 7063 OR
            row = 11309 
        );

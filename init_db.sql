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

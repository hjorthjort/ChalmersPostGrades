CREATE TABLE Kursresultat (
    kurs CHAR(6),
    kursnamn VARCHAR(255),
    kursagare CHAR(10),
    kursagarnamn VARCHAR(255),
    prov INT,
    provnamn VARCHAR(255),
    poang FLOAT,
    provdatum DATE,
    betyg CHAR(4),
    antal INT,
    andel INT,
    PRIMARY KEY (kurs, provdatum, prov, betyg)

);

COPY Kursresultat
    FROM '/Users/hjort/Code/ChalmersGrades/db/rawdata.csv'
    WITH DELIMITER ';';

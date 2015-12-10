CREATE TABLE Kursresultat (
    kurs CHAR(6),
    kursnamn VARCHAR(255),
    kursagare VARCHAR(255),
    prov INT,
    provnamn VARCHAR(255),
    poang FLOAT,
    provdatum DATE,
    betyg CHAR(1),
    antal INT,
    andel INT,
    PRIMARY KEY (kurs, provdatum)
);

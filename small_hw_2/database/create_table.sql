CREATE TABLE Titanic
(
    PassengerId INTEGER,
    Survived INTEGER,
    Pclass INTEGER,
    Name VARCHAR(200),
    Sex VARCHAR(10),
    Age REAL,
    SibSp INTEGER,
    Parch INTEGER,
    Ticket VARCHAR(50),
    Fare REAL,
    Cabin VARCHAR(50),
    Embarked VARCHAR(1)
);

COPY Titanic FROM '/var/lib/postgres/data/Titanic_train_edit.csv'
DELIMITER ';' CSV HEADER ENCODING 'WIN1251';

-- you should copy Titanic_train_edit.csv to the folder with your postgre data on your device

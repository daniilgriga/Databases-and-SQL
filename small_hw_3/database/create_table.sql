CREATE TABLE Docs (
    DocNum INT PRIMARY KEY,
    Data TIMESTAMP,
    Cust_ID INT,
    Total FLOAT
);

CREATE TABLE Docs_data (
    DocNum INT,
    Good_id INT,
    Price FLOAT,
    Qty INT,
    PRIMARY KEY(DocNum, Good_id)
);

CREATE TABLE Goods (
    Good_id INT PRIMARY KEY,
    Good VARCHAR(50),
    Price FLOAT,
    QtyInStock INT,
    Volume FLOAT,
    Mass FLOAT
);

CREATE TABLE Customers (
    Cust_id INT PRIMARY KEY,
    Customer VARCHAR(50),
    City VARCHAR(50)
);

-- Docs
INSERT INTO Docs VALUES (1,'2025-09-01 15:00:00',1,186);
INSERT INTO Docs VALUES (2,'2025-09-13 18:00:00',2,955);
INSERT INTO Docs VALUES (3,'2025-09-15 10:00:00',10,10660);
INSERT INTO Docs VALUES (4,'2025-09-15 12:30:00',8,500);
INSERT INTO Docs VALUES (5,'2025-09-23 14:00:00',6,1365);
INSERT INTO Docs VALUES (6,'2025-09-25 12:00:00',4,3571);
INSERT INTO Docs VALUES (7,'2025-09-26 13:15:00',5,772);
INSERT INTO Docs VALUES (8,'2025-09-29 12:50:00',2,80);
INSERT INTO Docs VALUES (9,'2025-10-01 10:30:00',3,467);
INSERT INTO Docs VALUES (10,'2025-10-05 14:30:00',7,204);
INSERT INTO Docs VALUES (11,'2025-10-06 18:30:00',9,808);
INSERT INTO Docs VALUES (12,'2025-10-10 11:30:00',1,470);
INSERT INTO Docs VALUES (13,'2025-10-15 12:30:00',3,6377);
INSERT INTO Docs VALUES (14,'2025-10-16 16:30:00',6,10830);
INSERT INTO Docs VALUES (15,'2025-10-20 10:30:00',8,2351);

-- Docs_data
INSERT INTO Docs_data VALUES (1,1,147,1);
INSERT INTO Docs_data VALUES (1,2,13,3);
INSERT INTO Docs_data VALUES (2,3,191,5);
INSERT INTO Docs_data VALUES (3,4,891,2);
INSERT INTO Docs_data VALUES (3,5,1609,4);
INSERT INTO Docs_data VALUES (3,6,407,6);
INSERT INTO Docs_data VALUES (4,7,10,1);
INSERT INTO Docs_data VALUES (4,8,483,1);
INSERT INTO Docs_data VALUES (5,9,94,1);
INSERT INTO Docs_data VALUES (5,10,169,3);
INSERT INTO Docs_data VALUES (5,1,135,4);
INSERT INTO Docs_data VALUES (5,2,32,7);
INSERT INTO Docs_data VALUES (6,3,197,1);
INSERT INTO Docs_data VALUES (6,4,894,2);
INSERT INTO Docs_data VALUES (6,5,1586,1);
INSERT INTO Docs_data VALUES (7,6,386,2);
INSERT INTO Docs_data VALUES (8,7,28,3);
INSERT INTO Docs_data VALUES (9,8,467,1);
INSERT INTO Docs_data VALUES (10,9,102,2);
INSERT INTO Docs_data VALUES (11,10,160,4);
INSERT INTO Docs_data VALUES (11,1,168,1);
INSERT INTO Docs_data VALUES (12,2,30,3);
INSERT INTO Docs_data VALUES (12,3,190,2);
INSERT INTO Docs_data VALUES (13,4,911,7);
INSERT INTO Docs_data VALUES (14,5,1587,6);
INSERT INTO Docs_data VALUES (14,6,416,3);
INSERT INTO Docs_data VALUES (14,7,15,4);
INSERT INTO Docs_data VALUES (15,8,451,5);
INSERT INTO Docs_data VALUES (15,9,96,1);

-- Goods
INSERT INTO Goods VALUES (1,'Монитор Samsung 17 белый',150,5,19.8,3.35);
INSERT INTO Goods VALUES (2,'Мышка A4Tech 5 кнопок красная',20,50,3.083282475,0.575);
INSERT INTO Goods VALUES (3,'Принтер HP лазерный',200,2,61.4321,9);
INSERT INTO Goods VALUES (4,'Компьютер Никс S5000',900,1,4.65,1.45);
INSERT INTO Goods VALUES (5,'Ноутбук Lenovo',1600,3,21.02479335,3.2);
INSERT INTO Goods VALUES (6,'Монитор Philips 27 черный',400,7,87.528,7.74);
INSERT INTO Goods VALUES (7,'Клавиатура Logitech белая',10,20,2.013244779,0.454);
INSERT INTO Goods VALUES (8,'Смартфон HTC розовый',470,8,2.1638547,0.685);
INSERT INTO Goods VALUES (9,'Процессор Intel',100,6,0.00703125,0.027);
INSERT INTO Goods VALUES (10,'Материнская плата Gigabyte',150,7,3.54228615,0.681);

-- Customers
INSERT INTO Customers VALUES (1,'ООО Технологии','Москва');
INSERT INTO Customers VALUES (2,'ОАО Дальневосточная техника','Владивосток');
INSERT INTO Customers VALUES (3,'ООО Компьютеры для всех','Новосибирск');
INSERT INTO Customers VALUES (4,'ИП Хомякова Светлана Ивановна','Москва');
INSERT INTO Customers VALUES (5,'ЗАО Радость в каждый дом','Омск');
INSERT INTO Customers VALUES (6,'ОАО Уральские компьютеры','Екатеринбург');
INSERT INTO Customers VALUES (7,'ООО Айти модерн','Санкт-Петербург');
INSERT INTO Customers VALUES (8,'ООО Компьютеры для студентов','Долгопрудный');
INSERT INTO Customers VALUES (9,'ООО Ракета','Химки');
INSERT INTO Customers VALUES (10,'ОАО Мыльные пузыри','Санкт-Петербург');

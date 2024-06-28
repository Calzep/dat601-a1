USE MASTER;
GO

DROP DATABASE IF EXISTS FlightStreamDB;
GO

CREATE DATABASE FlightStreamDB;
GO

USE FlightStreamDB;
GO

-- || DDL TABLES|| --

DROP TABLE IF EXISTS DataScoop;
CREATE TABLE DataScoop
(
	ID INT NOT NULL,
	BiomeConfiguration INT NOT NULL,
	isDeployed BIT NOT NULL,
	latitude DECIMAL(18, 15),
	longitude DECIMAL(18, 15),
	altitude DECIMAL(6, 2)
);

DROP TABLE IF EXISTS DataScoop_PartInstance;
CREATE TABLE DataScoop_PartInstance
(
	DataScoopID INT NOT NULL,
	PartInstanceID INT NOT NULL,
	dateInstalled DATE NOT NULL
);

DROP TABLE IF EXISTS PartInstance;
CREATE TABLE PartInstance
(
	ID INT NOT NULL,
	PartType INT NOT NULL,
	condition VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS PartType;
CREATE TABLE PartType
(
	ID INT NOT NULL,
	partName VARCHAR(255) NOT NULL,
	partDescription VARCHAR(2000),
	cost DECIMAL(7,2)
);

DROP TABLE IF EXISTS Supplier_PartType;
CREATE TABLE Supplier_PartType
(
	PartTypeID INT NOT NULL,
	SupplierID INT NOT NULL
);

DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier
(
	ID INT NOT NULL,
	supplierName VARCHAR(100) NOT NULL,
	email VARCHAR(100),
	phone VARCHAR(20),
	website VARCHAR(255),
	notes VARCHAR(2000)
);

DROP TABLE IF EXISTS Biome;
CREATE TABLE Biome
(
	ID INT NOT NULL,
	biomeName VARCHAR(20) NOT NULL,
	biomeDescription VARCHAR(2000) NOT NULL
);

DROP TABLE IF EXISTS DronePilot_DataScoop_Zone;
CREATE TABLE DronePilot_DataScoop_Zone
(
	DataScoopID INT NOT NULL,
	EmployeeID INT NOT NULL,
	ZoneID INT NOT NULL
);

DROP TABLE IF EXISTS Inspection;
CREATE TABLE Inspection
(
	PartInstanceID INT NOT NULL,
	EmployeeID INT NOT NULL,
	inspectionDate DATE NOT NULL,
	report VARCHAR(2000)
);

DROP TABLE IF EXISTS VideoStream;
CREATE TABLE VideoStream
(
	ID INT NOT NULL,
	ZoneID INT NOT NULL,
	DataScoopID INT NOT NULL,
	pitch DECIMAL(5,2) NOT NULL,
	roll DECIMAL(5,2) NOT NULL,
	yaw DECIMAL(5,2) NOT NULL
);

DROP TABLE IF EXISTS ZoneData;
CREATE TABLE ZoneData
(
	ZoneID INT NOT NULL,
	DataScoopID INT NOT NULL,
	OwningSubscriptionID INT,
	recordTime DATETIME NOT NULL,
	latitude DECIMAL(18, 15) NOT NULL,
	longitude DECIMAL(18, 15) NOT NULL,
	altitude DECIMAL(6, 2) NOT NULL,
	spectralData VARCHAR(8000),
	temperature DECIMAL(7,3),
	ambientLight DECIMAL(18,14),
	humidity DECIMAL(4,3)
);

DROP TABLE IF EXISTS [Zone];
CREATE TABLE [Zone]
(
	ID INT NOT NULL,
	Biome INT NOT NULL,
	OwningSubscriptionID INT
);

DROP TABLE IF EXISTS PerimeterCoordinate;
CREATE TABLE PerimeterCoordinate
(
	ZoneID INT NOT NULL,
	coordinateNumber INT NOT NULL,
	latitude DECIMAL(18,15) NOT NULL,
	longitude DECIMAL(18,15)
);

DROP TABLE IF EXISTS Zone_Contract;
CREATE TABLE Zone_Contract
(
	ZoneID INT NOT NULL,
	ContractID INT NOT NULL
);

DROP TABLE IF EXISTS [Contract];
CREATE TABLE [Contract]
(
	ID INT NOT NULL,
	EmployeeID INT NOT NULL,
	contractor VARCHAR(100) NOT NULL,
	notes VARCHAR(2000)
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee
(
	ID INT NOT NULL,
	Manager INT,
	firstName VARCHAR(50),
	lastName VARCHAR(100) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS DroneTechnician;
CREATE TABLE DroneTechnician
(
	EmployeeID INT NOT NULL,
);

DROP TABLE IF EXISTS DronePilot;
CREATE TABLE DronePilot
(
	EmployeeID INT NOT NULL,
);

DROP TABLE IF EXISTS AdministrativeExecutive;
CREATE TABLE AdministrativeExecutive
(
	EmployeeID INT NOT NULL,
);

DROP TABLE IF EXISTS Salesperson;
CREATE TABLE Salesperson
(
	EmployeeID INT NOT NULL,
	maxDiscount DECIMAL(3,2) NOT NULL
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
(
	ID INT NOT NULL,
	firstName VARCHAR(50),
	lastName VARCHAR(100) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(100),
	company VARCHAR(100)
);

DROP TABLE IF EXISTS Subscription;
CREATE TABLE Subscription
(
	ID INT NOT NULL,
	SubscriptionType VARCHAR(20) NOT NULL,
	CustomerID INT NOT NULL,
	ContractID INT NOT NULL,
	VideoStreamID INT,
	EmployeeID INT,	
	discount DECIMAL (3,2),
	billingDate DATE NOT NULL,
	recurring BIT NOT NULL
);

DROP TABLE IF EXISTS SubscriptionType;
CREATE TABLE SubscriptionType
(
	SubscriptionName VARCHAR(20) NOT NULL,
	price DECIMAL(7,2) NOT NULL, 
	subscriptionDescription VARCHAR(2000) NOT NULL
);

DROP TABLE IF EXISTS Gold;
CREATE TABLE Gold
(
	SubscriptionID INT NOT NULL,
	VideoStreamID INT NOT NULL,
);

DROP TABLE IF EXISTS Platinum;
CREATE TABLE Platinum
(
	SubscriptionID INT NOT NULL,
);

DROP TABLE IF EXISTS SuperPlatinum;
CREATE TABLE SuperPlatinum
(
	SubscriptionID INT NOT NULL,
);

-- || DML MOCK DATA|| --

-- Biome
-- Data generated with Mockaroo
insert into Biome (ID, biomeName, biomeDescription) values (1, 'Jungle', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into Biome (ID, biomeName, biomeDescription) values (2, 'Forest', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into Biome (ID, biomeName, biomeDescription) values (3, 'Savannah', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into Biome (ID, biomeName, biomeDescription) values (4, 'Extreme Cold', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into Biome (ID, biomeName, biomeDescription) values (5, 'Mountain', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into Biome (ID, biomeName, biomeDescription) values (6, 'Desert', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into Biome (ID, biomeName, biomeDescription) values (7, 'Urban', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');

-- SELECT * FROM Biome;

-- DataScoop
-- Data generatedw with Mockaroo
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (1, '1', 1, -5.6861147, -35.2697802, 829.38);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (2, '3', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (3, '7', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (4, '4', 1, 39.912765, 116.18362, 2127.82);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (5, '2', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (6, '6', 1, 56.968436, -2.2508745, 485.19);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (7, '5', 1, 34.6882288, 32.9550349, 1576.24);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (8, '2', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (9, '6', 1, -6.308986, 106.8766009, 911.61);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (10, '4', 1, 49.7245218, 16.8754183, 2112.04);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (11, '5', 1, 22.830192, 112.074588, 957.3);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (12, '3', 1, 8.8702881, -79.810063, 985.21);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (13, '1', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (14, '7', 1, -8.4465, 121.1364, 2361.18);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (15, '1', 1, 22.781631, 108.273158, 744.82);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (16, '4', 1, 48.071593, 119.059106, 172.74);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (17, '3', 1, -33.9842244, 18.4740875, 1303.97);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (18, '5', 1, 52.4262274, 17.4890829, 1239.11);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (19, '6', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (20, '2', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (21, '7', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (22, '3', 1, 45.5178224, 20.6883184, 1160.02);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (23, '2', 1, 41.4745288, -6.3647312, 673.63);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (24, '1', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (25, '4', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (26, '7', 1, 59.9318604, 10.7923128, 1377.06);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (27, '5', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (28, '6', 1, 31.021461, 121.3128539, 2925.59);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (29, '2', 1, 14.7684437, -90.9795277, 2275.47);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (30, '6', 1, 14.1999624, 100.5749629, 1684.76);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (31, '1', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (32, '5', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (33, '7', 1, 41.468342, 115.437602, 1773.08);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (34, '4', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (35, '3', 1, 13.9641503, 121.655933, 2227.44);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (36, '7', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (37, '3', 1, 58.9583506, 5.7740124, 1042.41);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (38, '6', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (39, '1', 1, 15.4560208, 119.9548363, 1234.24);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (40, '4', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (41, '5', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (42, '2', 1, -8.475, 115.3238, 967.47);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (43, '5', 1, 15.0541658, -91.229784, 528.86);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (44, '2', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (45, '4', 1, 16.438508, 103.5060994, 2074.18);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (46, '1', 1, 48.5851876, 7.7342943, 1005.25);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (47, '6', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (48, '7', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (49, '3', 0, null, null, null);
insert into DataScoop (ID, BiomeConfiguration, isDeployed, latitude, longitude, altitude) values (50, '2', 1, 12.0379785, 124.6581969, 1915.82);

-- SELECT * FROM DataScoop;

-- Supplier
-- Data generated with Mockaroo
insert into Supplier (ID, supplierName, email, phone, website, notes) values (1, 'Wilkinson-Herzog', 'okliement0@seesaa.net', '147-392-0169', 'http://washington.edu', null);
insert into Supplier (ID, supplierName, email, phone, website, notes) values (2, 'Bahringer-Bruen', 'jsimes1@java.com', '603-761-2543', null, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (3, 'Oberbrunner and Sons', 'ljaquiss2@nydailynews.com', '592-922-2842', 'https://vimeo.com', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (4, 'Marks-Wilderman', 'pnazair3@domainmarket.com', '612-335-6822', 'http://scribd.com', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (5, 'MacGyver Inc', 'eseabon4@wordpress.org', '152-404-9954', null, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (6, 'Hansen Inc', 'qderkes5@chicagotribune.com', '653-869-6060', 'https://amazonaws.com', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (7, 'Armstrong, Stehr and Stamm', 'tkelf6@squarespace.com', null, 'http://blogtalkradio.com', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (8, 'McLaughlin LLC', 'svandrill7@ibm.com', '676-478-9365', 'https://naver.com', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into Supplier (ID, supplierName, email, phone, website, notes) values (9, 'Gerhold, Weimann and Leuschke', null, null, 'http://blogs.com', null);
insert into Supplier (ID, supplierName, email, phone, website, notes) values (10, 'Corkery Group', 'lcornall9@discuz.net', '451-569-8261', 'https://pagesperso-orange.fr', null);

SELECT * FROM Supplier;

-- PartType
-- Data generated with Mockaroo
insert into PartType (ID, partName, partDescription, cost) values (1, 'propeller', null, 514.84);
insert into PartType (ID, partName, partDescription, cost) values (2, 'motor', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 203.32);
insert into PartType (ID, partName, partDescription, cost) values (3, 'frame', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 240.97);
insert into PartType (ID, partName, partDescription, cost) values (4, 'battery', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 307.83);
insert into PartType (ID, partName, partDescription, cost) values (5, 'controller', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 714.3);
insert into PartType (ID, partName, partDescription, cost) values (6, 'ESC', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 346.55);
insert into PartType (ID, partName, partDescription, cost) values (7, 'GPS module', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 374.3);
insert into PartType (ID, partName, partDescription, cost) values (8, 'camera', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 255.26);
insert into PartType (ID, partName, partDescription, cost) values (9, 'landing gear', null, 278.49);
insert into PartType (ID, partName, partDescription, cost) values (10, 'antenna', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 511.51);
insert into PartType (ID, partName, partDescription, cost) values (11, 'LED lights', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 896.82);
insert into PartType (ID, partName, partDescription, cost) values (12, 'sensors', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 272.38);
insert into PartType (ID, partName, partDescription, cost) values (13, 'wires', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 380.48);
insert into PartType (ID, partName, partDescription, cost) values (14, 'screws', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 989.46);
insert into PartType (ID, partName, partDescription, cost) values (15, 'nuts', null, 350.73);
insert into PartType (ID, partName, partDescription, cost) values (16, 'attitude control', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 106.97);
insert into PartType (ID, partName, partDescription, cost) values (17, 'low temperature battery', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 415.71);
insert into PartType (ID, partName, partDescription, cost) values (18, 'spectral sensor', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 33.87);
insert into PartType (ID, partName, partDescription, cost) values (19, 'temperature sensor', null, 185.14);
insert into PartType (ID, partName, partDescription, cost) values (20, 'low wattage motors', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 781.62);

-- SELECT * FROM PartType;

-- Supplier_PartType
-- Data generated with mockaroo

insert into Supplier_PartType (PartTypeID, SupplierID) values ('1', '7');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('2', '1');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('3', '2');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('4', '3');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('5', '8');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('6', '4');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('7', '10');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('8', '5');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('9', '9');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('10', '6');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('11', '6');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('12', '8');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('13', '9');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('14', '3');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('15', '5');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('16', '10');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('17', '4');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('18', '7');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('19', '1');
insert into Supplier_PartType (PartTypeID, SupplierID) values ('20', '2');

-- SELECT * FROM Supplier_PartType;

-- PartInstance
-- Generated with Mockaroo

insert into PartInstance (ID, PartType, condition) values (1, '6', 'in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus');
insert into PartInstance (ID, PartType, condition) values (2, '8', 'in hac habitasse platea dictumst aliquam');
insert into PartInstance (ID, PartType, condition) values (3, '9', 'vivamus in felis eu sapien');
insert into PartInstance (ID, PartType, condition) values (4, '2', 'sit');
insert into PartInstance (ID, PartType, condition) values (5, '14', 'faucibus orci luctus et ultrices posuere cubilia');
insert into PartInstance (ID, PartType, condition) values (6, '20', 'elit proin interdum mauris');
insert into PartInstance (ID, PartType, condition) values (7, '13', 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna');
insert into PartInstance (ID, PartType, condition) values (8, '12', 'non lectus aliquam sit amet diam in magna');
insert into PartInstance (ID, PartType, condition) values (9, '15', 'diam nam tristique tortor');
insert into PartInstance (ID, PartType, condition) values (10, '16', 'lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla');
insert into PartInstance (ID, PartType, condition) values (11, '7', 'massa id lobortis convallis tortor risus dapibus augue');
insert into PartInstance (ID, PartType, condition) values (12, '5', 'iaculis');
insert into PartInstance (ID, PartType, condition) values (13, '18', 'nulla integer pede justo lacinia');
insert into PartInstance (ID, PartType, condition) values (14, '11', 'tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla');
insert into PartInstance (ID, PartType, condition) values (15, '10', 'et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam');
insert into PartInstance (ID, PartType, condition) values (16, '4', 'nulla ac enim');
insert into PartInstance (ID, PartType, condition) values (17, '17', 'vel ipsum praesent blandit lacinia erat vestibulum sed');
insert into PartInstance (ID, PartType, condition) values (18, '19', 'ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu');
insert into PartInstance (ID, PartType, condition) values (19, '1', 'volutpat sapien arcu sed');
insert into PartInstance (ID, PartType, condition) values (20, '3', 'amet nulla quisque arcu libero');
insert into PartInstance (ID, PartType, condition) values (21, '2', 'ante vivamus tortor duis mattis egestas metus aenean fermentum donec');
insert into PartInstance (ID, PartType, condition) values (22, '16', 'massa id lobortis convallis tortor');
insert into PartInstance (ID, PartType, condition) values (23, '14', 'libero quis orci nullam molestie nibh in lectus');
insert into PartInstance (ID, PartType, condition) values (24, '13', 'nam congue risus semper porta volutpat quam pede lobortis ligula sit amet');
insert into PartInstance (ID, PartType, condition) values (25, '15', 'suscipit ligula in lacus curabitur at');
insert into PartInstance (ID, PartType, condition) values (26, '5', 'non ligula pellentesque');
insert into PartInstance (ID, PartType, condition) values (27, '18', 'nullam orci pede venenatis non sodales sed tincidunt');
insert into PartInstance (ID, PartType, condition) values (28, '19', 'praesent id massa');
insert into PartInstance (ID, PartType, condition) values (29, '4', 'integer ac neque duis');
insert into PartInstance (ID, PartType, condition) values (30, '3', 'convallis morbi odio odio elementum eu interdum eu tincidunt');
insert into PartInstance (ID, PartType, condition) values (31, '8', 'est quam pharetra magna ac consequat metus sapien ut nunc');
insert into PartInstance (ID, PartType, condition) values (32, '17', 'tortor id nulla ultrices aliquet maecenas leo');
insert into PartInstance (ID, PartType, condition) values (33, '12', 'ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor');
insert into PartInstance (ID, PartType, condition) values (34, '7', 'velit nec nisi');
insert into PartInstance (ID, PartType, condition) values (35, '10', 'pretium iaculis diam erat fermentum');
insert into PartInstance (ID, PartType, condition) values (36, '9', 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel');
insert into PartInstance (ID, PartType, condition) values (37, '11', 'ante ipsum primis in faucibus');
insert into PartInstance (ID, PartType, condition) values (38, '6', 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et');
insert into PartInstance (ID, PartType, condition) values (39, '1', 'sem praesent id massa id nisl venenatis lacinia aenean sit');
insert into PartInstance (ID, PartType, condition) values (40, '20', 'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi');
insert into PartInstance (ID, PartType, condition) values (41, '20', 'velit id pretium');
insert into PartInstance (ID, PartType, condition) values (42, '16', 'cursus vestibulum proin eu mi nulla ac enim');
insert into PartInstance (ID, PartType, condition) values (43, '12', 'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien');
insert into PartInstance (ID, PartType, condition) values (44, '4', 'vulputate luctus cum sociis natoque');
insert into PartInstance (ID, PartType, condition) values (45, '10', 'mauris laoreet ut rhoncus aliquet pulvinar sed');
insert into PartInstance (ID, PartType, condition) values (46, '6', 'amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices');
insert into PartInstance (ID, PartType, condition) values (47, '9', 'duis at');
insert into PartInstance (ID, PartType, condition) values (48, '3', 'penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus');
insert into PartInstance (ID, PartType, condition) values (49, '8', 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis');
insert into PartInstance (ID, PartType, condition) values (50, '18', 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet');
insert into PartInstance (ID, PartType, condition) values (51, '11', 'sociis natoque penatibus et magnis dis');
insert into PartInstance (ID, PartType, condition) values (52, '17', 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis');
insert into PartInstance (ID, PartType, condition) values (53, '19', 'maecenas pulvinar lobortis est phasellus');
insert into PartInstance (ID, PartType, condition) values (54, '5', 'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla');
insert into PartInstance (ID, PartType, condition) values (55, '2', 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam');
insert into PartInstance (ID, PartType, condition) values (56, '1', 'justo pellentesque viverra pede ac diam cras pellentesque');
insert into PartInstance (ID, PartType, condition) values (57, '13', 'duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus');
insert into PartInstance (ID, PartType, condition) values (58, '15', 'vehicula consequat morbi a ipsum');
insert into PartInstance (ID, PartType, condition) values (59, '7', 'consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat');
insert into PartInstance (ID, PartType, condition) values (60, '14', 'volutpat in congue etiam justo');
insert into PartInstance (ID, PartType, condition) values (61, '16', 'donec vitae nisi nam ultrices libero non mattis pulvinar');
insert into PartInstance (ID, PartType, condition) values (62, '13', 'amet turpis elementum ligula');
insert into PartInstance (ID, PartType, condition) values (63, '3', 'lacus morbi quis tortor id');
insert into PartInstance (ID, PartType, condition) values (64, '5', 'est phasellus sit amet erat nulla tempus vivamus in');
insert into PartInstance (ID, PartType, condition) values (65, '20', 'dui vel nisl duis ac nibh fusce lacus');
insert into PartInstance (ID, PartType, condition) values (66, '15', 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo');
insert into PartInstance (ID, PartType, condition) values (67, '10', 'quam nec dui luctus rutrum nulla');
insert into PartInstance (ID, PartType, condition) values (68, '2', 'nibh in');
insert into PartInstance (ID, PartType, condition) values (69, '14', 'magnis');
insert into PartInstance (ID, PartType, condition) values (70, '19', 'non velit donec');
insert into PartInstance (ID, PartType, condition) values (71, '18', 'cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices');
insert into PartInstance (ID, PartType, condition) values (72, '9', 'nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit');
insert into PartInstance (ID, PartType, condition) values (73, '11', 'sit amet');
insert into PartInstance (ID, PartType, condition) values (74, '8', 'risus praesent');
insert into PartInstance (ID, PartType, condition) values (75, '12', 'quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec');
insert into PartInstance (ID, PartType, condition) values (76, '6', 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam');
insert into PartInstance (ID, PartType, condition) values (77, '1', 'rutrum nulla nunc');
insert into PartInstance (ID, PartType, condition) values (78, '17', 'gravida nisi at nibh in hac habitasse platea');
insert into PartInstance (ID, PartType, condition) values (79, '4', 'nulla ac enim in tempor turpis nec euismod scelerisque quam');
insert into PartInstance (ID, PartType, condition) values (80, '7', 'adipiscing elit proin risus praesent lectus vestibulum quam');
insert into PartInstance (ID, PartType, condition) values (81, '14', 'nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget');
insert into PartInstance (ID, PartType, condition) values (82, '2', 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh');
insert into PartInstance (ID, PartType, condition) values (83, '1', 'felis ut at dolor quis odio consequat varius integer');
insert into PartInstance (ID, PartType, condition) values (84, '4', 'in faucibus');
insert into PartInstance (ID, PartType, condition) values (85, '19', 'nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus');
insert into PartInstance (ID, PartType, condition) values (86, '11', 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue');
insert into PartInstance (ID, PartType, condition) values (87, '15', 'ipsum');
insert into PartInstance (ID, PartType, condition) values (88, '13', 'donec ut dolor');
insert into PartInstance (ID, PartType, condition) values (89, '16', 'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum');
insert into PartInstance (ID, PartType, condition) values (90, '7', 'nullam molestie nibh in lectus pellentesque at nulla');
insert into PartInstance (ID, PartType, condition) values (91, '10', 'sapien a libero nam dui proin leo odio');
insert into PartInstance (ID, PartType, condition) values (92, '12', 'felis ut at');
insert into PartInstance (ID, PartType, condition) values (93, '17', 'platea dictumst morbi vestibulum velit id pretium iaculis');
insert into PartInstance (ID, PartType, condition) values (94, '5', 'donec');
insert into PartInstance (ID, PartType, condition) values (95, '9', 'etiam');
insert into PartInstance (ID, PartType, condition) values (96, '3', 'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium');
insert into PartInstance (ID, PartType, condition) values (97, '6', 'posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet');
insert into PartInstance (ID, PartType, condition) values (98, '20', 'semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat');
insert into PartInstance (ID, PartType, condition) values (99, '8', 'fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat');
insert into PartInstance (ID, PartType, condition) values (100, '18', 'amet nulla quisque arcu');
insert into PartInstance (ID, PartType, condition) values (101, '7', 'ultrices');
insert into PartInstance (ID, PartType, condition) values (102, '8', 'dictumst aliquam augue quam sollicitudin vitae consectetuer');
insert into PartInstance (ID, PartType, condition) values (103, '9', 'luctus tincidunt nulla');
insert into PartInstance (ID, PartType, condition) values (104, '6', 'eu sapien cursus vestibulum proin eu mi nulla');
insert into PartInstance (ID, PartType, condition) values (105, '10', 'imperdiet nullam orci pede venenatis non sodales sed tincidunt');
insert into PartInstance (ID, PartType, condition) values (106, '14', 'hac habitasse');
insert into PartInstance (ID, PartType, condition) values (107, '3', 'fermentum donec ut mauris eget massa tempor convallis nulla neque');
insert into PartInstance (ID, PartType, condition) values (108, '16', 'rhoncus mauris enim leo rhoncus sed vestibulum sit');
insert into PartInstance (ID, PartType, condition) values (109, '1', 'ligula vehicula consequat morbi a ipsum integer a nibh');
insert into PartInstance (ID, PartType, condition) values (110, '15', 'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac');
insert into PartInstance (ID, PartType, condition) values (111, '11', 'varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci');
insert into PartInstance (ID, PartType, condition) values (112, '20', 'accumsan tortor');
insert into PartInstance (ID, PartType, condition) values (113, '12', 'sem mauris laoreet ut rhoncus aliquet pulvinar sed');
insert into PartInstance (ID, PartType, condition) values (114, '5', 'tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis');
insert into PartInstance (ID, PartType, condition) values (115, '18', 'odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras');
insert into PartInstance (ID, PartType, condition) values (116, '13', 'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas');
insert into PartInstance (ID, PartType, condition) values (117, '17', 'varius');
insert into PartInstance (ID, PartType, condition) values (118, '4', 'primis in faucibus orci luctus');
insert into PartInstance (ID, PartType, condition) values (119, '19', 'velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros');
insert into PartInstance (ID, PartType, condition) values (120, '2', 'elit');
insert into PartInstance (ID, PartType, condition) values (121, '2', 'at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat');
insert into PartInstance (ID, PartType, condition) values (122, '5', 'erat eros viverra eget');
insert into PartInstance (ID, PartType, condition) values (123, '12', 'leo');
insert into PartInstance (ID, PartType, condition) values (124, '13', 'proin risus praesent lectus vestibulum quam sapien');
insert into PartInstance (ID, PartType, condition) values (125, '6', 'nulla ultrices aliquet maecenas leo odio');
insert into PartInstance (ID, PartType, condition) values (126, '15', 'in hac habitasse platea dictumst aliquam augue');
insert into PartInstance (ID, PartType, condition) values (127, '19', 'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor');
insert into PartInstance (ID, PartType, condition) values (128, '11', 'mi nulla ac enim in tempor turpis nec euismod scelerisque quam');
insert into PartInstance (ID, PartType, condition) values (129, '10', 'ut suscipit a');
insert into PartInstance (ID, PartType, condition) values (130, '17', 'justo');
insert into PartInstance (ID, PartType, condition) values (131, '1', 'rutrum ac lobortis');
insert into PartInstance (ID, PartType, condition) values (132, '14', 'ac diam cras pellentesque volutpat dui maecenas tristique est');
insert into PartInstance (ID, PartType, condition) values (133, '16', 'enim sit amet nunc viverra dapibus nulla suscipit');
insert into PartInstance (ID, PartType, condition) values (134, '20', 'augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec');
insert into PartInstance (ID, PartType, condition) values (135, '4', 'sollicitudin mi sit amet lobortis sapien sapien non mi integer');
insert into PartInstance (ID, PartType, condition) values (136, '18', 'in quis justo');
insert into PartInstance (ID, PartType, condition) values (137, '3', 'non');
insert into PartInstance (ID, PartType, condition) values (138, '8', 'aliquam erat volutpat in congue');
insert into PartInstance (ID, PartType, condition) values (139, '9', 'curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam');
insert into PartInstance (ID, PartType, condition) values (140, '7', 'luctus cum sociis natoque');
insert into PartInstance (ID, PartType, condition) values (141, '13', 'posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam');
insert into PartInstance (ID, PartType, condition) values (142, '7', 'diam cras pellentesque volutpat dui');
insert into PartInstance (ID, PartType, condition) values (143, '10', 'quis lectus suspendisse potenti in eleifend quam a odio in hac');
insert into PartInstance (ID, PartType, condition) values (144, '5', 'ut odio cras mi pede malesuada in imperdiet et commodo vulputate');
insert into PartInstance (ID, PartType, condition) values (145, '8', 'nulla');
insert into PartInstance (ID, PartType, condition) values (146, '17', 'viverra diam vitae quam suspendisse');
insert into PartInstance (ID, PartType, condition) values (147, '11', 'aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede');
insert into PartInstance (ID, PartType, condition) values (148, '9', 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non');
insert into PartInstance (ID, PartType, condition) values (149, '12', 'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus');
insert into PartInstance (ID, PartType, condition) values (150, '15', 'aliquam convallis');
insert into PartInstance (ID, PartType, condition) values (151, '18', 'tellus nulla ut erat id mauris');
insert into PartInstance (ID, PartType, condition) values (152, '19', 'rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus');
insert into PartInstance (ID, PartType, condition) values (153, '1', 'posuere cubilia curae');
insert into PartInstance (ID, PartType, condition) values (154, '16', 'non mi integer ac neque duis bibendum morbi non quam nec dui luctus');
insert into PartInstance (ID, PartType, condition) values (155, '4', 'tristique est et tempus semper est quam pharetra magna ac consequat metus');
insert into PartInstance (ID, PartType, condition) values (156, '6', 'elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit');
insert into PartInstance (ID, PartType, condition) values (157, '14', 'vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam');
insert into PartInstance (ID, PartType, condition) values (158, '2', 'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero');
insert into PartInstance (ID, PartType, condition) values (159, '20', 'sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium');
insert into PartInstance (ID, PartType, condition) values (160, '3', 'adipiscing elit proin risus praesent lectus vestibulum');
insert into PartInstance (ID, PartType, condition) values (161, '14', 'nulla justo');
insert into PartInstance (ID, PartType, condition) values (162, '4', 'metus vitae ipsum aliquam non mauris');
insert into PartInstance (ID, PartType, condition) values (163, '6', 'pede venenatis non sodales');
insert into PartInstance (ID, PartType, condition) values (164, '10', 'sed vel enim sit amet nunc viverra dapibus nulla');
insert into PartInstance (ID, PartType, condition) values (165, '19', 'libero ut massa volutpat convallis morbi odio odio elementum eu');
insert into PartInstance (ID, PartType, condition) values (166, '12', 'rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into PartInstance (ID, PartType, condition) values (167, '17', 'ut mauris eget massa tempor convallis nulla neque libero');
insert into PartInstance (ID, PartType, condition) values (168, '15', 'iaculis congue vivamus metus arcu');
insert into PartInstance (ID, PartType, condition) values (169, '7', 'neque');
insert into PartInstance (ID, PartType, condition) values (170, '16', 'sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus');
insert into PartInstance (ID, PartType, condition) values (171, '18', 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id');
insert into PartInstance (ID, PartType, condition) values (172, '9', 'congue');
insert into PartInstance (ID, PartType, condition) values (173, '11', 'consequat nulla nisl nunc nisl duis bibendum felis sed interdum');
insert into PartInstance (ID, PartType, condition) values (174, '5', 'mauris');
insert into PartInstance (ID, PartType, condition) values (175, '20', 'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat');
insert into PartInstance (ID, PartType, condition) values (176, '8', 'vivamus in felis eu sapien cursus vestibulum proin eu');
insert into PartInstance (ID, PartType, condition) values (177, '2', 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac');
insert into PartInstance (ID, PartType, condition) values (178, '1', 'habitasse platea');
insert into PartInstance (ID, PartType, condition) values (179, '3', 'sed tristique in tempus sit amet sem fusce consequat nulla');
insert into PartInstance (ID, PartType, condition) values (180, '13', 'diam nam tristique');
insert into PartInstance (ID, PartType, condition) values (181, '14', 'id');
insert into PartInstance (ID, PartType, condition) values (182, '11', 'dapibus');
insert into PartInstance (ID, PartType, condition) values (183, '7', 'nisl ut volutpat sapien arcu');
insert into PartInstance (ID, PartType, condition) values (184, '4', 'amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque');
insert into PartInstance (ID, PartType, condition) values (185, '3', 'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo');
insert into PartInstance (ID, PartType, condition) values (186, '9', 'vulputate ut ultrices vel augue');
insert into PartInstance (ID, PartType, condition) values (187, '20', 'dui maecenas tristique est et tempus semper est quam');
insert into PartInstance (ID, PartType, condition) values (188, '12', 'vehicula consequat morbi a ipsum integer a');
insert into PartInstance (ID, PartType, condition) values (189, '16', 'eros elementum pellentesque quisque porta');
insert into PartInstance (ID, PartType, condition) values (190, '2', 'sed augue aliquam erat volutpat in congue');
insert into PartInstance (ID, PartType, condition) values (191, '18', 'mauris sit');
insert into PartInstance (ID, PartType, condition) values (192, '19', 'justo eu massa donec dapibus duis at velit eu est congue elementum');
insert into PartInstance (ID, PartType, condition) values (193, '13', 'habitasse platea dictumst morbi vestibulum velit');
insert into PartInstance (ID, PartType, condition) values (194, '8', 'in est risus auctor sed tristique');
insert into PartInstance (ID, PartType, condition) values (195, '15', 'sit amet lobortis sapien sapien non');
insert into PartInstance (ID, PartType, condition) values (196, '6', 'porttitor pede justo');
insert into PartInstance (ID, PartType, condition) values (197, '5', 'ipsum primis in faucibus orci');
insert into PartInstance (ID, PartType, condition) values (198, '17', 'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum');
insert into PartInstance (ID, PartType, condition) values (199, '1', 'auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi');
insert into PartInstance (ID, PartType, condition) values (200, '10', 'accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend');
insert into PartInstance (ID, PartType, condition) values (201, '8', 'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus');
insert into PartInstance (ID, PartType, condition) values (202, '5', 'rhoncus dui vel sem sed sagittis nam');
insert into PartInstance (ID, PartType, condition) values (203, '17', 'suscipit nulla elit ac nulla sed vel enim sit amet nunc');
insert into PartInstance (ID, PartType, condition) values (204, '3', 'felis eu sapien cursus vestibulum proin eu mi nulla');
insert into PartInstance (ID, PartType, condition) values (205, '16', 'sed interdum');
insert into PartInstance (ID, PartType, condition) values (206, '14', 'mattis odio donec vitae nisi');
insert into PartInstance (ID, PartType, condition) values (207, '2', 'ipsum dolor sit amet');
insert into PartInstance (ID, PartType, condition) values (208, '11', 'curae nulla');
insert into PartInstance (ID, PartType, condition) values (209, '4', 'id ligula suspendisse');
insert into PartInstance (ID, PartType, condition) values (210, '12', 'nulla tempus vivamus in felis eu sapien cursus vestibulum');
insert into PartInstance (ID, PartType, condition) values (211, '9', 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum');
insert into PartInstance (ID, PartType, condition) values (212, '15', 'nisl');
insert into PartInstance (ID, PartType, condition) values (213, '20', 'interdum mauris non ligula pellentesque ultrices phasellus');
insert into PartInstance (ID, PartType, condition) values (214, '13', 'suspendisse potenti in eleifend quam a odio in hac habitasse');
insert into PartInstance (ID, PartType, condition) values (215, '18', 'bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui');
insert into PartInstance (ID, PartType, condition) values (216, '19', 'sem praesent id massa');
insert into PartInstance (ID, PartType, condition) values (217, '10', 'in magna bibendum imperdiet nullam orci pede');
insert into PartInstance (ID, PartType, condition) values (218, '6', 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet');
insert into PartInstance (ID, PartType, condition) values (219, '7', 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse');
insert into PartInstance (ID, PartType, condition) values (220, '1', 'donec');
insert into PartInstance (ID, PartType, condition) values (221, '3', 'volutpat erat quisque erat eros viverra eget congue');
insert into PartInstance (ID, PartType, condition) values (222, '19', 'suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis');
insert into PartInstance (ID, PartType, condition) values (223, '16', 'vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes');
insert into PartInstance (ID, PartType, condition) values (224, '17', 'rutrum rutrum');
insert into PartInstance (ID, PartType, condition) values (225, '12', 'cras non velit nec nisi vulputate nonummy maecenas');
insert into PartInstance (ID, PartType, condition) values (226, '20', 'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie');
insert into PartInstance (ID, PartType, condition) values (227, '2', 'volutpat');
insert into PartInstance (ID, PartType, condition) values (228, '15', 'sed interdum venenatis turpis enim blandit mi in porttitor pede');
insert into PartInstance (ID, PartType, condition) values (229, '18', 'integer pede justo lacinia eget tincidunt eget');
insert into PartInstance (ID, PartType, condition) values (230, '13', 'natoque penatibus et magnis dis parturient');
insert into PartInstance (ID, PartType, condition) values (231, '9', 'nullam sit amet turpis elementum ligula vehicula consequat morbi a');
insert into PartInstance (ID, PartType, condition) values (232, '8', 'suspendisse potenti in eleifend quam a odio in hac');
insert into PartInstance (ID, PartType, condition) values (233, '14', 'elit proin interdum mauris non ligula pellentesque ultrices phasellus id');
insert into PartInstance (ID, PartType, condition) values (234, '1', 'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat');
insert into PartInstance (ID, PartType, condition) values (235, '4', 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante');
insert into PartInstance (ID, PartType, condition) values (236, '5', 'commodo placerat praesent blandit nam nulla integer pede justo lacinia');
insert into PartInstance (ID, PartType, condition) values (237, '10', 'rhoncus dui vel sem sed');
insert into PartInstance (ID, PartType, condition) values (238, '7', 'sed accumsan felis ut at dolor quis');
insert into PartInstance (ID, PartType, condition) values (239, '11', 'hac habitasse platea dictumst etiam faucibus cursus urna ut');
insert into PartInstance (ID, PartType, condition) values (240, '6', 'ipsum primis in faucibus orci luctus');
insert into PartInstance (ID, PartType, condition) values (241, '12', 'duis bibendum morbi non quam nec dui luctus rutrum nulla');
insert into PartInstance (ID, PartType, condition) values (242, '7', 'tristique in tempus sit');
insert into PartInstance (ID, PartType, condition) values (243, '14', 'massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque');
insert into PartInstance (ID, PartType, condition) values (244, '15', 'sed augue aliquam erat volutpat in congue');
insert into PartInstance (ID, PartType, condition) values (245, '5', 'erat nulla');
insert into PartInstance (ID, PartType, condition) values (246, '9', 'sit amet consectetuer adipiscing');
insert into PartInstance (ID, PartType, condition) values (247, '18', 'tortor risus dapibus augue vel');
insert into PartInstance (ID, PartType, condition) values (248, '19', 'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh');
insert into PartInstance (ID, PartType, condition) values (249, '16', 'iaculis');
insert into PartInstance (ID, PartType, condition) values (250, '13', 'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel');
insert into PartInstance (ID, PartType, condition) values (251, '17', 'hac habitasse platea dictumst');
insert into PartInstance (ID, PartType, condition) values (252, '2', 'ligula nec sem duis aliquam convallis nunc proin at turpis');
insert into PartInstance (ID, PartType, condition) values (253, '11', 'pellentesque eget nunc donec');
insert into PartInstance (ID, PartType, condition) values (254, '20', 'dictumst etiam faucibus');
insert into PartInstance (ID, PartType, condition) values (255, '10', 'suspendisse accumsan tortor quis');
insert into PartInstance (ID, PartType, condition) values (256, '4', 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in');
insert into PartInstance (ID, PartType, condition) values (257, '6', 'in magna bibendum imperdiet nullam orci pede venenatis');
insert into PartInstance (ID, PartType, condition) values (258, '1', 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh');
insert into PartInstance (ID, PartType, condition) values (259, '8', 'nisi at nibh in hac habitasse platea dictumst aliquam augue quam');
insert into PartInstance (ID, PartType, condition) values (260, '3', 'urna pretium');
insert into PartInstance (ID, PartType, condition) values (261, '7', 'nam dui');
insert into PartInstance (ID, PartType, condition) values (262, '18', 'purus phasellus in felis donec semper sapien');
insert into PartInstance (ID, PartType, condition) values (263, '4', 'tristique est et tempus');
insert into PartInstance (ID, PartType, condition) values (264, '6', 'nulla nunc purus phasellus in felis donec');
insert into PartInstance (ID, PartType, condition) values (265, '16', 'elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in');
insert into PartInstance (ID, PartType, condition) values (266, '9', 'proin leo odio porttitor id consequat in consequat ut');
insert into PartInstance (ID, PartType, condition) values (267, '14', 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices');
insert into PartInstance (ID, PartType, condition) values (268, '5', 'tempus vivamus in');
insert into PartInstance (ID, PartType, condition) values (269, '2', 'erat id mauris vulputate elementum nullam varius nulla facilisi cras');
insert into PartInstance (ID, PartType, condition) values (270, '10', 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula');
insert into PartInstance (ID, PartType, condition) values (271, '11', 'eleifend luctus ultricies eu nibh');
insert into PartInstance (ID, PartType, condition) values (272, '8', 'iaculis congue');
insert into PartInstance (ID, PartType, condition) values (273, '1', 'ultrices posuere cubilia curae donec pharetra magna vestibulum');
insert into PartInstance (ID, PartType, condition) values (274, '15', 'commodo placerat praesent blandit nam');
insert into PartInstance (ID, PartType, condition) values (275, '17', 'integer');
insert into PartInstance (ID, PartType, condition) values (276, '3', 'blandit lacinia erat vestibulum sed magna at');
insert into PartInstance (ID, PartType, condition) values (277, '19', 'dapibus');
insert into PartInstance (ID, PartType, condition) values (278, '13', 'in est risus');
insert into PartInstance (ID, PartType, condition) values (279, '12', 'mattis egestas metus');
insert into PartInstance (ID, PartType, condition) values (280, '20', 'quis orci eget orci vehicula condimentum curabitur in');
insert into PartInstance (ID, PartType, condition) values (281, '20', 'in hac habitasse platea dictumst maecenas ut massa quis augue luctus');
insert into PartInstance (ID, PartType, condition) values (282, '18', 'tempus vel pede morbi porttitor');
insert into PartInstance (ID, PartType, condition) values (283, '4', 'volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus');
insert into PartInstance (ID, PartType, condition) values (284, '6', 'metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque');
insert into PartInstance (ID, PartType, condition) values (285, '11', 'ac est lacinia nisi venenatis tristique fusce congue diam');
insert into PartInstance (ID, PartType, condition) values (286, '1', 'volutpat erat quisque erat eros viverra');
insert into PartInstance (ID, PartType, condition) values (287, '13', 'praesent blandit lacinia erat vestibulum sed magna at nunc commodo');
insert into PartInstance (ID, PartType, condition) values (288, '9', 'est et tempus semper');
insert into PartInstance (ID, PartType, condition) values (289, '3', 'ipsum ac');
insert into PartInstance (ID, PartType, condition) values (290, '15', 'in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu');
insert into PartInstance (ID, PartType, condition) values (291, '19', 'pellentesque eget nunc donec quis orci');
insert into PartInstance (ID, PartType, condition) values (292, '12', 'nulla sed accumsan felis ut at');
insert into PartInstance (ID, PartType, condition) values (293, '17', 'facilisi cras non velit nec nisi vulputate nonummy');
insert into PartInstance (ID, PartType, condition) values (294, '2', 'sapien ut nunc vestibulum');
insert into PartInstance (ID, PartType, condition) values (295, '7', 'curae nulla dapibus dolor vel');
insert into PartInstance (ID, PartType, condition) values (296, '5', 'tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec');
insert into PartInstance (ID, PartType, condition) values (297, '14', 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi');
insert into PartInstance (ID, PartType, condition) values (298, '10', 'mus etiam vel');
insert into PartInstance (ID, PartType, condition) values (299, '8', 'morbi vestibulum velit id');
insert into PartInstance (ID, PartType, condition) values (300, '16', 'sit amet justo morbi ut odio cras mi pede malesuada');
insert into PartInstance (ID, PartType, condition) values (301, '1', 'vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit');
insert into PartInstance (ID, PartType, condition) values (302, '3', 'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et');
insert into PartInstance (ID, PartType, condition) values (303, '11', 'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non');
insert into PartInstance (ID, PartType, condition) values (304, '12', 'sapien a libero nam dui proin leo odio porttitor id');
insert into PartInstance (ID, PartType, condition) values (305, '15', 'velit vivamus vel nulla eget');
insert into PartInstance (ID, PartType, condition) values (306, '2', 'consectetuer adipiscing elit proin interdum');
insert into PartInstance (ID, PartType, condition) values (307, '13', 'magna bibendum imperdiet nullam');
insert into PartInstance (ID, PartType, condition) values (308, '17', 'natoque penatibus et magnis dis parturient montes nascetur');
insert into PartInstance (ID, PartType, condition) values (309, '18', 'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh');
insert into PartInstance (ID, PartType, condition) values (310, '7', 'id mauris vulputate elementum nullam varius');
insert into PartInstance (ID, PartType, condition) values (311, '16', 'eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu');
insert into PartInstance (ID, PartType, condition) values (312, '10', 'nunc proin at turpis a pede posuere nonummy integer non velit');
insert into PartInstance (ID, PartType, condition) values (313, '20', 'amet justo morbi ut odio');
insert into PartInstance (ID, PartType, condition) values (314, '9', 'neque vestibulum eget vulputate ut');
insert into PartInstance (ID, PartType, condition) values (315, '8', 'quis turpis eget elit sodales scelerisque mauris sit amet eros');
insert into PartInstance (ID, PartType, condition) values (316, '6', 'nunc donec quis');
insert into PartInstance (ID, PartType, condition) values (317, '5', 'cursus id');
insert into PartInstance (ID, PartType, condition) values (318, '14', 'est et tempus semper est quam pharetra magna');
insert into PartInstance (ID, PartType, condition) values (319, '4', 'convallis morbi odio odio elementum eu interdum eu tincidunt in');
insert into PartInstance (ID, PartType, condition) values (320, '19', 'enim leo rhoncus sed vestibulum sit amet cursus id turpis integer');
insert into PartInstance (ID, PartType, condition) values (321, '10', 'nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae');
insert into PartInstance (ID, PartType, condition) values (322, '12', 'aliquet ultrices erat tortor sollicitudin mi sit amet');
insert into PartInstance (ID, PartType, condition) values (323, '20', 'posuere cubilia curae mauris');
insert into PartInstance (ID, PartType, condition) values (324, '17', 'sem praesent id massa id nisl venenatis lacinia aenean');
insert into PartInstance (ID, PartType, condition) values (325, '18', 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue');
insert into PartInstance (ID, PartType, condition) values (326, '4', 'purus aliquet');
insert into PartInstance (ID, PartType, condition) values (327, '14', 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget');
insert into PartInstance (ID, PartType, condition) values (328, '8', 'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce');
insert into PartInstance (ID, PartType, condition) values (329, '5', 'amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur');
insert into PartInstance (ID, PartType, condition) values (330, '2', 'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor');
insert into PartInstance (ID, PartType, condition) values (331, '1', 'massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea');
insert into PartInstance (ID, PartType, condition) values (332, '3', 'nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit');
insert into PartInstance (ID, PartType, condition) values (333, '16', 'sed magna at nunc commodo placerat praesent');
insert into PartInstance (ID, PartType, condition) values (334, '6', 'id nisl venenatis lacinia aenean');
insert into PartInstance (ID, PartType, condition) values (335, '9', 'sem sed sagittis nam congue');
insert into PartInstance (ID, PartType, condition) values (336, '13', 'vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque');
insert into PartInstance (ID, PartType, condition) values (337, '11', 'enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet');
insert into PartInstance (ID, PartType, condition) values (338, '15', 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi');
insert into PartInstance (ID, PartType, condition) values (339, '7', 'odio odio elementum eu interdum eu');
insert into PartInstance (ID, PartType, condition) values (340, '19', 'sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat');
insert into PartInstance (ID, PartType, condition) values (341, '18', 'fermentum donec ut mauris eget massa tempor convallis nulla');
insert into PartInstance (ID, PartType, condition) values (342, '13', 'lobortis est phasellus sit amet erat nulla tempus vivamus in felis');
insert into PartInstance (ID, PartType, condition) values (343, '11', 'morbi vestibulum velit id pretium iaculis diam erat');
insert into PartInstance (ID, PartType, condition) values (344, '8', 'amet justo morbi');
insert into PartInstance (ID, PartType, condition) values (345, '4', 'placerat ante nulla justo aliquam quis');
insert into PartInstance (ID, PartType, condition) values (346, '9', 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede');
insert into PartInstance (ID, PartType, condition) values (347, '17', 'tempor turpis nec euismod');
insert into PartInstance (ID, PartType, condition) values (348, '2', 'suspendisse potenti in eleifend');
insert into PartInstance (ID, PartType, condition) values (349, '1', 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum');
insert into PartInstance (ID, PartType, condition) values (350, '6', 'in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio');
insert into PartInstance (ID, PartType, condition) values (351, '3', 'sapien urna pretium nisl ut');
insert into PartInstance (ID, PartType, condition) values (352, '16', 'eu sapien cursus vestibulum proin eu mi nulla');
insert into PartInstance (ID, PartType, condition) values (353, '10', 'nulla nunc purus phasellus in');
insert into PartInstance (ID, PartType, condition) values (354, '12', 'porttitor pede justo eu');
insert into PartInstance (ID, PartType, condition) values (355, '19', 'sit amet nulla quisque arcu libero');
insert into PartInstance (ID, PartType, condition) values (356, '20', 'ut blandit non interdum in ante vestibulum ante');
insert into PartInstance (ID, PartType, condition) values (357, '15', 'vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat');
insert into PartInstance (ID, PartType, condition) values (358, '14', 'ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh');
insert into PartInstance (ID, PartType, condition) values (359, '5', 'diam neque vestibulum eget vulputate');
insert into PartInstance (ID, PartType, condition) values (360, '7', 'lorem');
insert into PartInstance (ID, PartType, condition) values (361, '11', 'sit amet erat nulla tempus vivamus in felis eu sapien');
insert into PartInstance (ID, PartType, condition) values (362, '9', 'vestibulum sed magna at nunc');
insert into PartInstance (ID, PartType, condition) values (363, '1', 'ullamcorper');
insert into PartInstance (ID, PartType, condition) values (364, '6', 'morbi vel lectus');
insert into PartInstance (ID, PartType, condition) values (365, '8', 'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis');
insert into PartInstance (ID, PartType, condition) values (366, '12', 'aliquam lacus');
insert into PartInstance (ID, PartType, condition) values (367, '3', 'lobortis vel dapibus at diam nam tristique tortor eu');
insert into PartInstance (ID, PartType, condition) values (368, '7', 'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet');
insert into PartInstance (ID, PartType, condition) values (369, '10', 'porta volutpat quam pede lobortis ligula sit amet eleifend pede');
insert into PartInstance (ID, PartType, condition) values (370, '17', 'ullamcorper purus sit amet nulla quisque arcu libero rutrum');
insert into PartInstance (ID, PartType, condition) values (371, '20', 'nulla sed accumsan felis ut at dolor quis');
insert into PartInstance (ID, PartType, condition) values (372, '18', 'quam pede lobortis ligula sit amet eleifend');
insert into PartInstance (ID, PartType, condition) values (373, '13', 'cras in purus eu magna vulputate luctus cum sociis natoque penatibus');
insert into PartInstance (ID, PartType, condition) values (374, '16', 'amet consectetuer adipiscing');
insert into PartInstance (ID, PartType, condition) values (375, '5', 'ut blandit non interdum in ante vestibulum ante');
insert into PartInstance (ID, PartType, condition) values (376, '4', 'sapien');
insert into PartInstance (ID, PartType, condition) values (377, '19', 'cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into PartInstance (ID, PartType, condition) values (378, '14', 'nulla');
insert into PartInstance (ID, PartType, condition) values (379, '2', 'non interdum in ante vestibulum ante ipsum primis in faucibus');
insert into PartInstance (ID, PartType, condition) values (380, '15', 'massa id nisl venenatis lacinia aenean sit amet justo');
insert into PartInstance (ID, PartType, condition) values (381, '3', 'aliquam convallis nunc proin at turpis a pede posuere');
insert into PartInstance (ID, PartType, condition) values (382, '1', 'vulputate vitae nisl aenean lectus pellentesque eget');
insert into PartInstance (ID, PartType, condition) values (383, '15', 'sapien placerat ante');
insert into PartInstance (ID, PartType, condition) values (384, '16', 'faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur');
insert into PartInstance (ID, PartType, condition) values (385, '2', 'donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia');
insert into PartInstance (ID, PartType, condition) values (386, '12', 'dictumst');
insert into PartInstance (ID, PartType, condition) values (387, '18', 'nibh quisque id justo sit amet sapien');
insert into PartInstance (ID, PartType, condition) values (388, '11', 'massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in');
insert into PartInstance (ID, PartType, condition) values (389, '14', 'vivamus metus');
insert into PartInstance (ID, PartType, condition) values (390, '13', 'massa donec dapibus duis at velit eu est congue elementum in');
insert into PartInstance (ID, PartType, condition) values (391, '6', 'in ante vestibulum ante ipsum primis in faucibus');
insert into PartInstance (ID, PartType, condition) values (392, '9', 'nulla ut');
insert into PartInstance (ID, PartType, condition) values (393, '4', 'justo eu massa donec dapibus duis at velit eu est congue elementum');
insert into PartInstance (ID, PartType, condition) values (394, '8', 'magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into PartInstance (ID, PartType, condition) values (395, '17', 'metus vitae');
insert into PartInstance (ID, PartType, condition) values (396, '20', 'at lorem');
insert into PartInstance (ID, PartType, condition) values (397, '5', 'nunc rhoncus dui vel sem sed sagittis nam congue');
insert into PartInstance (ID, PartType, condition) values (398, '10', 'aliquet massa id lobortis convallis tortor risus dapibus augue vel');
insert into PartInstance (ID, PartType, condition) values (399, '7', 'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam');
insert into PartInstance (ID, PartType, condition) values (400, '19', 'a ipsum integer a nibh in quis justo');
insert into PartInstance (ID, PartType, condition) values (401, '14', 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi');
insert into PartInstance (ID, PartType, condition) values (402, '6', 'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae');
insert into PartInstance (ID, PartType, condition) values (403, '3', 'morbi non lectus aliquam sit amet diam in magna bibendum');
insert into PartInstance (ID, PartType, condition) values (404, '11', 'in est risus auctor sed tristique in tempus sit amet sem');
insert into PartInstance (ID, PartType, condition) values (405, '19', 'suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique');
insert into PartInstance (ID, PartType, condition) values (406, '17', 'praesent blandit');
insert into PartInstance (ID, PartType, condition) values (407, '20', 'viverra');
insert into PartInstance (ID, PartType, condition) values (408, '8', 'tellus nulla ut erat id mauris vulputate');
insert into PartInstance (ID, PartType, condition) values (409, '4', 'sapien a libero');
insert into PartInstance (ID, PartType, condition) values (410, '13', 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut');
insert into PartInstance (ID, PartType, condition) values (411, '12', 'proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien');
insert into PartInstance (ID, PartType, condition) values (412, '18', 'dolor vel est donec odio justo sollicitudin ut');
insert into PartInstance (ID, PartType, condition) values (413, '5', 'aliquam sit amet diam');
insert into PartInstance (ID, PartType, condition) values (414, '2', 'dui vel sem sed sagittis nam congue risus');
insert into PartInstance (ID, PartType, condition) values (415, '16', 'id justo sit amet sapien dignissim vestibulum vestibulum ante');
insert into PartInstance (ID, PartType, condition) values (416, '9', 'nonummy maecenas tincidunt');
insert into PartInstance (ID, PartType, condition) values (417, '15', 'orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel');
insert into PartInstance (ID, PartType, condition) values (418, '10', 'amet');
insert into PartInstance (ID, PartType, condition) values (419, '7', 'eleifend quam a odio in hac habitasse platea dictumst');
insert into PartInstance (ID, PartType, condition) values (420, '1', 'odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit');
insert into PartInstance (ID, PartType, condition) values (421, '3', 'hac habitasse');
insert into PartInstance (ID, PartType, condition) values (422, '16', 'neque aenean auctor gravida sem praesent id massa id');
insert into PartInstance (ID, PartType, condition) values (423, '7', 'id turpis integer aliquet massa id');
insert into PartInstance (ID, PartType, condition) values (424, '10', 'suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit');
insert into PartInstance (ID, PartType, condition) values (425, '12', 'eget massa tempor convallis nulla neque libero convallis eget eleifend');
insert into PartInstance (ID, PartType, condition) values (426, '17', 'ut');
insert into PartInstance (ID, PartType, condition) values (427, '15', 'blandit non interdum in ante vestibulum ante ipsum');
insert into PartInstance (ID, PartType, condition) values (428, '4', 'ut blandit');
insert into PartInstance (ID, PartType, condition) values (429, '11', 'ut massa');
insert into PartInstance (ID, PartType, condition) values (430, '13', 'dis parturient');
insert into PartInstance (ID, PartType, condition) values (431, '14', 'cursus vestibulum proin eu mi nulla ac enim in tempor');
insert into PartInstance (ID, PartType, condition) values (432, '18', 'ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent');
insert into PartInstance (ID, PartType, condition) values (433, '1', 'eu');
insert into PartInstance (ID, PartType, condition) values (434, '5', 'vestibulum');
insert into PartInstance (ID, PartType, condition) values (435, '8', 'quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac');
insert into PartInstance (ID, PartType, condition) values (436, '19', 'duis bibendum morbi non quam nec dui luctus rutrum nulla');
insert into PartInstance (ID, PartType, condition) values (437, '2', 'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a');
insert into PartInstance (ID, PartType, condition) values (438, '9', 'ante nulla');
insert into PartInstance (ID, PartType, condition) values (439, '6', 'luctus et');
insert into PartInstance (ID, PartType, condition) values (440, '20', 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede');
insert into PartInstance (ID, PartType, condition) values (441, '8', 'diam id ornare imperdiet sapien urna pretium nisl ut volutpat');
insert into PartInstance (ID, PartType, condition) values (442, '19', 'aliquam quis');
insert into PartInstance (ID, PartType, condition) values (443, '3', 'nunc purus phasellus in');
insert into PartInstance (ID, PartType, condition) values (444, '14', 'nascetur ridiculus mus etiam vel augue');
insert into PartInstance (ID, PartType, condition) values (445, '18', 'nulla ut erat id mauris vulputate elementum nullam');
insert into PartInstance (ID, PartType, condition) values (446, '6', 'curabitur convallis duis');
insert into PartInstance (ID, PartType, condition) values (447, '15', 'mauris morbi non lectus aliquam');
insert into PartInstance (ID, PartType, condition) values (448, '2', 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet');
insert into PartInstance (ID, PartType, condition) values (449, '1', 'parturient montes nascetur ridiculus mus etiam vel');
insert into PartInstance (ID, PartType, condition) values (450, '12', 'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien');
insert into PartInstance (ID, PartType, condition) values (451, '9', 'vestibulum eget vulputate ut');
insert into PartInstance (ID, PartType, condition) values (452, '17', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci');
insert into PartInstance (ID, PartType, condition) values (453, '10', 'aliquam erat');
insert into PartInstance (ID, PartType, condition) values (454, '13', 'ut erat curabitur gravida nisi');
insert into PartInstance (ID, PartType, condition) values (455, '16', 'aliquet massa id lobortis convallis tortor');
insert into PartInstance (ID, PartType, condition) values (456, '7', 'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla');
insert into PartInstance (ID, PartType, condition) values (457, '11', 'posuere nonummy integer');
insert into PartInstance (ID, PartType, condition) values (458, '5', 'nulla ultrices aliquet');
insert into PartInstance (ID, PartType, condition) values (459, '20', 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper');
insert into PartInstance (ID, PartType, condition) values (460, '4', 'dui nec nisi volutpat eleifend');
insert into PartInstance (ID, PartType, condition) values (461, '8', 'quis odio');
insert into PartInstance (ID, PartType, condition) values (462, '12', 'vestibulum aliquet ultrices');
insert into PartInstance (ID, PartType, condition) values (463, '7', 'luctus et ultrices posuere cubilia curae mauris');
insert into PartInstance (ID, PartType, condition) values (464, '1', 'morbi odio odio elementum eu interdum eu');
insert into PartInstance (ID, PartType, condition) values (465, '6', 'nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget');
insert into PartInstance (ID, PartType, condition) values (466, '5', 'quis odio consequat varius integer ac leo');
insert into PartInstance (ID, PartType, condition) values (467, '20', 'nulla quisque arcu libero');
insert into PartInstance (ID, PartType, condition) values (468, '14', 'ut blandit');
insert into PartInstance (ID, PartType, condition) values (469, '13', 'non sodales sed tincidunt eu');
insert into PartInstance (ID, PartType, condition) values (470, '16', 'duis at velit eu est congue elementum in hac habitasse platea');
insert into PartInstance (ID, PartType, condition) values (471, '19', 'molestie lorem quisque ut erat curabitur gravida nisi');
insert into PartInstance (ID, PartType, condition) values (472, '11', 'elementum ligula vehicula consequat morbi a ipsum');
insert into PartInstance (ID, PartType, condition) values (473, '4', 'elementum nullam varius nulla facilisi');
insert into PartInstance (ID, PartType, condition) values (474, '3', 'aliquet ultrices erat tortor sollicitudin mi');
insert into PartInstance (ID, PartType, condition) values (475, '17', 'mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices');
insert into PartInstance (ID, PartType, condition) values (476, '18', 'dui proin leo');
insert into PartInstance (ID, PartType, condition) values (477, '9', 'congue diam id ornare imperdiet sapien urna pretium nisl ut');
insert into PartInstance (ID, PartType, condition) values (478, '10', 'nibh in hac habitasse');
insert into PartInstance (ID, PartType, condition) values (479, '2', 'fusce lacus purus aliquet at');
insert into PartInstance (ID, PartType, condition) values (480, '15', 'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio');
insert into PartInstance (ID, PartType, condition) values (481, '17', 'cum sociis natoque penatibus');
insert into PartInstance (ID, PartType, condition) values (482, '1', 'id lobortis convallis tortor risus dapibus augue vel');
insert into PartInstance (ID, PartType, condition) values (483, '6', 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et');
insert into PartInstance (ID, PartType, condition) values (484, '14', 'non mauris morbi non lectus aliquam sit amet diam');
insert into PartInstance (ID, PartType, condition) values (485, '12', 'euismod scelerisque quam');
insert into PartInstance (ID, PartType, condition) values (486, '9', 'vulputate luctus cum sociis natoque penatibus et magnis dis');
insert into PartInstance (ID, PartType, condition) values (487, '3', 'in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum');
insert into PartInstance (ID, PartType, condition) values (488, '7', 'porta');
insert into PartInstance (ID, PartType, condition) values (489, '5', 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at');
insert into PartInstance (ID, PartType, condition) values (490, '13', 'risus dapibus augue');
insert into PartInstance (ID, PartType, condition) values (491, '15', 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa');
insert into PartInstance (ID, PartType, condition) values (492, '10', 'ornare imperdiet sapien urna pretium nisl ut');
insert into PartInstance (ID, PartType, condition) values (493, '2', 'id consequat in consequat ut');
insert into PartInstance (ID, PartType, condition) values (494, '20', 'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at');
insert into PartInstance (ID, PartType, condition) values (495, '19', 'in purus eu magna vulputate luctus cum sociis natoque');
insert into PartInstance (ID, PartType, condition) values (496, '16', 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien');
insert into PartInstance (ID, PartType, condition) values (497, '11', 'phasellus in felis donec semper sapien a libero nam dui proin leo');
insert into PartInstance (ID, PartType, condition) values (498, '18', 'justo maecenas rhoncus aliquam lacus morbi');
insert into PartInstance (ID, PartType, condition) values (499, '8', 'phasellus id sapien in');
insert into PartInstance (ID, PartType, condition) values (500, '4', 'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris');

-- SELECT * FROM PartInstance;

-- DataScoop_PartInstance
-- Data generated with mockaroo
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '92', '2024-01-08 04:16:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '470', '2023-06-10 09:35:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '205', '2023-02-15 14:33:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '121', '2023-12-29 04:24:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '126', '2023-07-21 08:55:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '24', '2023-06-22 03:58:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '368', '2024-02-05 08:50:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '398', '2023-01-30 09:31:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '409', '2023-06-16 19:32:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '8', '2023-02-24 04:23:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '245', '2023-01-18 15:20:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '57', '2023-09-11 09:14:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '492', '2023-12-21 18:57:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '461', '2023-10-31 21:22:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '196', '2023-08-11 03:24:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '376', '2023-03-14 16:10:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '60', '2024-03-12 16:58:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '157', '2024-02-09 19:21:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '206', '2023-02-17 13:29:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '266', '2023-12-30 17:04:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '276', '2023-04-06 08:27:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '170', '2023-04-17 01:18:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '343', '2024-03-23 00:50:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '377', '2023-04-23 05:59:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '396', '2024-04-08 11:59:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '297', '2024-02-29 23:44:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '446', '2023-09-25 02:23:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '67', '2023-08-04 15:50:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '124', '2024-01-05 09:40:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '96', '2023-12-09 19:32:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '495', '2024-02-24 00:02:01');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '436', '2024-03-30 01:01:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '37', '2024-04-28 19:52:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '40', '2023-09-14 01:30:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '379', '2023-07-06 18:45:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '235', '2023-08-23 19:09:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '299', '2023-03-06 18:46:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '469', '2023-05-31 15:11:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '374', '2023-03-24 04:07:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '162', '2023-06-18 06:45:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '175', '2023-05-20 22:17:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '294', '2024-01-23 09:53:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '350', '2023-08-28 07:48:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '156', '2023-09-04 16:22:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '295', '2024-06-18 23:53:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '216', '2024-01-25 00:27:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '308', '2023-09-03 08:17:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '98', '2024-05-16 21:18:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '234', '2024-03-08 14:26:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '76', '2024-01-21 23:26:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '94', '2023-01-05 02:47:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '277', '2023-08-26 05:43:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '63', '2024-03-29 13:33:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '311', '2023-01-19 20:47:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '41', '2023-12-14 23:22:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '473', '2023-02-11 16:22:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '444', '2023-02-28 00:24:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '418', '2024-02-05 04:10:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '491', '2023-05-27 19:15:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '149', '2023-07-05 00:48:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '282', '2023-04-23 23:38:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '482', '2024-03-30 04:55:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '224', '2023-08-05 09:44:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '17', '2023-10-31 19:23:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '12', '2024-05-14 07:00:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '79', '2023-06-14 12:52:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '58', '2024-06-29 08:16:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '254', '2023-01-13 04:33:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '273', '2023-01-19 02:23:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '388', '2023-10-23 05:37:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '319', '2023-01-20 17:56:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '255', '2023-05-14 00:32:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '433', '2023-10-28 12:51:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '468', '2024-03-25 04:19:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '203', '2023-04-10 23:47:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '152', '2024-06-20 21:13:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '189', '2023-12-31 09:34:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '359', '2023-07-26 17:14:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '139', '2023-05-06 06:02:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '113', '2023-10-25 11:00:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '321', '2023-12-01 03:52:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '241', '2024-01-28 10:46:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '246', '2023-05-22 00:37:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '239', '2024-03-12 05:00:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '452', '2024-02-01 16:57:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '240', '2023-09-12 17:52:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '38', '2024-05-13 16:41:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '75', '2023-10-12 08:31:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '249', '2023-05-20 09:48:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '81', '2024-06-02 19:14:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '232', '2024-04-05 22:13:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '324', '2023-12-06 20:57:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '115', '2023-01-11 07:49:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '244', '2023-02-26 21:54:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '44', '2023-02-23 19:03:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '411', '2024-03-08 16:40:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '238', '2023-07-12 17:18:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '309', '2023-03-05 23:36:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '180', '2023-08-03 02:16:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '363', '2024-01-30 14:25:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '314', '2023-12-26 18:21:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '56', '2023-03-09 16:55:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '110', '2024-03-13 10:25:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '451', '2023-12-11 04:44:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '214', '2023-12-16 03:38:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '158', '2023-08-05 23:25:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '415', '2023-07-03 14:52:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '220', '2023-10-12 03:36:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '21', '2023-04-26 06:22:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '150', '2023-10-29 05:03:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '31', '2024-05-24 11:01:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '484', '2024-05-02 01:27:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '306', '2023-02-09 00:18:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '456', '2023-12-24 14:40:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '476', '2023-02-04 08:25:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '101', '2024-02-10 04:35:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '265', '2023-02-07 17:59:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '3', '2023-10-29 06:24:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '283', '2023-10-31 23:35:01');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '43', '2024-05-05 07:27:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '28', '2023-03-18 01:40:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '23', '2023-11-27 09:49:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '380', '2023-08-05 13:30:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '103', '2023-04-17 04:20:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '351', '2023-01-18 20:36:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '349', '2023-01-21 18:47:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '481', '2024-06-05 12:15:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '200', '2023-02-19 04:06:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '208', '2023-05-09 11:32:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '160', '2024-06-15 18:23:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '406', '2023-08-27 19:30:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '333', '2023-04-25 22:27:01');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '362', '2024-02-10 12:50:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '163', '2024-03-07 23:51:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '414', '2023-08-03 06:58:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '373', '2023-01-18 18:02:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '275', '2023-07-24 21:12:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '391', '2023-10-06 23:17:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '182', '2023-01-19 16:56:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '356', '2024-01-30 15:20:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '402', '2023-01-18 06:27:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '15', '2024-02-18 19:45:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '263', '2023-06-17 06:03:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '426', '2023-02-27 12:27:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '192', '2024-01-24 20:48:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '416', '2024-05-07 13:26:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '447', '2024-02-05 13:42:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '252', '2023-06-15 06:56:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '440', '2024-01-20 06:31:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '466', '2023-10-13 01:58:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '51', '2023-03-23 16:42:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '264', '2023-09-20 03:31:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '339', '2024-06-23 03:21:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '300', '2023-05-29 18:21:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '487', '2024-06-15 19:57:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '357', '2023-05-14 17:45:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '168', '2024-02-02 18:12:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '390', '2023-11-02 23:36:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '202', '2023-10-27 08:31:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '302', '2024-04-11 15:53:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '155', '2024-01-21 12:18:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '490', '2024-01-30 23:44:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '36', '2024-05-03 03:17:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '185', '2024-05-01 04:29:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '316', '2023-02-13 14:05:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '372', '2024-03-20 05:43:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '117', '2023-12-14 07:25:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '364', '2024-05-17 04:03:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '429', '2023-04-05 06:42:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '382', '2024-05-12 06:32:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '219', '2023-06-27 12:14:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '42', '2023-01-31 04:24:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '10', '2023-03-06 09:39:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '467', '2023-10-19 01:24:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '100', '2024-03-01 21:52:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '141', '2023-04-11 01:42:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '341', '2023-02-09 05:49:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '11', '2023-11-10 06:48:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '307', '2023-09-28 13:10:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '129', '2023-09-12 11:10:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '404', '2024-05-07 01:04:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '360', '2023-07-25 04:01:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '47', '2024-05-08 13:52:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '334', '2024-03-05 08:26:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '166', '2023-04-03 12:19:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '400', '2023-08-09 08:58:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '292', '2024-01-07 06:55:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '176', '2023-03-06 00:37:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '397', '2023-03-21 10:18:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '73', '2024-06-10 11:16:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '304', '2024-03-13 05:41:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '68', '2024-01-09 22:23:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '102', '2024-05-05 11:40:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '108', '2024-06-21 02:12:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '159', '2024-02-23 03:43:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '30', '2023-12-11 03:54:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '71', '2023-03-19 19:48:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '133', '2023-09-02 04:39:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '112', '2024-03-21 05:15:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '248', '2023-07-11 15:06:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '353', '2023-07-23 17:19:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '497', '2023-12-09 20:54:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '449', '2024-01-07 15:09:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '438', '2023-09-14 08:35:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '428', '2024-06-28 18:14:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '65', '2023-03-20 16:35:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '118', '2024-05-05 13:06:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '463', '2023-11-29 16:25:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '318', '2024-06-01 20:20:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '278', '2024-03-25 13:54:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '52', '2023-11-01 09:56:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '332', '2023-11-03 10:27:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '367', '2024-04-21 15:39:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '64', '2023-06-22 21:34:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '322', '2023-07-14 10:32:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '26', '2023-08-18 17:30:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '293', '2023-10-15 08:22:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '89', '2023-01-17 23:13:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '151', '2023-03-07 08:34:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '281', '2023-03-07 21:48:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '50', '2024-05-07 14:12:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '18', '2024-06-05 09:38:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '486', '2024-02-07 11:51:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '271', '2024-02-13 00:50:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '269', '2023-06-12 06:08:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '32', '2024-04-01 10:06:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '99', '2023-04-03 05:22:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '323', '2024-05-05 03:09:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '408', '2023-02-10 00:29:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '258', '2024-03-25 16:50:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '138', '2023-08-24 01:41:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '313', '2024-05-11 14:02:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '184', '2024-03-15 20:11:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '288', '2023-07-01 01:12:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '488', '2023-12-02 23:09:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '448', '2024-06-28 12:09:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '242', '2023-10-26 13:56:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '257', '2023-03-04 14:54:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '217', '2023-11-28 11:37:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '48', '2023-02-09 20:10:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '227', '2023-10-28 11:17:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '194', '2023-11-10 17:31:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '6', '2023-09-06 15:33:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '262', '2023-07-26 12:00:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '340', '2023-09-14 22:27:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '164', '2023-05-29 03:31:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '346', '2023-02-22 19:57:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '284', '2024-02-11 07:36:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '147', '2023-10-09 07:52:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '229', '2023-09-23 21:56:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '457', '2023-07-09 17:39:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '272', '2024-06-24 14:47:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '344', '2024-03-20 21:47:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '14', '2023-11-25 09:40:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '383', '2023-02-24 10:45:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '424', '2023-05-05 06:19:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '61', '2024-04-09 06:56:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '489', '2024-04-09 02:08:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '223', '2023-03-24 06:24:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '127', '2023-02-17 11:07:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '329', '2024-05-26 18:30:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '135', '2023-01-07 23:02:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '443', '2023-05-11 04:24:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '259', '2023-05-26 20:03:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '225', '2023-01-13 18:33:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '172', '2023-06-24 02:45:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '347', '2024-06-26 03:44:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '405', '2024-04-19 21:06:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '87', '2023-06-12 20:11:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '413', '2023-12-07 14:24:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '161', '2023-10-22 17:41:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '39', '2023-10-23 15:30:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '77', '2024-06-14 10:26:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '191', '2023-04-05 15:35:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '352', '2024-05-04 12:55:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '142', '2023-11-09 22:03:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '477', '2023-12-13 12:15:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '29', '2023-11-18 04:08:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '338', '2023-09-17 10:06:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '337', '2023-03-13 07:56:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '9', '2023-01-29 07:26:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '366', '2023-06-28 03:51:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '326', '2023-07-11 08:38:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '80', '2023-03-20 01:04:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '336', '2024-01-15 11:03:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '287', '2023-04-29 19:40:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '312', '2023-05-31 17:07:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '423', '2024-05-29 18:34:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '62', '2023-03-03 09:34:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '407', '2024-03-17 23:13:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '132', '2023-10-01 13:04:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '401', '2024-06-28 06:01:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '354', '2023-12-09 21:57:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '111', '2023-09-22 04:52:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '348', '2023-12-23 01:19:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '460', '2023-05-05 17:50:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '434', '2023-09-18 19:20:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '4', '2023-09-06 23:40:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '22', '2023-04-25 20:49:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '471', '2023-12-14 04:07:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '25', '2024-02-12 17:59:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '134', '2023-06-19 20:22:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '393', '2023-03-04 08:30:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '233', '2023-11-08 01:31:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '370', '2023-03-11 08:23:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '410', '2023-02-02 23:58:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '83', '2024-02-19 10:23:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '231', '2023-05-15 17:52:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '91', '2023-03-11 06:41:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '7', '2023-07-08 01:48:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '425', '2023-12-10 09:35:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '320', '2024-04-08 07:32:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '399', '2023-02-19 19:27:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '165', '2024-04-22 09:03:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '144', '2023-04-12 22:42:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '454', '2023-11-09 03:08:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '342', '2023-11-22 03:36:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '325', '2024-02-10 09:35:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '422', '2023-02-09 11:41:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '250', '2023-08-18 05:24:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '206', '2023-03-14 13:14:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '279', '2024-05-03 09:53:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '355', '2024-06-08 13:52:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '345', '2023-11-29 09:42:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '153', '2023-12-16 03:31:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '358', '2024-05-07 04:15:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '136', '2024-01-26 03:37:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '496', '2024-02-07 05:44:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '482', '2023-06-10 07:32:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '445', '2023-03-20 02:21:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '481', '2024-04-21 14:08:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '483', '2024-02-05 17:53:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '91', '2023-02-21 02:04:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '147', '2023-01-30 09:15:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '298', '2023-03-29 21:52:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '462', '2023-05-08 05:29:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '116', '2023-11-28 01:56:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '392', '2024-04-20 08:00:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '301', '2023-04-28 04:04:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '303', '2023-10-22 00:16:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '371', '2023-07-06 19:10:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '61', '2023-02-18 13:08:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '374', '2023-10-01 22:58:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '150', '2023-11-07 06:23:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '278', '2023-02-10 22:43:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '40', '2023-01-09 09:06:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '400', '2023-09-26 20:46:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '200', '2023-06-02 17:09:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '390', '2023-08-07 06:03:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '424', '2024-04-22 09:07:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '466', '2024-04-14 17:49:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '68', '2023-08-22 15:13:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '275', '2023-11-25 21:40:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '356', '2024-01-30 10:07:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '149', '2023-12-17 22:29:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '283', '2023-02-16 01:01:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '15', '2023-05-25 03:47:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '319', '2024-03-23 16:36:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '253', '2024-02-11 13:15:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '373', '2024-04-22 02:39:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '126', '2024-04-05 02:10:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '259', '2023-04-03 10:39:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '432', '2024-02-15 02:56:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '361', '2024-02-14 16:48:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '3', '2023-04-25 01:19:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '442', '2023-08-17 20:32:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '49', '2023-02-03 13:50:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '59', '2023-08-02 16:42:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '16', '2023-03-06 11:57:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '133', '2024-06-12 02:15:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '137', '2023-02-01 09:08:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '452', '2023-07-04 06:44:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '327', '2023-04-13 11:51:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '17', '2024-05-15 16:21:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '53', '2023-08-19 20:07:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '118', '2023-07-18 12:03:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '26', '2023-06-30 21:00:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '181', '2024-05-20 14:48:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '344', '2024-06-28 23:39:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '414', '2023-03-24 01:11:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '249', '2023-08-12 12:36:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '367', '2023-06-08 23:32:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '21', '2024-02-17 15:30:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '113', '2023-08-15 07:12:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '351', '2024-04-02 04:46:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '234', '2024-01-19 03:33:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '423', '2023-04-29 22:43:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '379', '2023-11-21 08:06:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '243', '2023-04-02 22:44:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '450', '2023-04-23 06:39:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '222', '2023-06-27 05:19:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '144', '2023-01-25 01:37:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '174', '2024-02-28 17:38:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '312', '2023-08-07 20:05:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '193', '2023-08-12 14:14:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '92', '2024-02-27 13:36:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '359', '2023-10-03 01:37:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '377', '2023-01-14 10:13:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '287', '2024-06-28 04:34:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '289', '2023-12-26 05:44:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '166', '2024-04-03 13:08:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '413', '2023-01-22 18:22:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '34', '2023-06-30 07:26:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '293', '2023-02-07 04:19:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '172', '2023-12-19 08:52:01');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '223', '2023-03-02 11:45:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '79', '2023-12-04 03:07:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '215', '2024-02-24 00:48:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '119', '2024-06-17 17:48:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '364', '2024-02-28 06:05:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '184', '2023-07-14 16:43:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '418', '2024-06-04 05:14:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '382', '2023-07-25 22:05:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '311', '2023-01-07 20:15:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '217', '2023-05-17 03:04:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '6', '2023-04-27 02:35:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '120', '2023-04-07 11:42:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '146', '2024-05-29 10:55:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '239', '2023-10-09 16:38:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '230', '2023-11-16 15:22:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '109', '2023-06-03 07:52:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '93', '2023-11-21 01:51:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '115', '2024-01-31 01:17:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '179', '2023-06-10 23:35:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '87', '2023-09-08 06:37:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '270', '2023-05-14 11:46:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '36', '2023-12-10 11:05:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '322', '2023-05-10 16:37:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '288', '2023-07-21 01:49:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '44', '2023-12-03 09:10:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '321', '2023-04-03 17:53:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '205', '2024-03-22 13:16:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '81', '2023-08-06 22:31:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '139', '2023-02-07 03:57:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '190', '2023-03-16 15:04:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '31', '2024-05-13 22:13:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '330', '2024-02-13 12:27:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '488', '2023-02-25 02:20:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '194', '2023-09-09 21:16:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '472', '2024-06-28 06:09:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '238', '2024-01-08 00:07:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '297', '2024-03-11 12:07:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '228', '2024-04-04 03:00:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '338', '2024-03-18 09:00:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '5', '2024-01-17 04:32:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '407', '2023-08-24 09:21:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '211', '2023-02-09 08:15:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '326', '2023-09-20 18:32:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '456', '2024-01-29 03:40:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '464', '2023-11-20 05:47:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '188', '2024-04-13 07:06:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '286', '2023-05-29 15:15:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '316', '2023-05-21 23:31:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '4', '2024-05-19 13:59:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '255', '2023-01-14 15:04:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '465', '2024-04-23 06:06:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '9', '2023-03-13 16:14:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '56', '2023-08-15 05:12:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '42', '2024-02-05 00:35:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '69', '2023-12-30 08:47:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '388', '2023-03-03 11:41:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '273', '2024-02-25 20:10:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '437', '2023-11-22 19:56:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '492', '2024-01-09 07:23:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '52', '2023-07-03 12:20:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '216', '2023-05-11 10:21:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '484', '2024-04-10 09:23:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '11', '2024-06-03 16:23:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '7', '2023-03-01 18:46:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '421', '2023-07-09 22:54:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '425', '2024-01-20 01:40:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '132', '2023-04-18 23:07:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '300', '2023-12-10 02:48:23');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '64', '2023-08-18 18:48:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '77', '2024-05-25 01:10:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '33', '2023-01-08 14:06:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '434', '2024-04-18 18:10:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '455', '2024-06-09 12:01:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '384', '2023-06-01 11:44:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '104', '2023-05-11 10:49:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '489', '2023-04-02 14:32:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '208', '2023-03-03 18:43:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '135', '2024-06-23 03:13:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '176', '2024-05-24 06:43:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '85', '2023-10-11 21:39:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '111', '2024-01-20 02:08:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '341', '2023-02-17 14:23:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '20', '2023-01-27 20:58:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '467', '2024-03-31 23:00:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '244', '2023-07-15 12:20:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '236', '2023-01-06 23:05:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '158', '2024-03-02 12:09:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '203', '2023-03-20 02:27:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '334', '2023-10-30 20:40:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '114', '2023-04-04 09:13:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '247', '2024-01-30 16:35:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '225', '2024-06-14 07:35:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '473', '2023-03-10 10:34:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '164', '2023-04-08 15:54:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '170', '2023-06-29 08:33:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '189', '2023-07-17 10:33:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '232', '2024-05-25 12:19:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '264', '2023-06-14 03:03:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '420', '2024-02-20 03:55:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '375', '2023-08-04 15:49:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '262', '2023-04-16 22:04:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '83', '2023-09-26 02:15:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '329', '2023-02-01 21:22:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '435', '2023-04-13 23:17:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '463', '2024-04-11 07:20:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '65', '2023-11-06 00:34:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '461', '2023-03-08 11:54:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '178', '2024-06-04 00:10:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '143', '2023-08-27 17:43:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '76', '2024-02-25 20:40:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '383', '2024-06-11 00:47:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '192', '2023-06-09 14:59:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '436', '2023-06-29 21:46:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '380', '2023-07-28 01:38:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '346', '2024-02-24 16:41:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '251', '2024-06-03 20:13:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '96', '2023-08-10 14:25:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '366', '2023-12-28 11:47:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '99', '2023-03-10 12:48:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '276', '2023-06-22 04:09:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '106', '2023-12-08 20:55:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '246', '2023-02-17 09:27:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '389', '2024-03-12 10:20:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '13', '2023-07-04 18:11:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '397', '2024-04-06 08:24:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '169', '2023-08-12 04:15:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '124', '2023-05-22 09:43:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '385', '2023-06-25 19:52:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '411', '2023-03-01 05:41:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '306', '2023-10-12 19:49:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '261', '2023-10-29 14:47:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '493', '2024-03-01 07:45:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '394', '2023-07-08 18:17:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '162', '2023-01-28 23:05:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '486', '2023-04-07 22:16:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '314', '2023-12-31 10:07:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '196', '2023-08-22 23:59:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '438', '2024-04-24 12:20:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '257', '2023-12-01 15:10:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '157', '2023-03-06 11:05:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '140', '2023-12-27 19:02:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '163', '2023-09-21 23:00:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '29', '2023-10-17 21:07:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '148', '2023-08-15 22:13:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '417', '2023-05-04 15:27:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '43', '2023-03-14 02:50:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '227', '2024-01-09 08:09:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '66', '2024-01-03 06:35:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '459', '2023-09-01 00:19:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '159', '2023-12-28 19:34:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '475', '2023-09-16 04:25:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '469', '2023-02-04 16:08:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '305', '2023-04-07 17:35:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '410', '2024-01-11 14:08:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '226', '2023-11-02 06:36:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '339', '2024-03-22 19:34:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '167', '2023-04-05 09:57:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '160', '2024-05-26 09:49:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '448', '2024-03-12 21:16:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '241', '2023-03-02 11:31:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '369', '2023-04-21 19:01:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '60', '2023-11-21 05:12:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '95', '2024-05-19 18:34:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '165', '2023-05-25 20:43:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '487', '2023-10-29 15:59:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '90', '2023-04-21 20:48:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '221', '2023-10-31 12:18:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '35', '2023-11-12 06:22:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '214', '2023-08-03 19:00:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '393', '2024-05-25 16:25:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '285', '2024-05-09 04:58:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '70', '2024-01-07 09:43:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '302', '2023-05-04 20:34:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '362', '2023-05-24 21:38:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '229', '2024-02-20 23:12:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '175', '2023-03-03 15:43:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '258', '2023-07-12 02:56:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '282', '2024-03-09 00:41:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '309', '2023-07-11 05:06:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '401', '2023-10-27 15:44:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '477', '2023-02-07 05:45:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '354', '2023-07-12 17:47:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '191', '2023-09-17 09:49:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '284', '2023-09-20 06:55:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '71', '2023-08-03 22:20:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '347', '2024-06-24 01:07:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '201', '2023-12-24 20:44:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '224', '2023-11-24 07:41:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '54', '2023-07-22 00:56:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '25', '2023-09-18 17:19:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '130', '2023-03-08 16:39:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '490', '2023-05-06 23:05:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '134', '2023-03-11 08:06:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '386', '2024-03-20 23:35:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '248', '2023-04-28 21:13:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '408', '2023-11-22 06:30:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '84', '2023-12-30 11:29:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '404', '2023-07-12 05:55:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '101', '2024-01-27 17:09:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '368', '2023-02-06 13:40:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '237', '2023-11-05 21:44:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '449', '2023-08-02 18:34:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '198', '2023-02-07 16:34:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '207', '2024-01-12 10:14:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '197', '2024-03-07 13:12:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '320', '2024-05-29 19:20:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '274', '2024-04-27 17:26:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '202', '2024-02-20 22:37:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '263', '2023-01-07 20:44:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '108', '2023-12-21 05:55:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '112', '2023-07-17 19:22:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '431', '2023-11-05 00:26:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '242', '2023-09-26 23:52:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '295', '2023-02-20 06:55:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '63', '2023-12-11 19:17:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '323', '2023-02-27 17:18:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '268', '2023-09-08 06:27:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '24', '2024-04-10 00:07:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '254', '2023-09-24 05:02:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '363', '2023-12-21 05:21:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '267', '2024-01-13 11:55:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '497', '2024-02-16 15:05:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '495', '2024-06-23 04:19:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '51', '2023-10-03 13:34:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '182', '2024-05-05 06:42:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '37', '2023-11-25 13:40:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '138', '2023-04-21 23:54:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '409', '2023-01-29 22:07:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '395', '2023-11-07 05:58:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '288', '2023-03-24 16:25:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '425', '2024-06-15 17:43:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '355', '2023-05-17 12:00:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '361', '2023-06-27 02:08:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '80', '2023-11-25 10:22:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '34', '2024-03-03 22:47:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '218', '2024-02-08 11:27:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '222', '2024-06-21 01:33:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '423', '2023-07-18 04:21:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '448', '2023-07-20 20:37:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '139', '2023-02-28 04:12:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '496', '2023-12-01 08:10:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '279', '2023-09-27 00:41:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '224', '2023-08-06 17:36:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '46', '2023-10-19 04:23:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '3', '2023-06-15 04:04:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '20', '2023-06-05 13:41:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '225', '2023-02-23 06:24:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '85', '2023-02-03 03:30:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '170', '2024-04-19 22:49:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '373', '2024-01-01 04:02:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '74', '2023-01-27 12:36:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '23', '2023-02-16 01:40:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '403', '2024-02-05 21:37:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '389', '2023-10-24 03:41:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '364', '2023-02-05 01:35:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '162', '2023-08-18 03:12:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '83', '2024-03-17 01:52:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '254', '2023-09-27 20:47:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '499', '2024-01-11 08:26:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '393', '2023-03-24 18:49:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '275', '2024-06-16 00:02:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '203', '2023-01-15 00:12:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '397', '2023-09-03 11:58:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '35', '2023-11-03 03:26:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '229', '2023-08-24 04:04:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '154', '2023-07-01 13:19:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '379', '2024-01-14 20:58:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '66', '2024-02-03 14:59:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '132', '2023-08-20 02:28:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '363', '2023-02-04 09:55:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '358', '2023-09-12 10:59:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '384', '2024-03-23 08:00:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '244', '2023-06-25 02:41:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '450', '2024-01-03 06:01:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '145', '2023-01-12 12:54:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '317', '2024-05-07 13:56:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '404', '2024-02-05 08:25:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '383', '2023-04-01 15:40:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '202', '2024-01-25 09:30:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '314', '2023-04-08 12:42:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '56', '2024-01-31 09:56:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '485', '2023-02-19 07:07:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '26', '2023-09-02 12:46:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '113', '2024-02-02 06:52:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '119', '2023-05-17 00:24:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '180', '2023-11-11 22:12:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '55', '2023-06-27 09:44:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '483', '2024-05-26 21:58:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '407', '2023-11-28 03:12:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '198', '2023-10-16 17:56:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '394', '2023-07-21 05:11:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '392', '2023-07-16 14:00:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '410', '2023-07-01 00:24:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '462', '2024-05-04 09:03:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '52', '2023-02-23 16:21:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '58', '2023-06-19 20:19:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '126', '2023-05-26 00:01:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '78', '2024-02-29 17:40:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '320', '2024-01-31 21:55:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '401', '2023-04-20 22:45:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '214', '2023-02-23 14:42:01');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '479', '2023-06-25 03:42:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '365', '2023-02-03 12:33:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '442', '2023-06-20 12:22:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '110', '2023-11-16 18:35:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '439', '2023-12-03 03:02:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '107', '2023-03-02 05:53:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '187', '2024-06-20 11:32:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '230', '2023-03-12 05:43:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '378', '2023-07-09 06:29:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '181', '2024-01-03 06:02:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '327', '2023-12-17 13:05:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '312', '2023-02-04 10:11:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '31', '2023-11-17 11:29:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '189', '2023-02-04 16:24:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '473', '2023-02-20 16:26:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '128', '2023-12-06 22:44:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '210', '2023-09-20 10:31:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '267', '2024-02-22 08:56:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '466', '2024-04-14 20:42:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '276', '2023-03-03 10:31:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '112', '2023-02-09 15:28:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '211', '2023-08-28 17:08:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '274', '2023-11-24 17:14:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '200', '2023-12-07 18:07:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '115', '2023-05-16 23:45:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '475', '2023-08-10 16:21:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '240', '2024-06-11 23:09:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '16', '2023-02-24 04:35:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '417', '2023-01-25 13:44:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '103', '2024-06-08 05:16:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '396', '2023-06-13 06:48:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '257', '2024-06-23 15:58:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '399', '2023-04-05 00:49:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '374', '2024-01-08 12:54:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '144', '2023-08-21 10:47:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '325', '2023-09-02 00:18:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '411', '2024-05-11 20:49:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '390', '2024-01-09 04:13:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '37', '2023-11-16 09:29:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '90', '2023-04-18 06:09:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '228', '2023-01-09 19:07:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '54', '2024-03-15 21:49:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '360', '2024-04-15 03:19:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '301', '2023-09-22 08:23:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '136', '2023-05-03 00:34:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '36', '2023-08-26 18:43:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '309', '2024-04-07 04:39:01');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '333', '2023-01-23 11:50:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '166', '2023-08-29 23:12:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '151', '2023-12-06 17:50:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '236', '2024-01-31 23:57:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '467', '2024-01-09 14:05:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '24', '2023-02-08 08:19:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '84', '2023-06-27 14:34:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '307', '2023-09-14 02:01:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '9', '2024-01-24 20:13:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '294', '2023-05-03 17:15:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '27', '2023-04-22 05:03:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '43', '2024-04-04 11:43:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '223', '2023-01-01 00:21:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '173', '2023-11-26 08:09:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '252', '2023-06-15 11:26:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '463', '2023-12-15 18:01:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '354', '2023-01-13 22:27:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '370', '2023-11-09 14:17:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '21', '2023-04-19 01:48:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '452', '2023-03-21 19:49:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '184', '2023-06-01 23:55:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '270', '2023-05-26 02:35:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '89', '2024-03-15 19:49:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '321', '2023-08-08 10:24:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '178', '2023-07-20 07:30:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '64', '2023-07-08 04:00:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '193', '2024-01-22 21:01:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '88', '2023-12-27 05:25:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '153', '2023-07-18 07:05:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '429', '2024-04-06 00:33:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '281', '2024-02-28 02:23:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '338', '2024-06-25 13:28:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '15', '2023-05-25 18:28:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '458', '2023-02-17 16:15:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '484', '2023-08-05 08:09:34');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '216', '2023-07-19 12:24:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '220', '2024-01-07 14:32:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '491', '2023-09-23 10:36:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '367', '2024-04-03 03:23:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '25', '2023-01-15 01:15:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '182', '2024-05-03 16:07:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '140', '2023-05-08 19:37:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '59', '2023-09-23 08:17:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '488', '2024-02-14 11:56:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '215', '2024-02-25 22:17:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '212', '2024-06-21 09:35:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '292', '2023-07-28 00:37:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '221', '2023-02-12 08:22:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '174', '2023-02-17 12:21:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '468', '2024-04-11 05:09:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '489', '2023-08-08 14:34:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '341', '2023-08-01 09:04:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '245', '2024-03-29 18:23:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '419', '2023-04-29 02:01:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '176', '2023-08-09 22:55:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '167', '2023-04-11 23:59:10');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '433', '2023-12-06 03:14:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '359', '2023-06-22 17:59:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '251', '2024-03-09 21:15:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '357', '2023-12-18 05:38:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '234', '2024-02-12 17:29:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '422', '2023-03-27 11:21:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '273', '2024-03-28 04:41:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '149', '2023-11-07 09:47:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '150', '2024-06-20 09:48:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '190', '2023-08-18 10:21:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '33', '2023-11-22 02:34:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '120', '2024-05-29 13:05:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '87', '2023-08-25 18:17:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '289', '2023-08-23 08:26:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '426', '2024-05-13 10:21:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '197', '2023-03-11 14:34:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '474', '2023-11-08 23:52:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '366', '2024-06-05 16:39:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '165', '2024-05-16 15:28:03');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '11', '2023-12-10 23:40:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '201', '2023-05-10 23:46:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '269', '2023-03-16 12:21:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '353', '2023-02-28 04:52:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '481', '2023-03-21 21:54:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '172', '2024-06-16 00:54:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '256', '2023-09-04 02:43:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '226', '2023-05-07 05:56:38');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '380', '2024-03-13 07:34:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '70', '2024-06-05 03:11:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '290', '2024-03-29 00:02:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '111', '2023-09-25 05:26:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '13', '2023-06-30 20:42:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '122', '2023-01-07 02:33:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '14', '2024-03-19 09:48:15');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '318', '2023-06-24 12:03:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '414', '2024-04-24 12:55:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '408', '2024-01-14 23:14:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '264', '2023-09-04 16:51:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '118', '2024-04-20 15:39:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '73', '2023-07-17 06:53:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '371', '2023-04-11 20:42:42');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '255', '2024-02-09 02:32:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '95', '2023-04-09 15:12:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '453', '2023-01-19 16:02:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '4', '2023-04-06 12:29:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '286', '2023-11-16 13:31:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '94', '2024-06-06 10:42:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '395', '2023-08-22 18:31:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '127', '2024-03-13 19:33:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '268', '2023-01-15 21:13:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '142', '2024-01-19 10:51:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '376', '2024-06-16 12:02:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '163', '2023-02-12 16:20:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '114', '2024-05-19 21:16:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '278', '2023-03-15 19:28:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '213', '2023-05-28 17:11:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '62', '2024-02-01 09:07:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '487', '2023-05-26 23:11:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '238', '2024-05-24 16:12:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '109', '2023-07-25 23:55:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '349', '2023-04-16 17:16:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '296', '2024-06-06 21:44:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '49', '2023-08-02 13:39:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '285', '2023-07-27 03:13:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '157', '2023-11-26 21:12:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '431', '2023-10-13 03:46:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '308', '2024-05-18 01:09:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '147', '2024-04-26 11:57:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '93', '2023-04-25 13:10:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '38', '2024-01-17 17:07:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '438', '2023-01-25 16:21:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '231', '2024-05-27 03:39:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '449', '2023-09-10 18:17:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '311', '2023-06-01 12:35:19');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '368', '2023-11-17 13:08:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '241', '2024-01-01 17:19:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '345', '2023-05-09 08:14:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '152', '2023-08-06 22:50:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '430', '2023-01-22 19:36:26');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '347', '2023-12-30 17:30:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '437', '2023-05-08 17:29:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '100', '2024-03-21 04:28:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '447', '2023-06-21 02:36:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '440', '2023-04-06 17:15:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '441', '2023-01-01 12:43:17');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '272', '2024-01-06 10:18:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '494', '2024-06-03 01:07:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '457', '2023-06-04 18:47:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '7', '2023-08-15 03:46:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '263', '2024-05-10 04:48:00');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '61', '2023-09-27 05:58:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '406', '2024-04-06 05:47:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '208', '2024-04-25 14:10:49');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '123', '2023-12-22 17:22:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '434', '2023-07-26 02:48:40');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '169', '2024-04-08 18:08:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '306', '2024-04-09 23:01:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '262', '2024-04-17 16:41:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '313', '2023-08-12 08:22:13');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '415', '2023-04-16 16:42:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '298', '2024-03-14 20:01:52');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '81', '2024-01-22 19:27:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '342', '2023-02-08 15:15:37');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '116', '2024-03-19 15:14:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '206', '2024-03-14 08:06:57');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '428', '2024-05-31 02:32:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '329', '2023-01-08 19:32:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '69', '2023-10-29 22:30:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '135', '2023-09-04 09:55:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '159', '2023-04-09 19:48:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '402', '2023-12-11 06:00:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '239', '2023-07-19 01:50:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '192', '2023-08-13 16:57:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '300', '2023-07-28 10:56:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '303', '2024-02-08 08:11:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '101', '2024-05-12 12:33:08');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '104', '2023-01-01 23:19:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '493', '2023-08-12 05:04:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '328', '2023-05-03 01:46:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '337', '2023-10-27 00:44:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '138', '2023-04-08 13:01:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '60', '2024-06-07 21:32:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '497', '2024-04-22 21:50:16');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '2', '2024-03-25 23:23:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '427', '2023-01-02 23:05:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '8', '2023-07-19 10:49:32');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '171', '2024-01-13 08:12:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '253', '2023-05-04 06:02:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '92', '2023-09-24 20:15:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '283', '2023-12-05 19:41:07');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '424', '2024-04-14 06:07:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '247', '2024-01-22 19:21:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '387', '2023-09-07 19:04:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '456', '2023-10-02 09:29:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '98', '2024-02-07 12:43:22');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '133', '2023-02-14 13:24:44');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '129', '2024-03-26 12:33:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '217', '2023-01-27 00:12:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '334', '2024-03-30 12:02:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '188', '2023-08-17 05:21:45');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '319', '2024-06-11 21:58:51');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('31', '194', '2023-04-07 08:47:50');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('38', '381', '2023-10-14 14:49:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('2', '67', '2024-04-09 08:51:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('8', '310', '2023-05-12 07:26:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('37', '405', '2023-04-28 22:09:05');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('27', '57', '2024-04-19 00:51:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('39', '180', '2023-01-05 01:56:06');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('26', '405', '2023-02-02 19:13:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('32', '33', '2023-11-06 14:37:54');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('42', '17', '2023-11-14 03:53:04');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('15', '238', '2023-11-19 16:43:41');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('43', '478', '2024-03-28 23:58:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('35', '334', '2023-02-23 06:06:21');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('11', '188', '2024-06-01 03:22:14');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('30', '407', '2023-05-22 08:31:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('10', '122', '2023-07-15 01:18:46');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('21', '419', '2024-06-28 23:33:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('22', '378', '2023-09-24 07:10:09');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('40', '31', '2024-04-11 09:29:58');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('48', '330', '2023-09-01 16:24:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('34', '354', '2023-08-10 14:38:27');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('28', '90', '2023-10-03 18:12:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('7', '202', '2024-06-08 06:55:39');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('44', '495', '2023-08-12 21:00:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('17', '132', '2023-06-27 17:16:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('25', '11', '2023-11-12 23:35:59');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('6', '402', '2023-06-21 18:56:29');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('23', '58', '2023-04-07 10:45:47');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('41', '92', '2023-09-23 19:24:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('5', '289', '2023-11-28 13:09:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('47', '292', '2023-03-27 02:01:56');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('3', '431', '2023-02-20 22:35:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('12', '372', '2024-03-09 08:56:35');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('1', '391', '2024-06-18 01:21:30');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('20', '381', '2023-05-14 14:52:48');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('16', '352', '2024-02-25 05:49:28');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('50', '3', '2024-04-06 15:14:25');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('24', '107', '2023-01-06 15:04:31');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('36', '387', '2024-02-11 23:39:53');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('9', '96', '2024-02-02 15:52:20');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('49', '433', '2024-06-02 11:04:11');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('14', '233', '2023-01-25 18:49:55');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('13', '430', '2023-01-24 13:01:24');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('45', '460', '2023-02-19 13:45:36');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('46', '454', '2023-03-05 10:55:43');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('18', '403', '2023-08-27 19:39:02');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('29', '473', '2023-11-02 10:09:18');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('4', '124', '2023-12-03 10:27:12');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('19', '63', '2023-11-23 17:03:33');
insert into DataScoop_PartInstance (DataScoopID, PartInstanceID, dateInstalled) values ('33', '45', '2024-01-13 12:12:53');

-- SELECT * FROM DataScoop_PartInstance;

-- Employee
-- Data generated with mockaroo, edited
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (1, 8, 'Abramo', 'Elsey', '399-981-5945', 'aelsey0@chicagotribune.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (2, 8, 'Wilton', 'Guittet', '294-448-9008', 'wguittet1@newsvine.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (3, 9, 'Bentley', 'McMenamy', '381-784-7536', 'bmcmenamy2@shareasale.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (4, 7, 'Ash', 'Poley', '660-839-8328', 'apoley3@ebay.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (5, 7, 'Alex', 'Newbury', '649-349-7400', 'anewbury4@gov.uk');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (6, 8, 'Kelcie', 'Rekes', '386-731-7337', 'krekes5@chron.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (7, null, 'Morrie', 'Earie', '590-994-4622', 'mearie6@archive.org');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (8, 7, 'Cheri', 'Lidgley', '106-835-4537', 'clidgley7@tinyurl.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (9, 7, 'Jerrome', 'Oxley', '716-318-2144', 'joxley8@howstuffworks.com');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (10, 8, 'Donnamarie', 'Farge', '964-842-9857', 'dfarge9@nyu.edu');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (11, 9, 'Sharline', 'Ruttgers', '145-756-8357', 'sruttgersa@dailymail.co.uk');
insert into Employee (ID, Manager, firstName, lastName, phone, email) values (12, 9, 'Wilfred', 'Gascar', '728-362-5104', 'wgascarb@xinhuanet.com');

-- SELECT * FROM Employee;

-- Employee Specialisations

-- DroneTechnician
INSERT INTO DroneTechnician (EmployeeID) VALUES (1);
INSERT INTO DroneTechnician (EmployeeID) VALUES (2);
INSERT INTO DroneTechnician (EmployeeID) VALUES (3);

-- SELECT * FROM DroneTechnician;

-- DronePilot
INSERT INTO DronePilot (EmployeeID) VALUES (4);
INSERT INTO DronePilot (EmployeeID) VALUES (5);
INSERT INTO DronePilot (EmployeeID) VALUES (6);

-- SELECT * FROM DronePilot;

-- AdministrativeExecutive
INSERT INTO AdministrativeExecutive (EmployeeID) VALUES (7);
INSERT INTO AdministrativeExecutive (EmployeeID) VALUES (8);
INSERT INTO AdministrativeExecutive (EmployeeID) VALUES (9);

-- SELECT * FROM AdministrativeExecutive;

-- SalesPerson
INSERT INTO Salesperson (EmployeeID, maxDiscount) VALUES (10, 0.03);
INSERT INTO Salesperson (EmployeeID, maxDiscount) VALUES (11, 0.05);
INSERT INTO Salesperson (EmployeeID, maxDiscount) VALUES (12, 0.03);

-- SELECT * FROM Salesperson;

-- Contract
-- Data generated with Mockaroo
insert into [Contract] (ID, employeeID, contractor, notes) values (1, 8, 'Friesen Inc', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into [Contract] (ID, employeeID, contractor, notes) values (2, 9, 'Volkman and Sons', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (3, 7, 'Hudson Group', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (4, 9, 'Brakus LLC', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into [Contract] (ID, employeeID, contractor, notes) values (5, 9, 'Heaney, Bosco and Kihn', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into [Contract] (ID, employeeID, contractor, notes) values (6, 9, 'Conn, Wiza and Fritsch', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (7, 9, 'Carter Group', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (8, 9, 'Oberbrunner and Sons', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into [Contract] (ID, employeeID, contractor, notes) values (9, 8, 'Rodriguez, Ratke and Altenwerth', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into [Contract] (ID, employeeID, contractor, notes) values (10, 9, 'Collier and Sons', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into [Contract] (ID, employeeID, contractor, notes) values (11, 9, 'Swift-Okuneva', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into [Contract] (ID, employeeID, contractor, notes) values (12, 9, 'Herzog-Bradtke', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (13, 8, 'Koss and Sons', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into [Contract] (ID, employeeID, contractor, notes) values (14, 8, 'Herzog, Windler and McLaughlin', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (15, 9, 'Fisher-Cormier', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into [Contract] (ID, employeeID, contractor, notes) values (16, 9, 'Weber, Funk and Ullrich', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into [Contract] (ID, employeeID, contractor, notes) values (17, 7, 'Treutel-Wolff', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into [Contract] (ID, employeeID, contractor, notes) values (18, 9, 'Douglas LLC', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into [Contract] (ID, employeeID, contractor, notes) values (19, 7, 'Kreiger-Johnson', null);
insert into [Contract] (ID, employeeID, contractor, notes) values (20, 9, 'Hilll, Wiza and Mertz', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');

-- SELECT * FROM [Contract];

-- Customer
-- Data generated with mockaroo
insert into Customer (ID, firstName, lastName, phone, email, company) values (1, 'Dody', 'Davitashvili', '346-292-2960', 'ddavitashvili0@webmd.com', 'Jerde, Hahn and Lubowitz');
insert into Customer (ID, firstName, lastName, phone, email, company) values (2, 'Virgilio', 'Iczokvitz', '401-123-3310', 'viczokvitz1@toplist.cz', 'Hayes, Hagenes and Kunze');
insert into Customer (ID, firstName, lastName, phone, email, company) values (3, 'Stacy', 'Mattack', '114-294-8040', 'smattack2@123-reg.co.uk', 'Larkin LLC');
insert into Customer (ID, firstName, lastName, phone, email, company) values (4, 'Nathalie', 'Figure', '969-566-3828', 'nfigure3@netvibes.com', 'O''Connell and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (5, 'Anneliese', 'Dines', '393-650-1993', 'adines4@state.tx.us', 'Predovic LLC');
insert into Customer (ID, firstName, lastName, phone, email, company) values (6, 'Gregorius', 'Pendrick', '713-368-2270', 'gpendrick5@bizjournals.com', 'Morar and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (7, 'Darb', 'Silliman', '302-189-9294', 'dsilliman6@comcast.net', 'Fahey-Kozey');
insert into Customer (ID, firstName, lastName, phone, email, company) values (8, 'Nicoline', 'Pieper', '721-176-6529', 'npieper7@mashable.com', 'Hoppe, Heller and Lang');
insert into Customer (ID, firstName, lastName, phone, email, company) values (9, 'Rene', 'O''Doireidh', '393-120-4709', null, 'Yost Inc');
insert into Customer (ID, firstName, lastName, phone, email, company) values (10, 'Mariana', 'Sarfas', '306-773-4655', null, 'Powlowski-Cummings');
insert into Customer (ID, firstName, lastName, phone, email, company) values (11, 'Lauralee', 'Meffen', '903-219-4109', 'lmeffena@icio.us', 'Bosco-Torp');
insert into Customer (ID, firstName, lastName, phone, email, company) values (12, 'Natal', 'Surgey', '702-523-7907', 'nsurgeyb@netlog.com', 'Ferry-Herzog');
insert into Customer (ID, firstName, lastName, phone, email, company) values (13, 'Sisile', 'Symcox', '384-828-5264', null, 'Klocko, Buckridge and Ondricka');
insert into Customer (ID, firstName, lastName, phone, email, company) values (14, 'Phillida', 'Kingsford', '914-623-2021', 'pkingsfordd@wikipedia.org', 'Fahey-Kassulke');
insert into Customer (ID, firstName, lastName, phone, email, company) values (15, 'Farlay', 'Abeles', '869-858-8430', 'fabelese@photobucket.com', 'Bechtelar Inc');
insert into Customer (ID, firstName, lastName, phone, email, company) values (16, 'Lizzie', 'Seyers', '903-457-3322', 'lseyersf@ifeng.com', 'Quigley-Rosenbaum');
insert into Customer (ID, firstName, lastName, phone, email, company) values (17, 'Rhodie', 'Chadwell', '146-950-3534', 'rchadwellg@gnu.org', 'Luettgen, Emard and Daugherty');
insert into Customer (ID, firstName, lastName, phone, email, company) values (18, 'Myron', 'Bentzen', '859-953-3944', 'mbentzenh@microsoft.com', 'Kunze and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (19, 'Johannes', 'MacGaughie', '559-560-3694', null, 'Bernhard-Feeney');
insert into Customer (ID, firstName, lastName, phone, email, company) values (20, 'Sigismundo', 'Oakly', '618-941-4879', null, 'Crooks, Nolan and Yost');
insert into Customer (ID, firstName, lastName, phone, email, company) values (21, 'Val', 'Fawdrey', null, 'vfawdreyk@cnn.com', 'Haag, Nitzsche and Hills');
insert into Customer (ID, firstName, lastName, phone, email, company) values (22, 'Keary', 'Crowdace', '796-535-0663', 'kcrowdacel@thetimes.co.uk', 'Kuhn LLC');
insert into Customer (ID, firstName, lastName, phone, email, company) values (23, 'Eiter', 'Cannovane', '816-639-6107', 'gocannovanem@stumbleupon.com', 'Terry, Torphy and O''Conner');
insert into Customer (ID, firstName, lastName, phone, email, company) values (24, 'Marion', 'Attreed', '555-404-4529', 'mattreedn@over-blog.com', 'Barton and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (25, 'Dory', 'Reveland', '951-766-6488', 'drevelando@histats.com', 'O''Connell and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (26, 'Haley', 'Sainer', '916-255-0622', 'hsainerp@opensource.org', 'Brakus-Emmerich');
insert into Customer (ID, firstName, lastName, phone, email, company) values (27, 'Marcelia', 'Folliott', '953-652-0804', 'mfolliottq@disqus.com', 'Mertz-Blick');
insert into Customer (ID, firstName, lastName, phone, email, company) values (28, 'Katuscha', 'Brailey', '151-581-0579', 'kbraileyr@hibu.com', 'Smith, Gutkowski and Rodriguez');
insert into Customer (ID, firstName, lastName, phone, email, company) values (29, 'Hildagard', 'Aprahamian', '797-956-8984', 'haprahamians@tripadvisor.com', 'Von-Frami');
insert into Customer (ID, firstName, lastName, phone, email, company) values (30, 'Alexis', 'Edmett', '917-497-0461', 'aedmettt@joomla.org', 'Okuneva, Blanda and Yost');
insert into Customer (ID, firstName, lastName, phone, email, company) values (31, 'Nelli', 'Marval', '783-613-4740', 'nmarvalu@symantec.com', 'Muller Group');
insert into Customer (ID, firstName, lastName, phone, email, company) values (32, 'Sarina', 'Upston', '330-943-0200', 'supstonv@geocities.jp', 'Reichert and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (33, 'Seymour', 'Ellicott', '287-399-7835', 'sellicottw@aboutads.info', 'Davis and Sons');
insert into Customer (ID, firstName, lastName, phone, email, company) values (34, 'Spike', 'Torrance', '523-826-5593', 'storrancex@census.gov', 'Bernhard LLC');
insert into Customer (ID, firstName, lastName, phone, email, company) values (35, 'Mareah', 'Swaffer', null, 'mswaffery@unicef.org', 'Homenick, McDermott and Klein');
insert into Customer (ID, firstName, lastName, phone, email, company) values (36, 'Normand', 'Bransom', '142-776-0552', 'nbransomz@nsw.gov.au', 'Goyette LLC');
insert into Customer (ID, firstName, lastName, phone, email, company) values (37, 'Mathe', 'Sute', '287-674-8151', 'msute10@ow.ly', 'Grady, Lowe and Rice');
insert into Customer (ID, firstName, lastName, phone, email, company) values (38, 'Mark', 'Breazeall', '804-111-0903', 'mbreazeall11@ebay.co.uk', 'Kuhn, Waelchi and Keebler');
insert into Customer (ID, firstName, lastName, phone, email, company) values (39, 'Durant', 'Whetnell', '544-794-7181', 'dwhetnell12@irs.gov', 'Hills-Lang');
insert into Customer (ID, firstName, lastName, phone, email, company) values (40, 'Frasco', 'Lillistone', null, 'flillistone13@free.fr', 'Wolff, Fisher and Rath');

-- SELECT * FROM Customer;

-- Zone
-- Data generated with Mockaroo
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (1, '7', 2);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (2, '1', 10);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (3, '5', 17);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (4, '6', 32);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (5, '2', 43);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (6, '4', 52);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (7, '3', 55);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (8, '1', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (9, '7', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (10, '5', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (11, '3', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (12, '6', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (13, '4', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (14, '2', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (15, '5', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (16, '2', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (17, '7', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (18, '6', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (19, '4', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (20, '3', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (21, '1', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (22, '5', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (23, '4', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (24, '7', null);
insert into [Zone] (ID, Biome, OwningSubscriptionID) values (25, '3', null);

-- SELECT * FROM [Zone];

-- Zone_Contract
-- Data generated with Mockaroo
insert into Zone_Contract (ZoneID, ContractID) values ('1', '1');
insert into Zone_Contract (ZoneID, ContractID) values ('2', '2');
insert into Zone_Contract (ZoneID, ContractID) values ('3', '3');
insert into Zone_Contract (ZoneID, ContractID) values ('4', '4');
insert into Zone_Contract (ZoneID, ContractID) values ('5', '5');
insert into Zone_Contract (ZoneID, ContractID) values ('6', '6');
insert into Zone_Contract (ZoneID, ContractID) values ('7', '7');
insert into Zone_Contract (ZoneID, ContractID) values ('8', '8');
insert into Zone_Contract (ZoneID, ContractID) values ('9', '9');
insert into Zone_Contract (ZoneID, ContractID) values ('10', '10');
insert into Zone_Contract (ZoneID, ContractID) values ('12', '11');
insert into Zone_Contract (ZoneID, ContractID) values ('12', '12');
insert into Zone_Contract (ZoneID, ContractID) values ('13', '13');
insert into Zone_Contract (ZoneID, ContractID) values ('14', '14');
insert into Zone_Contract (ZoneID, ContractID) values ('15', '15');
insert into Zone_Contract (ZoneID, ContractID) values ('16', '16');
insert into Zone_Contract (ZoneID, ContractID) values ('17', '17');
insert into Zone_Contract (ZoneID, ContractID) values ('18', '18');
insert into Zone_Contract (ZoneID, ContractID) values ('19', '19');
insert into Zone_Contract (ZoneID, ContractID) values ('20', '20');
insert into Zone_Contract (ZoneID, ContractID) values ('21', '1');
insert into Zone_Contract (ZoneID, ContractID) values ('22', '2');
insert into Zone_Contract (ZoneID, ContractID) values ('23', '3');
insert into Zone_Contract (ZoneID, ContractID) values ('24', '4');
insert into Zone_Contract (ZoneID, ContractID) values ('25', '5');
insert into Zone_Contract (ZoneID, ContractID) values ('1', '6');
insert into Zone_Contract (ZoneID, ContractID) values ('2', '7');
insert into Zone_Contract (ZoneID, ContractID) values ('3', '8');
insert into Zone_Contract (ZoneID, ContractID) values ('4', '9');
insert into Zone_Contract (ZoneID, ContractID) values ('5', '10');

-- SELECT * FROM Zone_Contract;

-- PerimiterCoordinate
-- Generated with Mockaroo
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('1', 1, 48.5851876, 7.7342943);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('2', 2, 38.0765476, -84.5955732);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('3', 3, 22.1215513, 95.1536327);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('4', 4, 43.0429124, 1.9038837);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('5', 1, -20.8938356, -45.2721363);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('6', 2, 41.634449, 22.4665446);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('7', 3, 7.2676037, -8.1447804);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('8', 4, 19.7553444, -70.8233213);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('9', 1, 23.0386278, 91.5184418);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('10', 2, 13.3323464, -87.8500644);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('11', 3, -1.2468663, 110.0926112);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('12', 4, 27.283955, 105.291643);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('13', 1, 43.3582371, 19.3512591);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('14', 2, 8.955271, 126.009711);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('15', 3, 32.009016, 112.122426);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('16', 4, 30.679359, 104.011664);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('17', 1, 9.9356473, -84.0792946);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('18', 2, 49.663978, 90.2905901);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('19', 3, 43.7441795, 2.511999);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('20', 4, -7.0567806, 113.6353431);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('21', 1, 31.04808, 121.749495);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('22', 2, 37.943121, 115.217658);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('23', 3, 55.7184184, 39.7362416);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('24', 4, 45.9735653, 134.1872425);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('25', 1, 32.8172446, -96.7712123);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('1', 2, 5.0549877, -75.6789905);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('2', 3, 21.514163, 111.013556);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('3', 4, 4.6096768, 101.1064003);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('4', 1, 48.1079676, -1.5212701);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('5', 2, 41.0394198, -8.5359207);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('6', 3, -6.7455152, 111.2293563);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('7', 4, 28.55386, 112.35518);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('8', 1, 27.950753, 109.592921);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('9', 2, 39.46667, 22.73333);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('10', 3, 50.1601386, 107.3956619);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('11', 4, 27.951331, 92.009188);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('12', 1, -8.3120496, 123.2814017);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('13', 2, 10.347021, 15.2370339);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('14', 3, 33.8305244, -4.8353154);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('15', 4, 29.627993, 111.915162);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('16', 1, 29.301449, 111.101029);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('17', 2, -8.577582, 115.136457);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('18', 3, 16.4504042, 102.6402895);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('19', 4, 19.4095846, -99.1575732);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('20', 1, 22.183206, 112.305145);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('21', 2, 31.982751, 120.277138);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('22', 3, 47.3892142, 0.6942885);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('23', 4, 38.7754165, -7.41612);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('24', 1, 35.9594106, 38.9981052);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('25', 2, 56.1252914, 86.0314623);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('1', 3, 41.5332101, 19.6103673);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('2', 4, 21.5117028, -104.8786647);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('3', 1, 9.97788, -84.762933);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('4', 2, 7.813374, 123.362634);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('5', 3, 52.958936, 21.8130562);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('6', 4, 10.316625, -84.428401);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('7', 1, 1.0087005, 100.2656209);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('8', 2, 15.847683, 120.9187827);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('9', 3, -0.35294, -79.66033);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('10', 4, 45.2497275, 19.3967698);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('11', 1, 7.5273576, 125.6239227);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('12', 2, 52.995267, 16.9198184);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('13', 3, -0.3221142, 103.1517902);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('14', 4, -22.2528986, -45.7049987);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('15', 1, 8.1176382, -80.593833);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('16', 2, -6.1664291, 106.2125017);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('17', 3, -11.82167, 43.27806);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('18', 4, 28.6846153, 115.8922746);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('19', 1, 8.5524587, -82.6861446);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('20', 2, 14.6181466, 120.9818412);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('21', 3, 32.533573, 120.467343);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('22', 4, 40.8258113, 43.9516138);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('23', 1, -23.4833329, 27.116667);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('24', 2, -34.069556, 20.6764877);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('25', 3, 49.1478969, 14.1751311);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('1', 4, 50.781501, 20.1074449);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('2', 1, 32.20068, 35.21293);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('3', 2, 40.076762, 113.300129);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('4', 3, 59.9278844, 10.7477822);
insert into PerimeterCoordinate (ZoneID, coordinateNumber, latitude, longitude) values ('5', 4, 45.054478, 7.6579399);

-- SELECT * FROM PerimeterCoordinate;

-- Inspection
-- Data generated with Mockaroo
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('59', 1, '3/9/2024', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('34', 1, '5/17/2024', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('40', 3, '1/2/2024', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('83', 2, '9/20/2023', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('492', 1, '4/24/2024', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('49', 1, '10/8/2023', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('268', 2, '6/1/2024', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('458', 1, '2/2/2024', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('112', 2, '7/25/2023', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('354', 1, '4/5/2024', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('158', 3, '9/10/2023', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('468', 3, '6/12/2024', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('304', 1, '5/13/2024', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('19', 3, '7/20/2023', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('254', 3, '10/19/2023', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('244', 2, '6/15/2023', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('2', 3, '10/28/2023', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('22', 1, '12/14/2023', 'Fusce consequat. Nulla nisl. Nunc nisl.Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('315', 3, '11/9/2023', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('352', 3, '4/16/2024', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('24', 2, '3/22/2024', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.Fusce consequat. Nulla nisl. Nunc nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('61', 3, '8/31/2023', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('384', 3, '3/15/2024', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('32', 3, '2/14/2024', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('277', 2, '3/8/2024', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('214', 3, '12/9/2023', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('120', 1, '1/14/2024', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('470', 2, '7/16/2023', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('60', 2, '12/31/2023', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('375', 1, '4/12/2024', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('287', 2, '10/27/2023', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.Fusce consequat. Nulla nisl. Nunc nisl.Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('337', 3, '4/14/2024', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('103', 3, '6/14/2024', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('477', 1, '4/27/2024', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('427', 3, '12/23/2023', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('460', 1, '11/16/2023', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('150', 3, '3/24/2024', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('377', 3, '1/9/2024', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('153', 3, '7/3/2023', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('432', 2, '2/22/2024', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('308', 3, '8/31/2023', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('383', 2, '6/13/2024', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('251', 2, '8/15/2023', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.Sed ante. Vivamus tortor. Duis mattis egestas metus.Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('422', 1, '2/1/2024', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('98', 1, '7/31/2023', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('410', 1, '6/14/2024', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('340', 3, '1/4/2024', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('426', 3, '1/28/2024', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('475', 2, '5/31/2024', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('394', 3, '8/8/2023', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('311', 3, '6/9/2024', 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('262', 3, '9/20/2023', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('343', 3, '4/25/2024', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('336', 3, '6/25/2023', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('297', 1, '12/7/2023', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('461', 1, '10/24/2023', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('65', 3, '3/27/2024', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('167', 3, '9/12/2023', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('18', 3, '10/12/2023', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('438', 2, '9/5/2023', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('459', 2, '11/20/2023', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('463', 2, '10/12/2023', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('135', 3, '10/2/2023', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('106', 1, '12/21/2023', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('196', 1, '2/24/2024', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('271', 1, '2/22/2024', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('284', 3, '2/13/2024', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('278', 3, '9/29/2023', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.Sed ante. Vivamus tortor. Duis mattis egestas metus.Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('264', 1, '3/28/2024', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('356', 3, '9/5/2023', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('480', 1, '10/17/2023', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('374', 3, '8/5/2023', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('170', 1, '4/19/2024', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('77', 1, '5/5/2024', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('417', 3, '11/1/2023', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('452', 1, '6/6/2024', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('53', 2, '11/7/2023', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('194', 1, '5/17/2024', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('474', 3, '9/26/2023', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('184', 3, '8/12/2023', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('387', 2, '3/31/2024', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('219', 2, '4/5/2024', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('7', 1, '1/5/2024', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('256', 2, '1/12/2024', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('275', 3, '1/19/2024', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('434', 3, '2/7/2024', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('449', 3, '3/21/2024', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('428', 2, '10/28/2023', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('390', 3, '2/20/2024', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('397', 3, '4/1/2024', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('123', 1, '6/30/2023', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('146', 2, '4/8/2024', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.Fusce consequat. Nulla nisl. Nunc nisl.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('493', 1, '12/7/2023', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('109', 1, '4/8/2024', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('172', 3, '6/4/2024', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('209', 1, '12/15/2023', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('26', 2, '11/24/2023', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('415', 1, '4/2/2024', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('386', 1, '3/20/2024', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into Inspection (PartInstanceID, EmployeeID, inspectionDate, report) values ('440', 2, '6/23/2023', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');

-- SELECT * from Inspection;

-- DronePilot_DataScoop_Zone
-- Generated with Mockaroo
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 5, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 6, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 6, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 4, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 5, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 4, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 4, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 6, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 4, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 5, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 5, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 5, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 6, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 4, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 4, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 5, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 4, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 6, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 6, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 6, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 4, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 6, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 5, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 6, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 4, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 5, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 5, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 5, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 4, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 5, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 4, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 6, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 4, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 6, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 6, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 6, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 5, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 6, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 4, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 5, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 4, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 6, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 6, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 4, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 6, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 4, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 4, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 4, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 5, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 4, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 5, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 5, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 5, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 4, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 6, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 6, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 4, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 6, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 4, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 4, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 4, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 4, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 6, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 5, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 6, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 5, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 4, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 6, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 4, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 4, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 5, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 5, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 5, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 4, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 4, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 5, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 4, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 6, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 4, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 6, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 4, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 4, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 4, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 4, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 4, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 5, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 6, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 4, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 4, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 5, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 5, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 6, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 5, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 4, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 4, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 4, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 6, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 4, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 6, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 4, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 5, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 4, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 5, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 6, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 4, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 5, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 6, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 6, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 4, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 4, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 5, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 6, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 4, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 4, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 5, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 5, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 6, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 4, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 4, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 4, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 4, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 4, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 5, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 6, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 4, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 4, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 6, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 4, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 5, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 4, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 5, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 4, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 5, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 4, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 5, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 6, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 5, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 4, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 4, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 4, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 5, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 6, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 4, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 6, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 4, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 4, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 6, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 6, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 6, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 6, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 6, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 5, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('17', 5, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 4, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 5, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 4, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 4, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 5, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 5, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 6, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 6, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 4, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 5, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 4, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('11', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('27', 5, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('2', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('38', 6, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('46', 5, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('43', 4, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('48', 5, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('20', 6, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('37', 6, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('16', 4, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('10', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('23', 5, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('15', 6, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('18', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('33', 4, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('4', 4, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('35', 6, '10');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('12', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('29', 6, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('40', 6, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('36', 4, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('26', 4, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('19', 6, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('1', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('31', 4, '24');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('9', 5, '12');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('30', 4, '9');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('13', 5, '7');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('28', 5, '4');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('45', 4, '8');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('7', 5, '1');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('14', 5, '13');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('21', 4, '15');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('50', 6, '22');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('39', 5, '20');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('6', 6, '17');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('49', 4, '2');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('42', 6, '16');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('24', 6, '5');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('25', 5, '14');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('5', 6, '18');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('34', 5, '19');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('22', 4, '25');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('47', 6, '6');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('3', 6, '11');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('41', 5, '21');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('8', 6, '3');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('44', 4, '23');
insert into DronePilot_DataScoop_Zone (DataScoopID, EmployeeID, ZoneID) values ('32', 4, '10');

-- SELECT * from DronePilot_DataScoop_Zone;

-- VideoStream
-- Generated with Mockaroo
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (1, '35', '14', -31.94, 37.18, 44.06);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (2, '31', '13', 89.96, -96.38, 84.5);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (3, '47', '7', -22.61, -32.75, -70.86);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (4, '18', '16', 42.44, -144.8, -23.3);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (5, '23', '22', -23.85, -83.63, -44.38);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (6, '44', '6', -76.31, 110.45, -59.56);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (7, '15', '21', 7.42, -33.63, 65.76);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (8, '48', '10', -21.34, 16.12, 12.58);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (9, '33', '1', -2.14, 114.42, -33.5);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (10, '32', '5', -1.04, -165.62, 48.6);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (11, '24', '17', -23.86, 107.04, 59.66);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (12, '42', '20', -10.54, -160.8, -55.24);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (13, '10', '19', -27.68, 45.22, -3.17);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (14, '39', '3', 46.1, -78.9, -38.66);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (15, '26', '4', -24.35, -142.62, -3.44);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (16, '20', '18', -57.76, 53.17, 87.46);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (17, '45', '8', 29.0, 72.24, 79.67);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (18, '27', '25', -88.62, 138.86, -68.19);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (19, '28', '15', -16.71, 173.13, 88.51);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (20, '9', '23', 74.82, 41.51, 48.05);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (21, '11', '24', 67.1, -68.13, -78.38);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (22, '16', '2', 62.37, 173.52, -85.83);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (23, '19', '12', 13.43, -16.64, 60.58);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (24, '43', '11', 50.86, -133.86, -86.16);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (25, '5', '9', 5.18, -25.32, -0.41);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (26, '25', '17', 60.37, -96.76, 82.16);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (27, '40', '24', -59.48, 53.37, 26.06);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (28, '4', '1', -26.67, 46.13, 86.9);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (29, '34', '20', 78.82, -131.27, 38.56);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (30, '3', '13', 45.2, 54.26, 83.1);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (31, '8', '18', 54.87, 25.74, -63.45);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (32, '1', '4', 67.85, 101.5, -78.08);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (33, '38', '2', -10.19, -3.87, -79.18);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (34, '50', '6', 0.7, -113.28, -16.34);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (35, '49', '19', 88.37, 4.65, -12.94);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (36, '22', '3', 12.91, 161.85, -39.84);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (37, '37', '14', -73.74, -3.2, -34.03);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (38, '12', '9', 83.86, -35.56, 75.68);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (39, '13', '5', -47.41, -135.32, 61.19);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (40, '36', '16', -65.63, -162.36, -5.24);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (41, '14', '8', -63.78, -7.12, -56.78);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (42, '6', '23', 68.53, 155.87, 75.91);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (43, '2', '21', -81.41, 67.45, -20.19);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (44, '41', '15', 74.77, -176.34, -0.69);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (45, '46', '10', 87.34, -74.82, 71.34);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (46, '17', '11', 61.88, -8.75, 64.18);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (47, '29', '22', 59.65, 6.19, 71.49);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (48, '7', '25', 38.8, 60.14, 67.72);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (49, '30', '7', -71.86, 90.53, -30.81);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (50, '21', '12', 88.91, 85.49, 17.37);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (51, '14', '21', 27.26, -48.17, 56.51);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (52, '36', '9', -69.83, -144.73, 47.68);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (53, '49', '22', -71.45, 32.4, -31.21);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (54, '1', '1', -12.66, 99.97, -41.08);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (55, '4', '8', -57.36, -18.16, 50.89);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (56, '45', '15', -78.53, -83.49, -36.16);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (57, '32', '13', 31.92, -57.37, -23.54);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (58, '13', '18', -66.04, 90.49, 26.42);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (59, '44', '4', 84.21, -48.76, 74.75);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (60, '47', '23', 85.89, -168.17, 28.52);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (61, '5', '5', 68.62, -47.04, 28.37);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (62, '30', '11', 36.6, 84.67, 13.19);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (63, '21', '7', 50.83, 163.78, 1.95);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (64, '16', '20', 83.6, 42.71, 47.68);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (65, '23', '17', -16.43, -3.6, 81.95);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (66, '3', '3', 20.66, -168.29, -55.25);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (67, '24', '6', 83.87, 92.07, 15.35);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (68, '8', '25', -79.93, 177.67, -4.79);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (69, '18', '2', 73.52, -62.65, 17.67);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (70, '26', '24', 13.9, -11.03, 3.04);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (71, '10', '12', 69.11, -128.36, -17.6);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (72, '25', '16', 48.98, 21.87, 72.69);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (73, '43', '19', -54.81, 119.07, -42.1);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (74, '34', '10', -47.44, -49.38, 80.99);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (75, '20', '14', 29.67, -119.86, -63.45);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (76, '50', '22', -5.03, 164.58, 87.39);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (77, '33', '23', -42.54, -26.09, 74.25);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (78, '19', '2', -77.01, -80.08, -89.98);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (79, '42', '24', -49.98, -54.61, 4.7);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (80, '12', '12', 51.57, -61.32, 51.16);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (81, '35', '1', -89.39, 47.57, -1.55);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (82, '17', '10', 3.35, -92.52, 69.45);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (83, '41', '16', 50.61, -127.61, 88.54);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (84, '48', '8', -69.71, 156.31, 68.65);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (85, '40', '9', 9.57, 165.69, -14.41);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (86, '27', '4', 25.8, 176.95, -61.18);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (87, '38', '18', 78.0, -120.51, 25.02);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (88, '6', '11', 81.55, 124.83, -29.47);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (89, '46', '5', -42.39, -66.88, -14.66);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (90, '11', '7', 65.14, -107.48, 12.77);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (91, '39', '6', 25.59, 161.26, -42.85);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (92, '7', '3', 86.8, -61.81, -53.55);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (93, '29', '19', -55.06, 120.46, 47.58);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (94, '22', '21', -71.44, -104.73, 18.38);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (95, '31', '13', 72.72, -124.79, -62.29);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (96, '15', '25', 45.67, -32.62, 51.78);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (97, '2', '14', -69.12, 15.39, -54.41);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (98, '37', '15', 5.29, 79.76, -59.37);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (99, '28', '17', 36.69, 53.47, 52.09);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (100, '9', '20', 71.53, -148.11, 13.09);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (101, '17', '8', 74.01, -137.34, 26.24);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (102, '50', '1', -20.96, -97.6, 26.6);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (103, '37', '7', -24.26, 37.8, 67.07);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (104, '47', '6', 77.26, -87.48, -79.99);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (105, '4', '23', -0.36, -48.06, -23.7);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (106, '43', '13', 27.95, -8.47, -58.7);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (107, '20', '20', -46.04, -131.83, 55.44);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (108, '27', '5', -55.39, 52.21, 47.96);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (109, '13', '24', 72.03, 61.9, 9.75);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (110, '19', '18', 8.56, 83.3, -3.09);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (111, '34', '17', 87.8, 44.96, 57.68);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (112, '29', '11', 20.99, -7.71, 79.42);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (113, '14', '16', 82.18, 18.26, -53.43);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (114, '46', '2', -72.65, 36.61, 77.73);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (115, '3', '21', -55.94, 139.45, -82.94);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (116, '48', '25', 87.74, 25.82, -60.55);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (117, '6', '4', -53.09, 10.88, -86.65);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (118, '8', '9', -45.3, 35.48, 39.27);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (119, '36', '19', -57.99, -56.48, 48.19);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (120, '5', '12', -9.69, -24.3, -15.01);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (121, '31', '14', -28.53, 160.99, -18.23);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (122, '40', '3', 1.82, 85.5, 85.95);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (123, '25', '10', -62.57, -91.47, -33.9);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (124, '30', '22', -33.18, -72.04, -75.43);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (125, '12', '15', 11.03, -5.52, 70.86);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (126, '42', '24', 12.07, 56.58, 30.56);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (127, '22', '4', 37.36, 101.4, -33.21);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (128, '15', '18', 49.64, 65.4, -9.62);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (129, '7', '12', -65.55, -47.43, 37.64);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (130, '33', '15', 27.65, 166.88, 2.59);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (131, '18', '8', -38.25, -30.72, -38.56);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (132, '24', '3', 87.75, -119.41, -65.34);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (133, '21', '10', 48.4, 4.17, -18.05);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (134, '41', '6', -23.28, 42.0, 14.33);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (135, '9', '9', 42.1, -97.51, 47.42);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (136, '2', '21', -23.19, 106.79, 77.92);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (137, '28', '11', -41.74, -165.73, -62.94);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (138, '10', '5', -69.77, -177.08, -79.74);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (139, '23', '23', 49.83, -136.47, 28.61);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (140, '26', '25', -4.94, -77.72, 28.87);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (141, '32', '20', 71.58, -98.73, 65.02);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (142, '44', '1', 32.35, 84.92, -11.04);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (143, '38', '16', 69.44, -68.73, -33.94);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (144, '11', '19', -27.77, -129.11, -74.58);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (145, '49', '17', 74.88, -65.68, -70.22);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (146, '1', '2', 2.88, -90.29, -19.79);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (147, '45', '14', 47.53, -7.78, -83.94);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (148, '16', '22', -20.84, -157.48, -68.9);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (149, '35', '7', 36.82, -76.27, -43.77);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (150, '39', '13', -48.48, 93.97, 9.82);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (151, '17', '19', -34.89, -69.67, -33.86);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (152, '4', '2', 16.27, -102.14, 29.65);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (153, '25', '7', 12.66, 48.85, -28.86);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (154, '31', '23', 22.6, -124.09, 13.97);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (155, '22', '9', -57.16, -128.01, 13.91);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (156, '37', '24', -9.67, 174.97, -12.82);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (157, '26', '25', -12.73, 164.61, -44.08);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (158, '14', '5', 89.72, 50.49, -71.74);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (159, '3', '22', -20.28, 5.27, 62.49);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (160, '34', '8', 29.79, 154.41, -73.74);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (161, '35', '15', 69.84, -80.91, -22.31);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (162, '13', '3', 23.72, -171.24, 39.99);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (163, '44', '13', 17.23, -115.39, 55.6);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (164, '21', '17', 31.58, 96.91, 58.35);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (165, '5', '16', -44.99, 174.36, -86.24);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (166, '1', '10', 71.94, -179.55, 56.01);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (167, '27', '12', -22.94, 85.37, 2.9);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (168, '18', '18', -1.36, 29.05, -64.12);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (169, '50', '21', 38.12, 141.27, 60.34);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (170, '38', '11', -3.4, 159.53, 31.77);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (171, '6', '6', -55.68, 156.06, 71.44);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (172, '33', '1', -89.09, -29.83, 78.38);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (173, '47', '20', -43.28, 102.66, 23.83);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (174, '45', '14', 16.38, -100.85, -79.6);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (175, '19', '4', -56.4, -37.33, 69.97);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (176, '20', '19', 82.32, -69.31, -1.63);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (177, '16', '11', -12.24, 88.69, 13.36);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (178, '2', '6', -1.44, 118.34, 27.25);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (179, '36', '8', 63.09, -22.35, 26.08);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (180, '49', '2', -55.07, -138.84, -11.29);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (181, '40', '18', -4.91, 62.46, 55.21);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (182, '24', '14', 32.34, -179.78, -68.76);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (183, '15', '7', 35.98, -44.91, 41.49);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (184, '28', '13', -31.9, 69.0, -36.03);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (185, '48', '21', 27.76, -129.61, 84.98);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (186, '30', '15', -15.34, 129.36, 24.16);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (187, '32', '23', 58.98, -66.56, -40.95);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (188, '41', '5', -41.77, 72.03, -48.4);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (189, '12', '20', 13.95, -123.03, 3.05);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (190, '7', '16', 7.83, 62.07, 43.53);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (191, '42', '17', -59.35, 168.67, -32.85);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (192, '39', '3', -30.89, 75.19, 26.41);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (193, '46', '9', 32.15, 138.9, 9.89);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (194, '29', '24', 64.65, -5.75, -86.59);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (195, '11', '1', -61.34, -118.27, -4.36);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (196, '43', '10', 12.59, 77.07, -25.97);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (197, '9', '22', -85.15, -139.72, -89.04);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (198, '23', '25', 14.43, 170.28, 32.97);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (199, '10', '12', 4.02, -32.2, 19.36);
insert into VideoStream (ID, DataScoopID, ZoneID, pitch, roll, yaw) values (200, '8', '4', 31.91, -93.49, -72.71);

-- SELECT * FROM VideoStream;

-- ZoneData
-- Generated with Mockaroo
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '14', 35, '2023-06-22 21:31:06', -2.0980751, 36.7819505, 1887.94, '8b2ac297bcf1744f291e3a5e2154aaeaf52cdc5b', 39.28, 165.567, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '11', 35, '2024-05-06 11:39:46', 1.5604242, 103.6384827, 1837.04, '8a9b3a7e2ca40f15766463614f943fd445885cbb', 22.47, 45.068, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '38', 36, '2023-10-24 13:49:54', 36.902846, 116.331293, 2776.22, 'c9613be9afffbef672775dc90b3d87fa99cd367c', 27.45, 151.393, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '20', 18, '2024-02-22 18:13:06', 18.0616657, 37.8087693, 4548.04, '80ece53c1233ccd0955de209fee3e3a640154a7f', -1.07, 199.856, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '27', 21, '2024-04-28 12:17:06', 23.11153, 109.57224, 5548.13, '8795bea19a6ff17af96f4b70823576ff29ac71f1', 31.36, 125.235, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '43', 26, '2024-03-09 00:34:57', 57.7868036, 38.4503218, 3571.07, 'b356bcf9c9df2ff29259d677d6ae4cf1492ff92c', 18.02, 79.11, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '13', 27, '2023-11-23 04:56:18', 30.8254669, 30.8139165, 2006.45, '18e67f554a977f2d03fcac78bc578e513aba4bc1', 9.04, null, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '28', 28, '2023-07-20 02:58:49', 44.0086458, 22.9355752, 3463.67, '42e7ca5bd60f79aa90570b4593882eaf4482c680', 11.98, 141.387, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '12', 31, '2024-02-11 20:00:46', 15.8515169, 104.1698463, 1480.88, '82041d33920d779336737cad5a8bd5fdaa042413', -1.18, 58.068, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '31', 48, '2024-03-15 22:26:16', 36.330099, 115.688238, 3823.83, 'ca41855c77c7eb3aa67780194077cc0f1a75dd41', -7.76, 247.496, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '8', 48, '2024-05-27 00:21:15', 56.5385265, 14.1115837, 5468.46, 'f3511e661b7f781d420bcbd22007348c643327a2', 8.74, 159.782, 0.18);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '21', 2, '2024-01-08 12:45:25', 29.2, 94.08333, 1842.02, '7778848fa828d2996948f44510207dad7c323726', 34.87, 135.219, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '35', 10, '2023-06-19 14:13:23', -0.670315, 100.962601, 7.77, '7f74fe5a9474d8141b8a1d65c015c3650da654e9', 7.8, 126.949, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '25', 17, '2024-06-06 15:07:57', 48.892701, 2.233089, 4588.81, 'bb0a85e0ead975bea49de2a82169d5a4443ac58f', 31.91, 87.742, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '1', 32, '2023-12-28 06:59:35', 39.9396284, -75.1866396, 2365.34, 'ede00dae99913833f9c0b287d7c057f0f3da581f', -8.45, 49.13, 1.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '7', 43, '2024-04-21 15:06:19', 7.253201, 80.510807, 1181.92, '807a794a1b2350a5cca4245fd755356053a4bc60', -0.96, 217.049, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '3', 43, '2023-08-27 18:09:15', 23.07555, 112.007814, 4155.92, 'a53c5fc10bb9ed57a9f70e064f4dd69f86707ee5', 0.85, 12.696, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '9', 52, '2023-07-05 17:03:41', 34.329605, 108.708991, 4932.88, '393dc366d850f87cb2cbc2b51b77d28af8e1b9ec', 1.59, 143.154, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '10', 52, '2023-09-21 06:32:04', 16.08532, 120.03164, 262.34, 'd59ef55a8d1fcecf6c421eb2c7120655a6a55eba', 33.61, 251.078, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '37', 52, '2024-05-12 14:45:48', -3.3419323, -60.8609358, 1209.96, '7c188efe9e4faa56b6556ca8e99b55e387267e18', 15.73, 79.047, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '24', 55, '2023-12-07 21:02:57', 60.7651227, 26.7869193, 2789.1, '1edab590e9a875943fd83d999b679c5e3d4f8289', 1.79, 31.824, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '29', null, '2024-04-28 22:57:58', -21.1661005, 27.5143603, 3344.54, 'ad3596e625dc53e9b1e4828d651c0c6c3d6938d2', 19.71, 121.584, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '16', null, '2023-09-05 13:22:50', 31.4784522, 71.2845323, 4866.72, '74319bb23687d4800810235240320fa9e4dc9bfb', 35.6, 35.242, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '44', null, '2023-07-15 17:29:20', -28.5600363, 29.7779991, 3111.68, '7f909cfc562ac8daa9829e0ba1fa181d0bdfa1d8', 10.65, 104.236, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '4', null, '2024-02-13 19:46:16', -9.9836173, 124.4420073, 1859.64, 'e82898bfe6f4f2edb0a40318b0b5e18022fae08e', 0.54, 189.439, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '45', null, '2023-11-08 05:13:47', 48.655181, 25.7096503, 1645.07, 'd6ee88d9cc214edcb78b5b1848519ba3be8a6e78', 7.03, 8.341, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '49', null, '2023-08-20 08:09:24', 15.7924989, 120.988562, 4624.48, 'f0d69c1a382dc3db9532acef41949627724d520e', -9.66, 65.104, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '33', null, '2023-08-20 04:16:33', 38.7993886, -9.3855593, 765.76, 'c53949fc2fcbc977db91fd820a707ce0879bb76b', 11.24, 154.64, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '34', null, '2024-03-24 21:26:42', -26.1827713, -56.3712327, 3828.82, 'ecd0fc28237101a55d559dcbf3fd008315e5e929', -5.94, 181.019, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '32', null, '2024-05-11 16:21:39', -10.1508133, 123.4551696, 2129.6, 'c7cc909eedce451e3f0ab6ab195a286c28e9660b', -3.02, 196.793, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '39', null, '2023-11-03 01:32:49', 5.8926053, 95.3237608, 5009.14, '3687138e020ff908420797108e5feb322e42f39c', -2.64, 175.765, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '19', null, '2024-04-08 19:57:03', 69.4269147, 30.820151, 2388.5, '413d07c2b2e4f3a24bc741afcfa8c9279989586c', 29.88, 236.587, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '36', null, '2023-09-07 12:11:44', 52.2060223, 23.083666, 2133.62, '7f095a2d26548b3d6b3efc985a38473ac9389b68', 26.93, 49.814, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '46', null, '2023-07-23 06:25:24', 6.8517845, -73.111356, 4372.92, '8a1f49a2521651aaa05e8cdc04b286c0479e90de', -5.94, 15.445, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '15', null, '2023-12-11 23:18:54', 14.6101685, 121.0088573, 1799.08, '9001980ed6a0160226b1500933403d8cc4c06841', 15.61, 144.551, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '47', null, '2024-05-09 13:59:40', 42.1102695, 44.7710122, 5550.84, 'b4ae26c4c6747254d9296385deb5d4f0dda6ff8d', 3.83, 211.874, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '18', null, '2023-11-05 18:53:31', -6.3079232, 107.172085, 5099.65, 'deb616e09ae840e4bf8680a688a070a3d49828c1', 26.63, 120.153, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '17', null, '2023-09-26 16:29:58', 42.8913909, 20.8659995, 5130.52, '1a4570ab787c3ae59e74b625243114e3cf676137', 19.36, 155.507, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '30', null, '2024-03-13 03:00:31', 60.9116468, 34.1661641, 120.32, 'e8d4476f2ef2ea246adf27eb020cd2a43f8362f0', -9.44, 183.348, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '41', null, '2023-08-14 07:13:29', 53.0641593, 38.0521393, 4464.77, '382e6b1602c436aa6e014f4db4daf92150863236', 6.07, 126.635, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '48', null, '2023-09-05 06:18:49', -22.0227557, -63.6775234, 511.54, '80f4e9a22cac3a38781c3a55b5c21ce7be51a926', 10.47, 6.238, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '5', null, '2024-01-29 12:10:18', 50.177791, 22.6095389, 3997.5, 'd1deec5cf49b9283de5d1a1497f9534071f57f06', 23.61, 247.906, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '23', null, '2023-11-07 08:43:35', 22.6695494, 113.2476081, 3757.97, '94b0d47300ae993de3c3d053f5f6f51fdd6be5cb', -3.56, 82.752, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '50', null, '2023-07-30 02:30:49', 39.863008, 124.1527051, 3177.56, 'f72bb27bc6ee4d26dfbb0548bfbccbe8bc7a9527', -6.35, 76.827, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '40', null, '2023-08-03 12:06:30', -20.811761, -49.3762272, 2026.95, '34bf10e1a8bb38d8261473e21bed2712c9dcd833', 29.75, 9.232, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '42', null, '2023-11-15 23:23:25', 50.4863542, 24.280156, 5154.04, '864ae96ef22d401ab054ca4243029b333fa44540', 16.18, 12.428, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '22', null, '2023-11-20 17:38:45', 45.054478, 7.6579399, 4902.2, 'a2cbe8ff68cacb35ab7eab21ea9a0e8b928259f7', 1.78, 137.844, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '26', null, '2023-11-21 19:06:04', -5.383454, 25.7456852, 5350.45, 'd4ed6ccf2e0c922b177c009195631d83fc78ea26', -4.92, 187.557, 0.3);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '6', null, '2023-10-07 23:27:10', 19.482042, -99.1985584, 5084.44, '053ca9a57312fa263ae816060809a39f3f1a1fbb', 10.41, 188.966, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '2', null, '2024-03-20 19:26:38', 23.359121, 103.160034, 2889.98, '2fed72d00a0fabab5c136088cafd389e6c5a2f90', -0.03, 238.939, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '43', null, '2023-08-16 23:04:41', 6.0102236, -72.4494848, 4128.63, '84d4695f6cb2a86ff8faf1be701ef0e2e8ccebf5', 6.55, 179.173, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '37', null, '2023-08-14 09:54:22', -7.703889, 36.9565089, 2943.53, '349ce406bcdb1c75086616643283120a416aadf0', 26.86, 229.68, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '50', null, '2023-08-28 16:43:09', -26.4912117, 29.2335299, 33.79, '0eb6f3d3576e078ff7e794d6b4754283d1c1d474', 39.92, 149.962, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '47', null, '2024-01-27 06:32:36', 32.060255, 118.796877, 5023.35, '475e249e80137d5d7bbcdf426fae62d1e29c4689', 25.87, 27.864, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '24', null, '2024-01-21 19:40:12', 34.2948431, 117.1897677, 3388.51, '801384227d19c3fe5028e5f701aa85e4e22904e7', 16.96, 214.09, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '45', null, '2023-09-18 23:15:18', -7.5178871, 109.0572086, 2251.61, '4637bceabd23279a69fbbf97d1075290bca78742', -5.5, 224.227, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '39', null, '2024-02-12 03:03:33', 31.6749725, -106.4181775, 5289.72, '51e8d7fb952e0824bd8fb35eebdf4a540bb92d06', 19.91, 182.058, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '15', null, '2024-05-18 15:47:57', -6.183459, 106.7647475, 3111.05, '7916697c873de9387901c29f1a31391075572486', -4.09, 70.61, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '36', null, '2023-06-26 14:36:09', 51.8113447, -8.3929404, 5096.73, 'ff0963ca4002c14d8ca7a70e04118bbdea8cb57c', 31.36, 0.714, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '4', null, '2024-02-22 22:10:56', 49.0915297, 1.4784611, 4189.83, 'd59fd18ef16ae353a9d7ecadaebb188437d51e0f', 18.18, 11.897, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '2', null, '2023-09-30 11:11:48', 28.2442799, 104.1435113, 2959.07, '81f8f4299ec4e004354dcb9bfc8bad76fb3df88f', 25.91, 118.155, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '1', null, '2023-07-13 00:41:26', 55.1936526, 75.9684541, 1507.36, '11a95005a1900dbd67f160048c79a71570481d45', 24.43, 53.667, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '41', null, '2023-09-14 10:33:00', 35.937102, 116.470304, 2066.11, '0a4d21390bbb87d357321385e0ad56b105d839b7', 17.64, 51.569, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '34', null, '2024-03-29 23:07:10', 14.6208802, 121.0425592, 5057.02, 'a2512b522e3085670fc440945797f8030acdc660', 27.27, 180.478, 0.46);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '29', null, '2023-07-06 15:23:06', -3.0423379, 120.1733631, 2066.86, '75f326c0626648e0e8f05a38b3a61f9e56820426', 9.85, 144.023, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '6', null, '2023-08-20 20:03:23', 32.519016, 34.904544, 4161.0, 'ca8208271531cf0e1369968c55f7ffa5bfa0320d', 38.87, 128.338, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '27', null, '2024-06-05 11:24:04', 44.5591908, 18.6917335, 3357.84, '35405e4d14af6aecdbb405dac040fa3dc6026332', -0.15, 59.488, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '3', null, '2024-04-01 09:08:51', 43.1790617, -86.1853474, 2038.53, null, 7.99, 51.011, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '14', null, '2024-04-22 04:04:45', 43.3572645, 16.9520477, 2552.83, '9934a6e19ada753dfb8702244462292ee552ebc2', 29.83, 132.486, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '8', null, '2023-09-18 09:31:33', 61.3649277, 24.6566461, 1569.48, '14ce0266e9eb28ad68884771931462000ec16214', 17.59, 70.286, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '17', null, '2023-11-27 02:51:18', 22.8429803, -82.0243657, 1783.65, '5551f9ffda297bd227619f40e2c2a312247eb08c', 9.98, 59.893, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '25', null, '2023-12-11 09:37:17', 49.4992, -98.00156, 4035.26, 'df76f3d67d17ccebece29a049a9fc3f290b8e8a3', 32.79, 194.83, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '20', null, '2023-09-08 04:45:09', 9.9241833, 123.9181504, 3332.81, '610c750ead6bfc2202ea297de12dfc4985f4df81', 8.33, null, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '23', null, '2024-02-10 01:09:44', -7.1724, 111.501, 4862.77, 'd4be3e37f62f12c5837dae0cc0b1971f28715099', 0.12, 174.392, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '21', null, '2023-10-17 04:14:46', 52.9718428, 63.1128326, 4320.72, 'eb0a52599e65557229367e531d5b0b187c0081dd', 5.12, 68.104, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '46', null, '2023-09-07 13:24:45', 51.2928924, 12.4645518, 2093.91, 'd7bf8728421a7a366f12a08fce39580784929507', 19.2, 33.072, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '12', null, '2023-12-06 21:14:24', 51.5182635, 46.0058803, 230.08, '8f9a8a8270c07774fc3317b073df3f41560b560c', 21.32, 161.576, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '16', null, '2023-07-17 11:54:42', -6.984842, -79.621117, 3072.98, 'cd0f6472c916cbf7860575262d7975312db93e79', 13.31, 222.653, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '7', null, '2023-11-20 06:15:17', -18.8549317, -41.9559233, 15.07, '55ef1dad9fe0f49a3fd48a2f388dd5d4974b6192', 4.97, 121.048, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '10', null, '2024-05-31 08:13:44', -27.0361696, 28.61481, 254.46, '428af9bfcbfd6e4b73d318b8ab7d252a48bb08f8', 20.12, 62.44, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '19', null, '2023-09-13 00:13:08', 54.1212091, -108.4295552, 2577.49, '2b550fa7acbd9170de67492da5980abeaa6a3042', -7.64, 226.799, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '33', null, '2023-12-03 07:29:43', 10.6253016, 103.5233963, 5608.66, '42adbf5533495f8564238cb0a299c7986821aa71', -5.39, 75.297, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '26', null, '2024-05-29 12:12:24', 29.1253133, 116.2777073, 2169.95, '7b3a5e2097fb68d926ee674f71c5034c205a7c2c', 29.08, 64.809, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '44', null, '2023-07-08 17:52:37', 15.334879, -15.474739, 3100.41, 'f0c20bd05eb4dab1c7e8f3d16fea7d08d8a8203e', 36.15, 95.32, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '18', null, '2023-08-30 12:29:32', 43.6410973, 51.1985113, 3630.03, 'ddc7cce88c0eb14136c08d9cc74d7670912a8d13', 11.03, 55.42, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '22', null, '2024-04-05 02:35:39', 9.2559967, 118.4057103, 2844.95, '99dded7127a1a57ff6aa41c983985041108d2df7', 30.01, 39.465, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '42', null, '2024-01-31 15:54:18', 36.2145292, 28.116926, 2347.99, '54c43d31145d3ac4bbf2f37e0b15693ff7589ea9', 38.66, 88.119, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '31', null, '2023-07-21 18:41:44', -9.4020529, 34.0195827, 517.95, 'f67210fab38722b1b1e7692147ade9a69169027a', 38.89, 45.595, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '5', null, '2023-07-02 08:52:15', 32.38051, 35.50838, 3177.31, '7de0905a78852c526185999cd962e0886461b2fd', 17.1, 114.047, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '30', null, '2024-03-16 02:53:13', -6.859269, 107.4702845, 1663.08, '31cdea70699162139d0cd45ad7314487362e2477', 17.46, 145.531, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '35', null, '2023-07-16 07:59:47', -23.4217742, -49.0924714, 3263.36, '86b426bf2aa80695846eedd263f6a6d71180cc8c', 7.63, 61.897, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '48', null, '2024-03-22 13:41:17', 44.0766295, 132.3885311, 2318.97, '095d272902fc2611f688e97fe24a1f75f14c5a82', -9.74, 31.438, 0.18);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '49', null, '2023-09-08 00:38:20', -26.0880026, 28.1444516, 2419.01, '73fd131e7be5e60ccd022e27661735578b62c284', 22.36, 12.281, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '28', null, '2024-06-12 08:43:24', 15.45033, 44.12768, 5786.98, '01c1150fa7f7456f661a22c3a0cc325ee834330d', 24.41, 53.457, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '38', null, '2023-07-05 14:02:46', 35.8036079, 126.8808872, 4034.15, '1691b0d78b0dcae5861162ca5da4548c563dc533', 21.3, 241.907, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '9', null, '2024-02-19 02:52:17', 59.8794468, 29.9105627, 4189.54, 'c917e71dacf64b31aaf5a75ffa6d3d9ea2aaffc1', 19.45, 4.667, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '40', null, '2023-06-26 06:40:40', 41.4655177, -8.577596, 4977.15, '05fdb25a6396a1886a68ac98c16f55f4223d6ded', 26.98, 234.565, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '11', null, '2023-09-17 17:13:42', 44.889488, 117.470597, 1814.6, '5b556a44326650cd9ea22cbea9af82233633bf18', 2.38, 125.276, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '32', null, '2024-03-16 00:10:22', 55.1653099, 37.6076437, 4449.16, 'ebce16edde9ad56fe06774e75674849f2707d9fb', -5.25, 125.679, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '13', null, '2024-02-16 10:40:06', 44.4868448, 43.9408057, 3050.81, 'a545dec28d1be9537632f0e2fbfa3c46209f460f', 13.97, 75.439, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '39', null, '2023-09-15 09:21:21', 38.995854, 117.688815, 5472.98, 'd22ecc42b339f65c31509bd9bafeab2a85d853ec', 19.08, 211.17, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '40', null, '2024-01-12 00:05:00', 49.8693962, 18.7571935, 868.8, '7f705c287a21ea9945f9242ea5d75a6e9fff9d83', 20.81, 107.26, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '5', null, '2024-04-18 00:36:17', 9.658955, -9.776234, 489.88, '0774c7c6b4b65977e312b3403395b372bcdf2504', 26.92, 137.118, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '19', null, '2023-08-10 18:25:17', -7.0638, 113.5187, 4581.64, '79515e8ced3df4ecf1f640ee61bab25a59f250cd', -8.02, 133.754, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '29', null, '2023-09-25 07:24:51', 38.9080786, -77.0406147, 3661.38, '1451cdd56c0ad79b1767c3eca3ac79d00e697c2d', -1.79, 90.048, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '20', null, '2024-02-06 10:59:32', 20.8743656, -101.5188815, 934.02, '9545464cf2fcde74148f239eb4314465125d1e3c', 38.16, 251.569, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '50', null, '2024-01-29 13:54:41', 34.7179437, -92.3714901, 3187.71, null, -8.6, 174.045, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '24', null, '2024-02-26 00:52:17', 39.8731369, -8.6795117, 5050.91, '12992f4497aac832733003e2e59e283831ea2476', -0.67, 177.489, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '21', null, '2024-04-23 23:44:25', 53.3895926, -6.1097188, 3053.02, 'b0f53c5df42275af65168d5a6c1cf4dd5240218e', 17.88, 69.098, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '48', null, '2024-01-04 20:14:46', 41.5094765, 19.7710732, 3394.84, '9943e8cf11fc4253350b35b4c582e5e80d01a252', 27.71, 114.085, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '16', null, '2023-11-26 16:18:57', 41.43999, 22.79536, 5651.22, '7212b678909d277c22009c5e8d3f2fd894a6571e', -3.79, 138.308, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '23', null, '2023-08-28 11:17:02', 8.6791925, 16.8591387, 2990.17, '47abf520a72331c65d2dd5d67fe6727882def0df', 25.97, 29.833, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '15', null, '2024-01-13 05:04:36', -6.371137, 106.022874, 165.4, '1b7866b2faa39ea75504bcba47149627291346d6', -4.05, 251.794, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '28', null, '2023-10-27 08:45:37', 45.056443, 43.6468877, 4933.44, '9e94c603bb197dab91552906b77d1975f45366de', -3.03, 251.898, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '13', null, '2023-09-28 19:04:59', -3.5594169, 33.4075149, 3753.54, 'c4e79dd213cc50b36ec4a589f2329147b200204d', 0.4, 221.315, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '12', null, '2023-10-16 03:30:39', 9.338241, -66.2575425, 1068.98, 'd625245dc35db55916d0a27710523ac257031f97', 36.61, 233.546, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '9', null, '2024-01-05 00:21:02', 52.3974171, 19.735653, 3182.91, null, 36.03, 131.262, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '42', null, '2024-05-28 18:44:48', 49.6475739, 6.2573108, 5805.77, '15fc1bb9d066d6ae8dede108f6e1016d058ade8d', null, 1.341, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '31', null, '2023-10-10 14:09:39', 39.134282, 113.200971, 504.11, '72de704a0b3da02635096474d83424f101d241cd', null, 218.939, 0.37);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '44', null, '2023-09-20 06:32:52', -20.1514708, -44.2010909, 130.52, 'be14f8d7d202a72fb7c187a248340ead599bb339', 31.8, 78.21, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '14', null, '2023-06-15 16:40:55', 55.41667, 22.61667, 2678.28, 'd05fec769fdb73099fa946a4628d673007a0da31', 19.51, 172.335, 0.39);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '17', null, '2023-09-15 04:10:59', 3.1121428, 101.6935065, 1314.89, 'e46a9ab311a5dd444b3eddada2f7276b1051f462', 37.77, 183.967, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '32', null, '2024-01-10 00:11:14', 51.2487152, 21.5754229, 3221.78, 'da615f11bd7b92c019550837867e8613101dbb84', 24.34, 99.313, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '35', null, '2023-08-21 07:37:14', 14.7339333, 121.0688178, 4849.11, '7031050b46e80d49427c0e3432e4313185e699d1', 34.2, 220.319, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '41', null, '2023-08-17 21:30:39', 14.72328, 102.1609718, 1599.28, 'fdd511f1194afed987a831a90fefe800f4b7d557', 8.21, 193.954, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '49', null, '2024-04-12 01:37:36', 10.2535534, -67.9583246, 5521.65, '28976c3e201468c0173d2d61dabaa81990898fec', 38.15, 36.115, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '30', null, '2023-08-13 06:02:16', 33.53228, 38.00818, 295.03, '890857bde06958842fd07afe2b9bdc57f2df46b1', 24.75, 46.389, 0.59);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '34', null, '2023-12-03 22:04:47', 32.009016, 112.122426, 3670.91, '52ab8cdf92d8f09e6cfe5808fa5f2cd1ddfd6da2', 34.47, 68.18, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '43', null, '2024-02-02 17:16:27', 4.632147, -74.463014, 5247.07, '7a7f35ee7096d6f40b342d322d7c88f6c2f2fde5', 2.16, 23.076, 0.18);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '1', null, '2024-01-17 17:18:47', 38.259679, 113.993296, 1145.21, '9c4eb3af0249f4553304dace1de5e946a109ac6a', 0.02, 88.326, 0.3);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '18', null, '2023-08-07 06:14:17', -0.2467982, 109.6163185, 5809.52, 'd97c900634538b3e123a8ef4d004737ce1aa3e57', -3.69, 18.012, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '22', null, '2023-09-05 22:19:35', 40.02575, 124.2869167, 3603.4, '126fa81e486ade0205ba67c0c4bf3f57d5e2fc5c', 6.89, 129.029, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '3', null, '2023-06-23 16:13:56', -20.1674203, 57.7487911, 89.52, '7f7d6a2a9a1416e49b8ff0ff91b4ab533be39836', 21.32, 58.393, 0.75);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '33', null, '2024-01-28 22:17:17', 38.577099, 106.186518, 3166.78, 'ef835e514f83a7deadb64db210aca3f5f27a01b2', 6.17, 179.579, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '8', null, '2023-10-26 06:46:45', -7.7001724, -79.4338188, 1536.28, 'f3f1d987b20992ee55cb12b7c56367f3d706aba3', 10.59, 182.476, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '11', null, '2024-03-23 16:59:26', -6.9244162, 112.4142453, 4720.97, '8f1314f2951414a459276c69ed16d90e4aea4d95', 37.26, 58.969, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '10', null, '2023-12-27 04:26:19', 43.25, 67.65, 1471.35, 'ec004866ef3a06d705c521546d0588d83a79089e', 4.78, 37.455, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '4', null, '2023-09-05 04:50:06', -7.1845289, 111.5572638, 4898.23, '582d8685f8272880fc81f5d4280ec8cded245d69', 17.98, 14.791, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '6', null, '2023-07-01 19:59:09', -8.2412718, 112.0744643, 2124.0, 'ebbae8149f868647997d44e830f6b1689fe80ece', -4.23, 251.401, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '27', null, '2023-09-11 13:52:20', 6.848589, 101.4112049, 3903.63, 'e0a10e45072ac6e67e9698d7a32598de433117b7', 14.73, null, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '46', null, '2023-09-04 08:04:14', 26.244258, 116.512887, 569.9, '8e1fae8081e805bc84247d4aadbef91bb76eeae8', 0.16, 198.983, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '47', null, '2023-09-21 14:43:38', -7.3225, 107.86, 1889.59, '235b8d03c0b3cf9d2f3d5a2e47a4bbaf6b17fd08', 2.86, 204.788, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '26', null, '2024-06-08 09:34:06', 14.0206423, 123.2983232, 5579.61, null, 21.01, 211.211, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '45', null, '2024-05-18 17:38:46', 42.59689, 47.71824, 511.54, '6eddad9affb6dbdad70b078ff1108bc5ac9b5ad6', 25.03, null, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '37', null, '2024-02-02 10:10:43', -15.0705872, -57.1882847, 4024.46, 'd0a6711a3cb43c1d7586d130177377843abce88d', 25.9, 252.248, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '2', null, '2023-12-31 04:35:16', -6.5643956, 106.2522143, 2129.52, 'c681248c1c57bf20c9b0e9b9bd826ef19ffbf7e9', 28.04, 202.748, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '7', null, '2023-08-25 23:40:15', 23.212853, 103.952615, 3777.6, '3fa70a4eb8c59add1ef6f984e829f5f741941000', 18.15, 171.901, 0.46);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '36', null, '2023-10-21 18:01:28', 36.982186, 111.18115, 3543.85, '8c1813231295ae9df654083b9d35b0a9156c7191', 31.62, 197.331, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '38', null, '2023-12-15 17:07:45', 60.0190188, 30.648656, 3031.43, '5bd1ac95b0197bda7e28e1c9ff96ccd095edc9c4', null, 218.098, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '25', null, '2024-01-18 06:37:15', -15.49357, -71.465973, 134.18, 'efc4b1fbda73a6615312672aae8e19645969dd9a', 1.4, 98.344, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '4', null, '2024-03-05 07:38:49', 50.7588162, 17.8529769, 49.68, 'a2294bb8cb01650087750620e85b778b7573b5da', 38.59, 235.14, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '15', null, '2024-05-09 20:30:01', 37.74, -122.19, 2071.25, '70c8f1fbcda77a0b09fd5c953e297b6f3ddf2491', 10.04, 251.127, 0.59);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '49', null, '2023-12-30 19:20:04', -27.7145846, -48.5606259, 841.7, 'b96f7441a7fbe0c5f2c9859d3f84fe8449fad263', 36.99, 202.512, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '2', null, '2023-08-27 06:28:02', -6.797767, 111.3262355, 4664.1, '1c0928d633437f983210b800cca1f11e6d794583', -0.01, 197.273, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '7', null, '2024-04-10 04:29:40', 35.9202328, 39.1595698, 968.42, 'b854a357ca290c0ec252bb209a0228c95b71401f', 24.28, 74.059, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '39', null, '2024-02-22 16:01:36', 45.2415442, 77.9726477, 3945.73, '33600390aaa574756baf092ab83f857d10ace495', 27.22, 17.093, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '47', null, '2023-10-23 03:18:31', 36.1505981, -95.78793, 3245.33, 'f0ceeb0cd56eb61dbe7e58fb8e5fa7b2de469191', 20.27, 247.891, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '46', null, '2023-11-07 01:58:05', 20.7595709, -103.427389, 1456.72, '6800e31b9954aa81a0b9e516a6e9a5182acf286f', 13.17, 118.044, 0.75);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '41', null, '2024-02-09 21:17:47', 59.0110968, 16.2239747, 5533.32, '0a95c61a404386c35ef2888750c371996a3bb42c', 0.82, 161.723, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '23', null, '2024-02-22 21:59:33', 38.9025835, -9.040848, 3952.53, 'f1214064af7cbb5f196c10d182bce1b36473d1a1', -4.0, 140.142, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '13', null, '2023-11-27 06:39:44', -19.3088778, -64.3031372, 198.22, 'ed61ce1b9af4e7a9bc63fab9b752bab74d78f542', 6.39, 140.091, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '8', null, '2024-01-21 07:26:03', 32.0302286, -6.7969224, 2163.13, 'ba69e4900dd4c9e013f8959579e4c1d3f12ae851', -8.97, 74.58, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '35', null, '2024-05-03 05:15:23', -34.7097222, -58.3240611, 2111.0, '6a0b96e2792ad48e02ffd2b785f06cae402a2b3f', 28.44, 208.712, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '48', null, '2023-09-18 12:25:00', 31.172739, 115.008163, 460.12, 'e748f7fb41a83bb5080050cd893f743bd22c330f', 19.4, 107.41, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '26', null, '2024-03-29 08:15:42', -7.9454654, 113.0845936, 3983.88, '2ac8fa7466382d374aaff787f117cb5c8c0487c9', 4.69, 68.163, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '24', null, '2024-02-12 17:46:31', -4.9295129, -80.3408061, 1394.72, '1bfc6e8bef267786b67b7f4ee18cac94e7e2c620', 15.9, 57.173, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '9', null, '2024-05-09 16:55:34', 26.27436, 106.586543, 5401.13, 'd2265189799458e8bc9274dc054019c9210e6a9c', 12.17, 99.319, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '43', null, '2024-04-10 23:06:45', -22.38146, 27.59223, 4139.52, '96b3efc6f4868d44b9bd92fc4c5e674758963554', 7.2, 24.944, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '1', null, '2024-05-01 17:26:47', 19.88374, 109.745545, 3247.59, 'fa3ed63a380c3161f2e0414b5e021b8679122d5c', 10.81, 206.79, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '38', null, '2023-12-26 16:50:58', 14.8704596, 101.8322677, 491.53, '8e7eee2de8a2e58052aeb85aac7bca526ed1e4d6', 22.48, 149.331, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '33', null, '2023-07-04 14:09:14', 40.6294406, 22.0688549, 836.55, '6487140adf4ad5fdf364dcf41ac27f156c438b7d', 2.14, 61.569, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '3', null, '2023-12-06 15:15:29', -0.6193103, 117.1970557, 3366.55, '918bcfe7bc1c60951d0c249d239f0e579c8c749d', 37.08, 163.981, 0.37);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '10', null, '2023-06-28 10:29:55', 47.9956173, 0.1924459, 8.13, '2c82d6c86ceb3660195bf20442c7d0b3b78f085f', 17.36, 29.176, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '11', null, '2024-04-18 16:07:47', -13.2664976, -50.1513429, 3674.37, '60ec8d7993909ac526ec71794e14890bfc234ae1', 6.45, 246.351, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '27', null, '2024-04-05 19:15:20', 41.240005, -7.3038414, 3956.57, '4b602942dd98b598a48753de8ddf4b6c25009fc3', 11.14, 110.047, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '21', null, '2024-01-16 19:19:18', 18.9670072, -96.7313362, 5126.24, '29aae0f397543a707b470cfd979483f82c973e76', 19.85, 172.519, 0.59);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '16', null, '2023-12-17 07:58:27', -6.8243672, 110.7880536, 4117.39, '2c99699ffb3ed818fff65494cb270e8f5fe4f8f9', 21.13, 26.035, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '14', null, '2024-03-20 12:48:04', 14.5679608, 121.0233632, 1450.33, '6d93220634459ebe0c8cc8ceac50c2bd7813db45', 31.59, 9.541, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '20', null, '2023-07-20 11:10:37', 26.6849798, 100.7492159, 2536.86, '0ec923eb3aaeac82e4ed7122ae3204d726550df2', 25.97, 33.584, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '31', null, '2023-11-29 00:20:02', 9.2284759, -80.0856189, 3260.68, '2dc889ab8ed8b5ac1ffb068228fb7ceedb50277d', 38.38, 175.755, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '37', null, '2023-12-03 12:35:42', 2.1514272, 11.3317605, 5981.68, '9b5241c706dca82e8a273e95d3a3b094f52bf541', 37.05, 2.767, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '32', null, '2024-05-28 19:36:30', 46.8260183, -2.1318548, 940.63, '86bbbdb28a24763b9ba289e70735f03ba8420d99', 22.83, 212.87, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '25', null, '2023-07-05 02:51:13', 30.0007026, 117.9914358, 5362.41, 'e12b7804855e46a867247e9f366636efe5934f9c', 5.17, 221.723, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '45', null, '2024-05-05 00:24:10', 45.9724452, 16.9295441, 4909.39, '7715c11ff40047b32600f1d79eb76ebfa0e30451', -2.26, 89.872, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '44', null, '2023-11-09 02:51:06', 56.4459712, 39.6602235, 4608.97, '6d5e5b29512a2ea80b40f8d55a33c7ffafa583df', 9.28, 5.698, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '17', null, '2024-04-04 01:58:01', 48.9449573, 2.1463759, 2695.03, '07ef1235a663436dbad9d37de0d8025fbabca9e6', 9.7, 158.065, 0.37);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '5', null, '2023-09-30 22:10:49', 39.0369331, -9.1809626, 4564.58, '793fea7d18a784b948f07466fd1ff698825637d4', 29.11, 226.041, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '18', null, '2023-09-24 15:41:53', 53.7937151, 18.5248959, 3476.78, 'e4b94ba5082a64e0287555ef9bd6ecae5d75a281', 24.1, 176.89, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '22', null, '2024-04-21 10:45:23', 27.569678, 116.63704, 3925.95, '7c5923e3c8cef18e15cc45ca5cd1fcb2cd903a8b', 10.57, 96.869, 0.58);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '29', null, '2024-06-13 03:44:30', 46.6299289, 41.7340519, 4910.31, 'bdf655fc137ff20348e6e7d3d99745ac91c09320', 12.25, 156.599, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '50', null, '2024-01-25 12:19:02', -34.990888, 138.574391, 2564.56, '356a5f771adb2c7fe6fe078ed1dad1e235ae9058', 3.71, 22.531, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '28', null, '2023-07-18 19:12:46', 35.761829, 115.029215, 3068.25, 'e68d8f8a5f0679a7e0426552caf293713ced624e', 26.09, null, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '42', null, '2023-09-18 23:10:29', 9.338682, 123.291063, 370.46, '244869d5f15c5173396005151481d16ed7efd085', 16.94, 239.393, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '34', null, '2024-02-02 07:18:06', -6.9078493, 108.5908437, 2468.1, '7e621fec173e887e68ace9815a492ae0e955d213', -5.95, 2.22, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '30', null, '2023-08-09 15:48:03', 30.335237, 112.239631, 2903.38, 'ca6ccf0b4164994db135d55178a9565ed5432c5c', 27.03, 121.153, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '19', null, '2024-06-10 09:45:51', 59.2832062, 17.9570059, 315.72, 'a92446c3a5436bb165d441377ecd5be6a032c94c', 33.09, 48.643, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '36', null, '2024-01-03 01:12:38', -8.1129167, 112.5987727, 4397.09, 'ca7a8f656721e543e4bc9dd31e095c46fc31bfa5', -1.48, 48.681, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '6', null, '2024-02-24 00:29:46', -6.9415153, -78.1350635, 2640.29, '2b9e2b92529cc2187c7f358bc21c6f1fc5d1c8c6', -0.57, 186.982, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '12', null, '2023-10-06 03:16:13', 36.307064, 120.39631, 4058.0, 'dfa4c1bb0186c6e8c1a300a5e591abd80d40e560', 17.98, 149.014, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '40', null, '2024-03-20 05:50:57', 9.600306, 124.105576, 152.86, 'edd7c9a5dc2fd08d8ca63f67711ba7d92f781bdd', null, null, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '38', null, '2024-02-24 12:16:14', 53.7721333, 14.7790457, 5369.38, '6feeb22f64214dafb5bd1f39cf99301f16944b32', -0.37, 173.941, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '7', null, '2024-03-09 00:20:08', 51.7555981, 18.3095531, 3986.53, '38fb148d6728f916dcb08221a5df3c8c08843d9c', -7.1, 27.244, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '17', null, '2024-05-24 00:43:17', 31.364902, 108.249509, 1285.23, '865244aecfdee04e37d5da015b419e7e1cc4c949', 36.03, null, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '32', null, '2023-08-20 04:33:22', 34.31028, 108.975658, 3051.69, '379f9641c0e7d982b96a819ab317e23da95bb5ed', 30.8, 209.657, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '15', null, '2023-10-27 11:15:55', 34.949137, 104.470279, 334.5, '48b10aad0e1cdab5b1fa03a8da4a16552c4300e5', 20.04, 84.875, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '1', null, '2024-02-16 22:07:31', 49.4875115, 16.6599761, 4469.09, 'd90c7705d323001d7cab79903fe22dc6573579fe', 29.07, 14.311, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '48', null, '2023-07-07 23:11:22', 36.5292176, -6.2940354, 4233.1, '93ec0b2974c33656b2f18c9ceffa229320277764', 21.91, 0.38, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '36', null, '2024-04-16 01:35:06', 14.3160322, 121.0671937, 4148.87, 'e94fb94da7f548e5f33578406ad172de13102d5b', 36.37, 122.493, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '24', null, '2024-01-05 07:19:33', 18.2707494, 95.3207069, 5387.53, '194e396fb8423eb3298ea62db2d597247305ab4b', 15.08, 143.398, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '4', null, '2023-07-22 09:37:23', 58.3104915, 112.8975082, 2193.36, '377ebb5c4f2ac532050a96e8aa06ec32d9c707ea', 24.32, 244.45, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '43', null, '2023-12-28 18:56:44', 30.03312, 120.868122, 3700.35, '237e24cbaafd31038f3519471a6bb3a14fb50cd2', 10.22, 34.423, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '20', null, '2024-05-24 22:31:33', -7.7788197, 113.7692328, 2940.55, '687e640da2c9f1cf11e8ab660d03c149a7b90423', 12.36, 67.795, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '25', null, '2024-01-25 11:18:06', 13.4535926, 44.18389, 391.15, '08b5db94272916210295798e2e8c7247d12bc64c', -9.78, 70.549, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '29', null, '2023-06-19 18:06:11', 25.234479, 110.179953, 4686.22, null, 13.43, 110.181, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '34', null, '2024-05-11 00:15:17', 42.038041, -8.324549, 2247.21, 'cf010ca7b923507da9d2be85052307335ceb53ec', 8.87, 229.224, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '21', null, '2023-10-26 22:21:37', -23.527748, -46.3266408, 167.65, '87f3bd2131b0755ea6f3ba7b1734a60a97b36341', -8.78, 238.172, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '14', null, '2023-12-18 16:41:13', 24.9848125, 118.8310811, 3105.12, '0ff70767330baf909df4c3ddcc20cb3bbd59da3d', -0.43, 165.463, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '12', null, '2024-02-12 05:47:00', -7.1733576, 113.5103504, 3451.88, 'c6eaf98bdf5c2c54ff50922bdef8b469075a1777', 22.3, 83.524, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '11', null, '2023-07-17 03:23:59', 61.3151638, 22.1444786, 2439.77, '87bbea6a62efd22d0bb9cf758e6969bf0181270f', 31.8, 71.904, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '23', null, '2024-01-31 20:48:33', 12.3198776, 123.6895552, 4597.25, '9c5648f4c5a3baac5c3f4856d16be553f7dd2dfd', 27.89, 210.924, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '19', null, '2023-10-05 00:23:19', 45.1761098, 20.9132879, 3768.81, '2988112596dd7f8124b092a81468572b80b7496c', 21.25, 102.011, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '35', null, '2024-01-12 18:30:17', 42.8271637, 2.9134412, 809.31, '9283d40c308b8bd25e5fbd5b5e13e3444763b2a6', -3.08, 246.653, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '27', null, '2023-08-31 07:04:37', 29.9588757, 30.9006905, 1698.48, 'd6ecf8a798cb11d1388112d024a243fefc8cf37a', -6.17, 198.749, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '5', null, '2023-07-16 05:24:58', 29.3830191, 70.9139437, 1154.96, 'a399fc03293df2d40a6e1d9657bb7b768a7e1e39', 13.05, 142.273, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '42', null, '2023-07-20 22:29:20', 54.8681775, 61.4273838, 4554.71, '7974c5fe1b64de91f82379e64c12d462372fade9', -4.43, 212.299, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '28', null, '2023-08-31 14:52:41', -17.8145819, -63.1560853, 4679.97, '4d6fd5dd9fd7076827d63a10001cc7f42673166e', 26.7, 5.619, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '41', null, '2023-09-25 17:13:05', 49.0936632, 17.3725325, 2766.47, 'c0cf0c16505a623fd6f82ed1969182c77d83a59c', 32.08, 61.018, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '47', null, '2023-08-19 07:36:14', 51.50008, -107.05128, 846.87, '6f822d69016434b7c461393f5cde2678c4e14d1f', 15.19, 9.737, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '2', null, '2023-12-27 12:43:17', 41.1242621, -7.787823, 4243.3, 'b716c80308ec936bd2aacb1467a94cd6c8536e15', 16.6, 195.292, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '45', null, '2024-02-27 05:22:25', -8.4175693, 113.6799766, 1922.69, '1c869a7b2c1e026da50eff1e2dee7dc481e7e78d', 23.06, 17.761, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '30', null, '2024-02-12 06:49:31', 19.5037694, -99.1324282, 1309.02, '2a49bd661be041aca93f7d07dc2f022a72842361', -9.47, 82.964, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '44', null, '2023-10-29 17:09:07', 14.3618606, 100.6685901, 3976.27, 'b12a0690388036e3c546e89cb225cf8669e10a59', 39.41, 46.814, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '50', null, '2024-06-03 17:56:00', 34.799583, 137.3616256, 5467.87, 'c29db15c643838e16a6f2bca36c899e15914eead', 17.99, 61.585, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '13', null, '2024-01-21 16:27:42', 54.3494655, 38.2582586, 5201.94, 'ddf29596ee3a7d62240cc90e69eeee923b675f69', 11.06, 238.308, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '39', null, '2024-05-14 21:59:35', 26.7957017, 86.2970998, 1575.55, '87a01b5251e5fe527fc5b3039d6466316ad753f3', 32.97, 47.625, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '6', null, '2023-10-25 10:07:42', 54.81998, 23.84462, 1702.01, '9b1f7f90ca15b557bd6a6fe9e6603d9bb3f9b9d6', 27.97, 248.419, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '26', null, '2024-01-06 16:59:06', 22.273048, 109.975985, 661.61, 'bf2990579ec170fc6ce4b68761605a1eb9f9b12d', 8.22, 205.446, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '22', null, '2024-01-18 13:27:46', -39.6415998, -72.3370089, 1590.1, '9136dff964637da9c3099b729404276319385d9b', 37.39, 31.008, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '46', null, '2023-07-29 04:47:01', 3.1377116, -76.5929658, 2554.04, '86ab5db26ebf09c137c758da472b4b5a003b4c06', 12.1, 9.573, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '40', null, '2023-07-01 02:58:00', -7.5208, 108.6747, 5538.21, '88540db71c112eb46f69e98beac41e0d740a5aa7', 13.81, 22.423, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '9', null, '2023-08-18 19:16:36', 21.2635582, -78.1507423, 3940.26, '674ec8da61c9b1fd51f7975d526a73533f085919', 9.86, 139.574, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '31', null, '2023-08-22 18:06:21', 15.8107755, -87.4133145, 2219.49, '77006ad2129a485543c4709e828546f97fc7d47c', 26.37, 51.068, 0.3);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '18', null, '2024-01-05 22:39:59', 49.4023766, 20.3031211, 3903.05, 'd2d7048cac2cfd80a9de608eb8721b645a0489c2', 11.64, 158.734, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '16', null, '2024-05-10 19:16:11', -24.4748345, -49.8956943, 1890.77, '400c77df2e97501db912ae5385315dbeedb3ffa0', -6.42, 5.497, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '37', null, '2023-11-24 03:15:58', 56.8530446, 41.3756828, 1755.48, '81ea7dd4efa426a555e542a3d4988fb49ebcc75a', 18.21, 192.952, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '33', null, '2023-11-10 18:31:49', 8.972681, 125.408732, 2795.74, 'db72cd9b8ac52de2c571c3e218de8de1464e2ff8', 9.91, 182.42, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '3', null, '2024-04-19 06:55:51', 39.3458414, -9.1695689, 3211.19, '1d141ee0ea47c451b23a0ed0474508dbe06b03fe', 21.74, 116.533, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '10', null, '2024-06-10 11:37:23', -7.8477615, 111.5021144, 4445.21, 'd7bf3b3fb86e1c247f7d20034bf5a1850f6c5757', 14.04, 113.741, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '8', null, '2023-10-28 11:36:51', 43.8562586, 18.4130763, 4060.53, null, -4.07, 196.168, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '49', null, '2023-11-09 15:43:01', 55.9240189, 38.0011402, 2002.25, '3b6f27740c98ffb12584096fc418d444fbd3d82e', -2.47, 37.986, 0.59);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '38', null, '2023-12-29 18:42:01', 6.7954977, 79.8746207, 2763.7, 'b6691b0491039fc7389d655db1534a1386d0a7d2', 11.6, 47.146, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '45', null, '2024-05-08 12:53:52', 43.7187433, 17.2236492, 5682.8, '4d22d93309814b08f9d582a1b629e4830fa6e653', -4.13, 201.341, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '26', null, '2023-09-24 19:46:01', 30.779444, 120.00922, 3277.18, 'ecd7e6e4fb6b970b55293755a606eb9e1000f2f2', 2.66, 156.447, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '21', null, '2023-12-28 21:12:39', 40.4579077, -7.845845, 4126.18, 'ff22f4ba84b6aafe3a540dd61383e6166c7a6ce4', -0.76, 50.445, 0.15);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '47', null, '2024-02-01 08:49:22', 46.3187542, 38.7465307, 4212.55, '051bed0a0dd86427d570f3d3e22e5cadf2067f4b', -2.99, 211.384, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '30', null, '2023-08-04 00:12:14', 32.109371, 35.239715, 331.74, '543233ba53702b9b2928d3f99e6f1879dd96ec65', -6.08, 93.529, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '14', null, '2024-03-05 09:00:28', 34.265637, 107.62613, 279.55, '43000d587e0b6daf29ba264b31b72362830b453b', 7.41, 134.682, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '48', null, '2023-10-12 00:50:28', -8.5697306, 123.3991028, 3916.04, 'c71cfb463051aa2cbbfe64af70fcb1278602efa2', 17.6, 246.425, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '7', null, '2024-04-05 17:33:49', 53.6936156, 16.7047258, 448.43, 'ad078c2f339c9d97a5abdf746adbd7c3ada2bb78', 24.99, 233.073, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '23', null, '2024-02-06 02:18:42', 41.3752744, 19.5359821, 147.26, 'a83a128aa65c57d3ecb7d42507fee7db47b91fa7', 10.73, 216.048, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '10', null, '2023-08-21 05:10:24', 33.0405874, 73.6083351, 2579.73, '433a77d40c53fa7cc7c01e7a0a5390e814f63813', 19.77, 147.869, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '29', null, '2023-07-01 13:11:51', -7.7533886, 109.8975853, 5524.58, 'c848f5ef27c091a1ff3e498319332c28a1530487', 7.62, 131.079, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '46', null, '2023-12-07 10:35:09', 56.0181995, 29.9291962, 3499.46, 'b5df293fd5deab382705df8103aa75b7729117f7', 30.81, 62.218, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '33', null, '2024-02-10 20:17:01', 34.746611, 113.625328, 5036.89, '6243e845f9166064ad75ba3e60aa41f318f98ab4', 24.74, 204.114, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '34', null, '2024-02-02 19:28:46', 22.2304314, 113.5411611, 4999.85, 'ac0b12b421f4d3c320a5505accf53363b9b730e2', -5.68, 73.787, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '9', null, '2023-12-24 11:05:20', 44.0086458, 22.9355752, 4730.63, '1007450e8dc2c18f9f17d02ef3cb9d3ec11d1682', -2.92, 44.577, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '17', null, '2023-09-27 19:46:57', 42.1309737, 24.9390156, 1477.68, 'e49cce33d5acd1d14c6f168cb616492b9b0c6f68', null, 84.938, 0.46);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '41', null, '2023-07-06 21:20:11', -42.7592642, -65.0612637, 3085.26, 'a95daab5dd05af4cd98b21cad293481ebdcac5e9', 10.21, 108.047, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '8', null, '2024-02-14 22:24:15', 31.1853497, 35.7047733, 118.36, '9c15219b969572b6cf9a73a9138c273818b35c3d', 31.24, 20.759, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '24', null, '2024-01-27 18:48:57', 38.7, 21.466667, 5936.23, '258080314c3c649dce7b297fa89bd1153683131a', 17.42, 132.902, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '12', null, '2023-08-03 22:06:33', 38.9273849, -77.0125445, 3293.98, '2dc0b0f0b7632a4300d226e797d18163d9c35bb7', 18.74, 115.129, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '32', null, '2023-12-25 20:15:39', 49.5733006, 21.0597432, 2129.22, '848410a05ee9312d6f6c77e98bcaee4afd2e9820', 3.12, 166.032, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '27', null, '2023-07-18 06:50:07', 37.9022064, 55.95535, 5679.74, 'd90b5756d647e22f48eb0cc783499965bfb880fa', 37.77, 16.653, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '37', null, '2024-05-24 08:04:47', 25.227212, 100.307174, 1862.43, 'e7f285f5e0dbf901b291ca2538290c3684401910', 3.71, 191.968, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '19', null, '2024-05-08 19:00:44', 14.7596318, 121.0589081, 5290.46, '1ee1c7f7310bbeceef7182e7db470f1238924883', 34.89, 42.258, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '28', null, '2023-09-24 14:06:37', -1.9, 115.3, 3252.26, '565358ff31f0b01e04e098244a8fbacbc63cf653', 27.76, 42.53, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '16', null, '2024-01-07 18:06:16', -12.0582305, -77.1053673, 988.29, '6b91cd4c79b274551f90bda6b2650baedfbcdf5d', 15.15, 79.457, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '11', null, '2023-08-03 19:08:51', 10.3550571, 0.4738293, 364.93, null, 27.69, 14.079, 0.27);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '39', null, '2024-06-14 07:58:56', -6.8497713, 108.64553, 255.22, '1cfe7b560df88b322b08c35c6a42e48d00c0dc10', 39.08, 36.787, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '50', null, '2023-09-20 14:59:26', 36.0444446, 136.5160248, 3055.88, '6b6c30ef366828a0f384a334872353b9dfc81f42', 24.08, 194.879, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '3', null, '2023-07-17 16:41:41', 24.4571847, 90.5486962, 3444.34, '2b9ffa902a7763ac5e14fcb5a15d94bb82c39fdc', 1.21, 0.346, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '36', null, '2023-09-14 19:25:04', 55.5480165, 13.931553, 3082.63, '64a3553fba765e0f83b6717bfd7ffa54f91f1d5e', -6.17, 81.284, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '6', null, '2024-04-16 21:04:42', 14.5925105, 121.0404991, 4376.92, '0fb5a65c7183428771eff49f2442c93ab875a14f', 23.14, 141.539, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '1', null, '2024-03-12 14:45:06', -27.2786239, 28.5155901, 3055.2, 'fabb1952ebdbe86ad30967ede912061ff3c66afc', 0.65, 228.641, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '43', null, '2023-08-15 08:22:18', -4.8654138, -43.3619983, 3298.47, '368586b653d08779af8141eb8a8de01382794d88', 29.93, 53.351, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '40', null, '2023-10-03 11:50:43', -29.7619121, -57.0858428, 4535.3, '355dfa2dad2d05173d449356da19975183ba6731', 21.4, 139.343, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '13', null, '2024-04-12 15:36:57', 49.5704312, 6.0632054, 987.61, 'b96af62407efecb108c19988566e38cd7f333c3c', 13.33, 89.383, 0.46);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '25', null, '2024-03-17 21:41:31', 34.390575, 117.526125, 3108.31, '09ae93d3184b21ffe4912fee36e2a23ef20c0425', 25.65, 96.567, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '42', null, '2024-01-19 12:44:00', -16.328546, -48.953403, 2055.28, 'b47358babee296b91924c4694ae094fcbec6f30f', -4.35, 87.099, 0.39);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '4', null, '2023-07-19 21:14:05', 14.4332941, 121.0303692, 1781.49, '7050e9b3867fa615102e84ba5117d62105432246', -3.47, 22.656, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '44', null, '2024-02-21 15:02:50', -10.1790674, 123.5770012, 4066.28, '2d3bf7dda779abc0e3d176a31b8f4a9dc46a72f1', 27.65, 66.893, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '20', null, '2024-03-21 15:44:23', 48.507933, 32.262317, 79.74, '762f9ad9bc1ab5c60f456245c11baacb19bba35d', 36.27, 172.589, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '49', null, '2023-09-24 05:21:52', 27.44587, 118.679751, 4148.26, 'b3684500861c49db6188e66cdd859e8f5b75377f', 22.53, 91.382, 0.58);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '15', null, '2024-02-14 10:18:04', 10.4309602, -85.0966591, 4180.45, '78a5736734324a405eeaf4d94d22161dc71d6236', 18.52, 205.313, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '35', null, '2023-08-25 13:45:07', -7.5605, 108.2573, 1312.79, 'f81f6d0d139670ccae5f779187162dab53e8924c', 19.55, 23.486, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '18', null, '2024-01-13 14:04:51', 42.1570936, 21.5852425, 1433.91, '372fbff5ce1f885f849f7c0237d297685678ac70', 37.18, 67.412, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '31', null, '2024-05-29 21:36:11', 34.527114, 108.842622, 5019.21, '3db36c08300370ecfc35a6e5628b395e443e5ba3', 13.2, 167.169, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '5', null, '2023-08-31 09:23:27', 8.4584521, 125.0679195, 4392.09, '06997dd8d2cde1ec5b987211b06b2f0047826fef', -8.3, 203.465, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '2', null, '2024-04-21 21:05:21', 39.7654612, -8.6206402, 3965.8, '28bc67df001f53b3f376a4b50e9bdde7693fc776', -1.04, 230.717, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '22', null, '2023-08-23 19:36:32', -9.3809238, 119.3984531, 3676.08, '0bb0405520da4ee91fc78504335ff3b87a9d79f9', -10.0, 172.988, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '26', null, '2024-06-06 10:50:19', 45.2969275, 14.2723701, 5490.03, '89182a7d3ba67b75be0bc5c2b56df742db89186f', 5.26, 220.563, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '29', null, '2024-02-16 07:34:07', 33.06777, 107.031856, 2968.05, '67a4563de4ca6260056c35c101656a1b8c02582d', -5.43, 68.346, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '33', null, '2023-09-16 06:55:04', 28.0154753, 120.6626572, 4307.93, 'd22eea4367fef43a53cfa0b8fdc86872bf589a19', 16.54, 78.101, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '25', null, '2024-01-03 13:02:41', -30.5652911, 17.9904127, 4704.5, '528c4cf5ffcb55d337b731767c411f18e474006e', 38.84, 29.335, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '50', null, '2024-02-02 00:39:31', 7.5958893, 126.4361995, 4338.78, '0a2ccd5731824105e318bb23e4035c1f8f47726d', 22.89, 155.352, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '44', null, '2023-12-10 22:40:36', 27.867118, 116.18757, 1409.1, '0858fc6fb946f0822ec44ac2e39223a4a525f531', 17.34, 53.542, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '48', null, '2024-05-08 06:45:57', 59.9739683, 10.9282159, 4988.64, 'c43974143f102790f88abd7012e61ebba6a32236', 17.46, 195.8, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '2', null, '2024-01-11 06:48:00', 58.0618351, 7.584995, 1147.91, 'e76c7294d559090433e3a8174234deb8b79b01ce', 25.15, 190.993, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '19', null, '2024-01-09 18:13:41', 40.42, -104.7099999, 1952.98, '5f0b9ae0f71057b434ba108b83b30ea28ec840e5', 29.71, 51.041, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '35', null, '2024-06-05 11:08:15', 39.2783775, 140.4636669, 1142.55, '57dd3b312eed20d807c798889e8176e4c792d549', 0.74, 200.733, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '21', null, '2023-10-06 13:34:49', 40.995233, 122.064832, 2570.05, '26b1c2932169907ce6c872e40743fabfb5a77422', 5.46, 222.098, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '16', null, '2023-07-19 23:42:56', 40.7200264, -7.2571497, 930.84, 'fd555c09870611181a46f07fa6045297b1cc773e', -3.49, 225.672, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '22', null, '2023-08-30 06:28:07', -6.1701003, 106.0522616, 5594.52, 'b3c247b278b75c871e243f7277aff3eee19bd164', 25.55, 72.631, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '31', null, '2024-01-24 14:36:10', 14.6419036, 121.0120679, 4635.21, '604715939237922308ce65eb0c468c718eafaa0c', -1.98, 47.02, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '14', null, '2024-01-20 16:26:32', 28.851022, 85.297513, 143.72, '881ee5f95d3e2cf393328342d97e69846e9e937a', 14.66, 110.277, 0.93);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '23', null, '2023-11-16 03:34:24', 9.8566537, 123.1426191, 5664.77, '2cb68937d8d47ee74967afca3798facd46a3040b', -1.75, 198.988, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '18', null, '2023-09-21 15:16:10', 0.490107, 35.743418, 3743.86, '3a2a57968c4cc510fe427d36d6d45805b75ae263', 2.26, 250.685, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '6', null, '2024-06-04 18:10:42', 44.7416079, 18.2727658, 5437.58, '75271731022b70c428f0c13cd578cfa37cfcbe01', 31.47, 162.7, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '1', null, '2024-01-09 18:54:31', 34.513586, 108.317445, 3554.09, 'a517674344ff1eb3cf2c52b1a9df7d1fe7fe74a4', 27.63, 58.394, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '32', null, '2024-03-13 14:43:51', -8.0026625, 111.4559084, 2977.61, 'f655f582dae8f0bf1fc9f4eb76387747b2e2a235', 35.78, 166.147, 0.71);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '49', null, '2024-01-28 17:33:27', 58.6247472, 59.8241142, 3623.51, '5d50a77c38670a690dd939779fb98a50fc88698a', 31.83, 114.942, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '39', null, '2024-03-01 00:44:44', 64.012788, 11.487163, 703.87, '474367bb644509cb2598a9bda38e05136ebaa685', 21.23, 165.583, 0.18);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '37', null, '2023-06-24 18:03:34', 38.8807023, -77.1086041, 5892.17, '9c9d9d7843276c8b9740a3903f88fe75db247265', -9.58, 229.137, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '30', null, '2023-06-25 06:43:12', 31.535184, 116.513899, 3532.57, 'd05c3598908bc523ce1cd019597ff97f594b6f93', 5.47, 45.072, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '45', null, '2024-04-25 22:59:10', 13.7341, 123.269, 5903.56, 'ed1657417f14caafce08c320167ef777eb4bfe72', 8.33, 121.957, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '4', null, '2023-07-02 17:38:58', -7.305958, 112.8135304, 2769.23, '12547321d893cba6b64a351fcae97d37f291c0aa', 35.86, 71.005, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '17', null, '2023-09-13 08:40:56', 45.9735653, 134.1872425, 3372.64, 'dcf03a1130b61c1af6f74d870bfd83dbf1b3d4eb', -1.38, 132.204, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '40', null, '2023-08-05 18:08:01', 0.573336, -79.643631, 2305.7, 'ae148a9c01597b6f6503d8a8a695c101ef59a937', -3.41, null, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '7', null, '2024-01-19 19:11:40', 18.2726824, -70.2297697, 4249.32, '846ab504976b129991453734098820cd4f562dca', 22.45, 14.147, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '13', null, '2024-01-15 19:12:50', 5.4459387, 10.0471549, 738.45, null, 17.91, 82.449, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '42', null, '2024-05-06 18:37:47', 53.1517598, 49.8698614, 1059.34, '6c2506d19bde04328a048e587c0155f2b601d420', 34.87, 224.318, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '10', null, '2023-12-08 03:30:07', -6.1179866, 106.5760857, 2777.83, '18c0147c04701b28dd1643fa2923a931cf8f5ca6', 32.99, 158.834, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '9', null, '2023-12-21 23:31:51', 56.3035039, 36.4948768, 4400.89, '7fbf3e661c0edb7c1e1b2beb456be3fda1a3268c', 33.37, 170.953, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '8', null, '2024-05-05 17:37:43', -34.5458354, -58.562848, 820.79, '43e452f7a0d18dad9b18a90f63bb378296e516ad', 34.44, 236.442, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '36', null, '2023-11-26 21:16:52', 47.3752386, -0.8453268, 5313.54, '768189e6f337e72033004fc5fb47f21296aad8ec', -6.34, 211.184, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '12', null, '2023-07-25 08:30:49', 33.46444, 126.31833, 2423.49, 'd570fa0354a5375a83e87bb10d314603a3dafcb4', 10.22, 254.992, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '46', null, '2024-03-25 03:17:34', 49.837947, 20.1528189, 1321.2, '270b9a217f4ba83ece76bd86bb80a269eeacfdf2', 5.11, 226.015, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '15', null, '2023-09-29 22:34:34', -27.6146187, -48.5162223, 1570.4, '095f3be8e95e789fbebaeeef893500974c4067d7', 38.27, 82.151, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '34', null, '2023-10-23 21:39:36', 10.1684514, -61.4377107, 141.36, '58f2e570b3bfa3ab92690b857bccd0e649cdc543', 9.22, 247.19, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '41', null, '2023-11-03 10:19:04', -15.3745452, 167.8138553, 3100.73, '01430f8500bb41e8cd37f713206aa794bb761b64', 35.19, 239.749, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '3', null, '2023-09-28 21:59:52', 56.6182449, 25.725792, 1345.85, '669a0fa2331f4e98947486beb89087c40e771109', 16.84, 178.203, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '28', null, '2023-10-12 01:50:04', 39.7546452, -8.5234076, 2724.0, '52064ff818221294c7c96ec0d33fe71e3d5281a2', -3.53, 31.395, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '27', null, '2024-06-13 19:35:51', 22.765392, 112.964446, 2405.5, '0919e56fa2f9f4cb8c6251047270c510f8f5f2d9', 0.62, 196.777, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '43', null, '2023-08-05 04:41:04', 37.7881713, 20.874871, 5228.14, '4117a3b7d2883995cf94f279a82d324cea9e9690', 15.34, 103.35, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '5', null, '2023-11-04 19:12:27', 18.9670072, -96.7313362, 2429.72, '86a69490db2fa912e6b957ef872c35548414daf3', 1.52, 145.152, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '38', null, '2024-02-11 19:50:40', 13.3888199, 102.1175404, 4964.65, '5627a6dcb75388d8a6046dd8d871221b5d2cb983', 26.43, 219.882, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '47', null, '2024-03-06 13:18:11', 59.3595369, 17.9873583, 691.72, '7e47edbbdb1f065e6fa20734148516c0ee2e8971', -1.94, 113.905, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '11', null, '2024-04-11 01:41:30', 45.8585463, 39.6551933, 5266.71, null, 5.61, 94.159, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '20', null, '2024-01-15 01:22:25', -6.968354, 112.475502, 914.02, '00849895fb280b297b7e6baec4ec1e7a6bce8ccc', 14.71, 212.355, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '24', null, '2023-10-19 13:10:03', 40.2608574, 23.2215193, 4149.0, 'd4b462822fe4d106b37b928c0decbfa83b522144', 11.72, 242.266, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '23', null, '2023-06-30 07:48:45', 8.417766, 126.207415, 912.39, '7d372ae1a86f5949df2fd7ea377217136cb159a7', 13.45, 229.859, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '41', null, '2024-03-20 10:01:17', 38.416663, 112.734174, 2242.55, null, -3.32, 20.567, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '14', null, '2023-06-23 08:57:31', 51.8253953, 20.8092134, 2590.74, 'a165aa586c5b088e5f745e03f32cf2a39023db8c', 36.84, 120.117, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '48', null, '2024-02-17 20:26:55', 44.3264928, 38.7015857, 23.58, '359a71f552e0fea2cbc44e1650bcb74a2002b9f9', 29.14, 16.725, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '40', null, '2023-08-04 20:08:41', 40.1014047, 44.3906123, 2102.95, '5a1d2e4f2c062bbfa2752d9f9f4301b4b3a7c56a', 21.47, 164.073, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '3', null, '2024-01-05 02:28:49', 52.3429156, 16.8799555, 3957.31, '6cdfca81aaa3b4c1c4bd9503174947608568b8e8', -4.64, 171.617, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '46', null, '2024-05-04 12:53:28', 54.1407588, 43.1704696, 1105.1, '7c480f88dd61ccd465f1be96411bca7d63e53a32', 16.06, 9.02, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '22', null, '2023-08-24 05:20:39', 5.1550917, 8.0247005, 4871.92, 'b13203dbeb0db7ce0344ef236b7254582fb2dde2', 0.25, 170.321, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '7', null, '2024-03-23 13:10:40', 16.3496709, -98.0587939, 4596.16, '665b950736921035a4dc3a8b29063091834ea95d', 16.19, 84.833, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '43', null, '2023-09-16 04:24:58', 51.9817834, 17.0627666, 2487.46, '0f9b61944829a14c54d3bd6a70d96203f569f23d', 20.98, 39.702, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '29', null, '2023-11-15 01:00:45', 26.489902, 113.772655, 545.66, 'd590a2af8ff68a77e30e3c2851179c3c798b3967', 31.52, 97.988, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '37', null, '2023-11-18 23:50:59', 30.9781287, 31.162448, 3013.14, 'e081afff9f352459e20957d7a6e488516d1bbb81', 6.7, 148.267, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '28', null, '2024-03-29 18:00:17', 37.9943201, 23.3430496, 3954.17, '9e1860dec0dc77bf52acf4b85744f3151810dac8', 25.26, 0.012, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '47', null, '2023-07-22 09:23:44', 14.5508865, 121.0075554, 5152.25, 'be35c8b8d910387691600635b1a662dcb3eef994', 32.47, 132.009, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '33', null, '2023-06-29 08:10:32', -5.7, -75.983333, 535.69, 'b1ff93961bc75cd95749f3cf2bc74e0210598b43', 9.0, 103.864, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '19', null, '2024-04-15 05:40:16', 6.39694, 124.7225, 2341.79, '10588cb35e01c2ae8cdebfa970ee27e5e9e7c331', 5.85, 159.614, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '26', null, '2023-08-31 01:45:46', 38.4305306, -8.635246, 120.52, '82580b42833dd58b293719c13161d91d19252ced', 35.33, 128.107, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '16', null, '2023-12-15 15:01:10', -6.1840029, 106.8466001, 1756.61, 'bdbe0c7fac66a6190abd39648d92705c64eeee6d', 17.67, 103.18, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '21', null, '2024-04-21 07:07:34', -8.7389984, 116.4577466, 1131.48, '9957a6bd3513b5e693ac03dc8ea9a4e9af8fc7fd', null, 244.219, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '27', null, '2023-12-16 23:03:10', 33.06777, 107.031856, 49.79, '637ff365a98335d8f80d83ff5853ea0c5f8c7a39', 20.52, 74.556, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '17', null, '2023-10-16 16:06:30', 24.326292, 109.428608, 3665.75, 'ac4dbb068366ed95ae5f4f0ae959bd16169573df', 12.55, 246.775, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '4', null, '2024-04-09 07:45:20', 32.1942601, 35.3736237, 4592.98, '26cb610fd1749fe57ba65fb7733f02cf69b10a6e', -6.96, 46.415, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '38', null, '2023-11-14 01:58:59', 38.7015108, -9.2848171, 2971.8, '87d7c211d75ffb1ebcb280fb8a991a636ef183b2', 16.17, 251.011, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '36', null, '2023-06-19 07:41:23', 53.6944002, 17.5569252, 1771.52, 'c4353afeae848d46f8604864dd6d3664bb97383c', 12.23, 30.225, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '45', null, '2023-06-18 17:29:50', 25.332842, 118.732669, 1534.43, 'a82f29286502ace953064f3442073c79230a295f', 27.45, 22.377, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '49', null, '2024-02-01 18:19:43', -9.9544, 124.1255, 4892.3, '755e378c3b9eb99f342966709498c1d9353ea23d', 26.13, 144.47, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '34', null, '2024-06-13 06:22:43', 38.8055168, -104.4956239, 1785.06, 'b5e7f11ac605e041a7c54812377a3377ed0b8d24', 10.0, 149.477, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '30', null, '2023-08-25 08:38:06', 27.845011, 117.383641, 228.44, '4099344692bddb5c2ed3bd8419d3aa08f6ea419c', 7.46, 138.601, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '31', null, '2023-10-03 10:30:03', 24.89604, 118.592147, 2420.0, '72c41ccd2e67d4a419b82216587c3555aafeb26d', 20.71, 123.014, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '18', null, '2023-12-21 09:15:43', 41.0918152, 19.5315193, 5372.54, 'c64a87424c194413656ba59c192e99fa13248475', 14.89, 206.101, 0.3);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '44', null, '2024-04-12 17:50:17', 45.3401583, 104.0061889, 647.12, '83141476eb39bc4f405c9fa422340c119818cb15', 18.85, 208.504, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '25', null, '2023-10-30 23:24:18', 31.3219, 121.01853, 2733.97, '8737f6cde08f664a1738d40d17d945256538876b', 24.94, 216.787, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '2', null, '2023-11-02 02:54:41', 33.811128, 36.1572559, 1033.21, '95baa62e3651ad54ac630538458774e9513160dc', 27.94, 24.142, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '11', null, '2024-06-12 18:28:13', -9.0709033, 124.7188222, 791.53, 'bba42b4050cd2b97a26c8c8337eaf010b06c3842', 14.32, 79.266, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '8', null, '2023-07-07 00:55:10', 14.5679608, 121.0233632, 2223.41, '0106c898ee3f31346d16512f7a2aebff016f7282', -9.63, 181.601, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '35', null, '2023-08-20 20:53:51', 48.529165, -2.7586364, 1621.02, 'bd168cf9e9c30d2e6ea2245fb6f9b6b7569aa56e', 4.39, 166.208, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '15', null, '2023-11-14 20:13:45', 7.1473706, 125.4889603, 2396.49, 'a3e21385b6450b258732fb74cef4ef37cf48921a', 20.2, 147.899, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '1', null, '2023-11-13 06:13:41', 20.3474809, -74.5023819, 4753.08, '6bd51f7c5bb8408d128342db9eb041d31645a5e7', 0.94, 28.176, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '42', null, '2023-11-03 23:50:46', 36.650038, 101.766228, 3888.23, 'f1c1660d6a792bad89c541e981a09dedbf539b1a', 6.0, 100.755, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '13', null, '2024-03-14 13:21:42', -10.9, 39.33333, 2151.83, 'ca7257f82fc5062b78666ed610b626c41e6a123f', -8.43, 152.352, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '9', null, '2024-05-09 01:37:30', 39.305219, -8.6288405, 2273.67, 'fb3dda95b40ba0cd34bcbdf59dfca9be9b86de6f', 8.24, 98.437, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '10', null, '2024-06-12 13:05:41', 8.8469761, 7.0605998, 3304.31, 'cb1fb46f0b4b36718a2dbfda603cfbf2c398bb2d', 37.67, 23.338, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '24', null, '2024-03-12 14:46:25', 53.4167481, 83.5264334, 5396.01, '684ba803c48ef184850e3d787048926a416c8a17', 29.26, 67.944, 0.37);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '39', null, '2024-05-08 09:56:23', -6.9783786, 111.5080765, 5304.0, 'd4529cca669e5cbc83db3b832fa2a691a7eedd19', 10.31, 229.851, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '5', null, '2023-09-04 07:03:48', 40.7576842, 23.1342184, 5471.19, '9acafa5d2d75431ed2a11f5c4deec42ca8b85aaa', 39.38, 164.693, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '20', null, '2023-06-29 15:22:46', 22.529403, 103.93935, 4734.25, 'b274fc26be5945896f221fa37f24d430dcdfebb2', -9.61, 42.921, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '50', null, '2023-11-15 23:42:56', -22.9304477, -47.0897445, 1084.99, '7c779e9d9afb3de63aa93227dfd9d304659469cd', -0.8, 147.53, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '6', null, '2023-12-21 17:44:46', 37.4202216, 66.0195894, 3095.92, 'd2f5706e8b7cc3f2aa92b1c3556525670351828e', -3.94, 178.882, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '12', null, '2023-06-19 02:26:59', 37.4498962, 24.9353935, 2963.93, 'f260d487482331c6cc5b4c01435c2b40d984c7ee', 14.23, 135.974, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '32', null, '2023-07-07 19:10:17', 35.3350072, 129.0371689, 5712.45, '709e2712bdf5e28d9ab3ab2fa046c30c6c3f4c03', 4.97, 121.911, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '29', null, '2023-10-29 05:33:42', 59.4050955, 17.9551008, 2191.42, '71db3766416738bb754ac825746b0d8ed71bc4b6', -2.58, 169.154, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '37', null, '2024-03-01 04:52:43', 28.80901, 120.26121, 1517.88, '42f6db42dd932c56f8bccebaa7b59e26d4fc4e9b', 5.97, 245.052, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '43', null, '2024-05-06 09:18:47', 17.1056791, 120.4557309, 5699.15, 'aa4dcb0d8d707aa707d7c3bbe7d10a5254208c35', 1.69, 96.926, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '26', null, '2023-08-12 23:33:24', 14.5586303, 121.047062, 1593.46, '45f4349608ca4b5f61bc1770e1f5046bda087b63', 10.12, 49.458, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '48', null, '2023-07-16 08:01:47', 34.976557, 112.090859, 1606.15, '85762fa94c8148e83b15494480f516110c6b6c7b', 28.2, 47.662, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '42', null, '2024-04-27 16:53:04', -8.6595, 120.7129, 5342.88, '8be00e8c0319b0be3a18fe0588c55d425c37cf6d', -5.27, 14.278, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '44', null, '2023-11-01 01:29:54', 15.0983576, -90.3903337, 1439.52, '25dee7f39cc87a5f07a2080bf9793da4372e747c', 11.78, 128.219, 0.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '20', null, '2024-06-06 23:19:52', 22.719257, 114.055261, 3105.99, '68b62b3af56373c062cbf31f520c7f654c6970bf', 15.9, 64.232, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '10', null, '2024-02-17 15:53:51', 30.2638032, 102.8054753, 4093.37, '7003f7f2e66e49eadcf69410c46a090711fa6d16', 4.58, 91.904, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '27', null, '2024-03-20 11:00:47', 7.1302807, -3.2030756, 894.39, 'a335431172aa636c15aef3f4f5169e16affb5c58', -9.9, 177.08, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '19', null, '2023-08-06 13:34:03', 14.661167, 107.83885, 4283.23, 'd6d7e69b397ebc23fade12a95c90805187c481ae', 7.34, 178.684, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '45', null, '2023-10-28 15:35:08', 43.7281385, 7.417857, 1879.26, '2f6bd66a05ed1515cb97aa18dff3ba46bfd63d6d', 38.51, 211.514, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '11', null, '2024-02-28 02:47:13', 18.504589, 108.79313, 5850.92, 'c910fab897a954897a7e9c220080c96303266041', 33.86, 70.626, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '12', null, '2024-03-12 17:30:02', 48.7393933, 2.7594768, 1075.83, '4615ddee7338c518baad29e7c510a3f454045599', 24.07, 172.805, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '8', null, '2023-11-09 01:30:01', 58.5493379, 16.3578112, 42.55, '67d0d49a7c7b3efb71eb64fe764cd875eac15da5', 37.63, 201.944, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '7', null, '2023-12-07 09:34:53', 53.0418691, 16.4616756, 2861.56, '39b81874914cb2e71596de966c75c1a772c57a4c', 10.6, 100.313, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '2', null, '2023-08-09 13:53:47', 14.8753647, -88.0729754, 2930.69, '6cecaa590a94be29deb28448c3ba8609423af75d', 31.66, 55.792, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '32', null, '2024-05-18 09:39:37', 8.538323, 37.973162, 5488.65, 'e368741e56376059890f77a3371d737609851445', 35.18, 67.107, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '34', null, '2023-10-08 01:59:13', 56.339549, 114.987561, 4907.66, '81980e560164f3623370a8da171d35b23411252a', 30.11, 65.74, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '33', null, '2024-01-01 12:47:34', -6.4306844, 106.7175669, 380.5, null, -4.32, 179.749, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '39', null, '2023-10-28 21:06:36', -7.2376196, 35.717481, 5834.81, 'bc14f87dd58b10fb1963d06dbf0d2094b498074e', 33.26, 247.167, 0.11);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '22', null, '2023-10-20 13:34:05', -25.4809333, -64.9751483, 3666.11, 'ab57cc52bbb7fddae246276945a5a9cef71f13a4', 3.54, 95.392, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '24', null, '2024-02-29 19:52:50', -6.2746751, -79.6080967, 4314.66, 'caf00b093a2193adcad73f12152aea96ce61ab2c', 26.45, 45.595, 1.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '16', null, '2024-06-04 19:13:31', 40.667433, 122.235084, 4948.15, 'f44b735ef888de8b11c5f2a39df391ecf0a16a22', 29.27, 148.076, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '4', null, '2023-12-20 02:19:11', 0.4990124, 29.4527538, 2033.53, '506c7f5020e974261c993a5e994c3ce42268f3ac', 23.08, 232.09, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '3', null, '2023-12-29 00:42:14', 31.017497, 121.309354, 2089.03, 'd0fe9651f2e15dedd08ac55a90739e3bcd1555d3', -4.53, 92.064, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '50', null, '2023-11-29 23:09:49', -22.0227557, -63.6775234, 1799.38, '1c60a67d6e350b6b994da2462347904e8c711da6', 34.25, 96.874, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '40', null, '2024-04-23 04:27:52', 31.2171769, 121.5316367, 3362.32, 'e2a3658df28dca60d2cee3654d16fe23d08748d4', 29.62, 168.378, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '23', null, '2023-08-25 05:41:41', 30.912302, 95.604143, 2315.54, 'f1eda318ca96a06c03e5f1b9c64cdc2f17f96f3a', 4.77, 184.289, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '38', null, '2023-08-08 18:21:37', -0.4797043, 100.5746224, 4544.74, 'c9f5b8fa3a0eb1fee64f0aa396b5d2f46889875d', -0.33, 128.368, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '6', null, '2023-09-22 20:55:39', 34.339552, 58.7030326, 1462.5, '9817e29a84468a029a8833655500641c992efb97', 26.75, 147.264, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '15', null, '2023-11-28 13:09:24', 50.7249071, 30.9358078, 1660.1, '6b38b35f481bac3418cb77339d25c675fa13b545', -6.28, 211.784, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '36', null, '2024-03-20 01:56:35', -20.8420055, -40.7357215, 5865.25, '90919a2ea9460a38649ccd45282e0bd1b3579df5', 17.7, 31.246, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '14', null, '2023-09-07 21:30:17', -38.9351182, -68.2320043, 954.84, '1facdaeb9da265b9300005fff5f93ab1b7f5b9bb', -2.38, 103.58, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '35', null, '2023-07-13 15:12:20', 7.5164282, -78.1607186, 5246.13, '1c4b39188062714e6adadbc2bdf2595d335d8665', 30.46, 200.78, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '28', null, '2023-11-22 22:05:09', 53.8044834, 21.7303948, 5709.47, '580a5e0bc8a0481e590e05eed14c81efb9697096', 13.2, 229.315, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '1', null, '2024-05-28 08:54:32', 25.700731, 107.631177, 2324.18, 'c0cad27e7d85fc0606a3bc00ed474e692d17f770', 25.08, 17.518, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '9', null, '2024-02-20 22:00:36', 43.9375282, 15.162899, 4621.57, 'b44c7edee12737c67e6283af763cbedbc58434b0', 18.47, 249.181, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '41', null, '2024-02-04 01:40:31', 16.4498, 107.5623501, 4246.8, '7742ff63e5a073f08f9cf3ecf50edca3633395d5', 39.75, 43.597, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '13', null, '2023-11-23 18:42:31', 33.3363836, -111.9343636, 1772.06, '59b21343f63efed645a02f1060c8cf43aab97513', 27.4, 6.994, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '47', null, '2023-11-04 10:43:29', 27.661918, 120.565793, 5047.98, 'bd70387fb6270a9fe7b8a87aa696092ce031c10d', 39.9, 6.821, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '18', null, '2023-06-26 14:39:32', 18.4701829, -69.9844492, 5336.39, '8571e89812c9fcca84d1c3b5a084018a95afe26c', 3.23, 114.953, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '21', null, '2023-10-16 10:50:33', -16.5039502, -68.219452, 188.71, '326c34aaa32b31b0ce5a27ea561cd4f16f9773d1', 32.57, 42.972, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '49', null, '2023-09-24 23:35:12', 49.9742883, 23.5488713, 3809.23, '8de706284f256183560e5feba5be1092e7e002c3', -9.62, null, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '46', null, '2024-05-10 18:22:17', -21.0800303, -44.2039901, 1.29, 'ae98624a0b294fca11218c2772608fb9515b720b', 18.68, 25.251, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '30', null, '2024-04-17 09:10:11', -51.6211286, -69.2142863, 5603.43, 'fb9d6740183c66e8549e25a0105d8a7b686f004c', -6.9, 122.58, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '25', null, '2023-08-17 21:26:04', 33.6883392, 130.7171244, 1741.53, '3518fcf09e2cd52f697c589eba6d65ddf95ee933', 37.27, 31.332, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '31', null, '2023-07-19 10:21:53', -7.1143481, -78.8226909, 2468.91, '9462efb1a5335287971c709d16da87e8054d0217', 35.58, 112.8, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '5', null, '2024-03-20 07:53:39', -15.23723, -68.965462, 1011.54, '276513dcfd356f8ed1f38be3a6dc0983b7ec4118', 19.74, 104.3, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '17', null, '2023-09-16 12:56:01', 22.8037709, -80.0702555, 426.51, '479d830ea3b08716d12d237bdbb566b9ab098bd3', 10.56, 167.638, 0.93);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '5', null, '2023-08-22 19:04:51', -7.5009787, 108.7987084, 4045.64, '1e422753aa30800e0f41db0dcd2fcaaba43c312b', 34.21, 36.022, 0.46);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '33', null, '2023-08-13 12:16:14', 46.3989378, 15.8176288, 2432.0, '70956af2429c3bc8d9f47ee71d95faffd24f05e6', 32.14, 7.145, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '24', null, '2024-04-22 00:52:36', 59.7620958, 18.7017911, 92.06, 'f0d7ebcf7fadbe9cacbd83a460090bf524cec3f2', 33.19, 6.461, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '27', null, '2024-03-03 20:33:42', -21.953253, -48.0006076, 1306.17, '98f0ddb53c46ffff490c0d3653adfa442e596e78', -0.39, 25.378, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '10', null, '2023-06-17 18:24:35', 5.41139, -76.416372, 116.69, '6b49e45482e8f1b9c2caa4882d60039c9ad80131', 11.66, 225.144, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '22', null, '2023-06-20 00:20:48', 13.0958903, 8.0028892, 805.35, 'c927ac5dc1faac924b275cbfbb1734e83dea936d', 39.26, 241.842, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '1', null, '2024-02-23 01:48:51', -17.0656965, -39.734338, 5321.12, 'c0f5af6ef3de6ae60734666df04d8020f82d44b5', -8.98, 63.002, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '15', null, '2023-07-15 16:53:27', 37.856971, 113.580519, 1380.39, '20fe49c598e0ed0af403cd004af437c9646bf769', null, 226.055, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '11', null, '2023-11-23 14:45:28', 26.497765, 101.738528, 4676.66, '4793885eea838642b9c0e97c9d916719656222cc', 30.72, 186.1, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '3', null, '2024-03-13 19:27:33', 43.0429124, 1.9038837, 1922.18, 'adce6464158b21c00d4a7db9e767301cf5aae37e', 17.55, 149.207, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '19', null, '2024-06-02 00:45:51', 14.783886, -88.7782541, 1913.88, '4a0fbbe1183c20f8c49cebbaa570dbcee55dd163', 35.43, 180.496, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '8', null, '2024-01-05 23:36:04', 32.903037, 101.730195, 5569.42, '8b8efec8b4bbdc9c33718ae69d34c6d719de387b', 25.62, 123.72, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '31', null, '2023-11-20 14:56:31', 1.12808, 104.0301606, 5259.37, '66e56a0bf1cbb6a10217c6dc8d433605e871fd05', 4.51, 215.797, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '9', null, '2024-02-25 01:17:29', 40.1675841, -8.4639317, 3156.17, '14fd9fb5c8818c6f1c0dcfb2539cdbea24db91f3', 15.58, 238.897, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '32', null, '2024-02-18 03:05:32', 4.3139754, 22.5498389, 1661.06, '64790ba4adc46bf15b877b35fe1ab0bcafe531a2', 31.67, 1.603, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '12', null, '2024-04-17 08:34:58', 34.481455, 108.386208, 5890.77, 'a99ead7d646ed97e3f4da4ff9d029175aaa8b3b6', -8.75, 243.662, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '46', null, '2023-06-15 01:48:24', 49.9672504, 5.8900588, 1714.41, '89275c110d5b9d8faac0375d2c2b91cc88a4c8c3', -7.49, 225.673, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '42', null, '2024-04-21 18:33:47', 50.3055387, 18.7871344, 183.03, 'bf5b24f549805415d0c212827dc7d1f1c1e3e147', 15.22, 112.867, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '35', null, '2024-03-16 17:21:58', 59.9981042, 15.819769, 2079.55, '84e1dc1f2c2d975d42f347995e45c5cd9707fc2f', -0.53, 180.141, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '23', null, '2023-12-02 12:50:03', 10.274447, 125.257432, 210.84, 'e98a9a32eb5b77b912e7d8124da8b4b979ee2550', 21.43, 215.088, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '13', null, '2024-01-09 19:20:35', -6.4334, 105.9098, 4401.3, '1df06140d418fbaac18a09a231a2b594fb85064b', -3.71, 15.905, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '44', null, '2023-10-03 02:44:14', -11.1816506, -40.5120603, 3258.69, '742e797103b65a71e4d0637e91d01548642bc2a9', 4.75, 222.655, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '38', null, '2023-09-28 20:49:40', 34.4198488, 70.4729434, 71.36, 'ff5252a7fed84ab54c188861dc31701667158014', 39.18, 100.777, 0.11);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '2', null, '2023-07-14 00:51:00', 24.1092009, 117.1199596, 540.87, 'c7685dbc10f5d1bee7ae100ca60bc10555dece84', -8.33, 151.905, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '29', null, '2023-08-15 18:20:26', 22.4423218, 114.1655064, 5888.5, '663e7b1062ba76f57139d51a0b7e2d57b8a96711', 29.79, 216.981, 0.39);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '26', null, '2023-10-22 16:35:24', 59.5194054, 15.9767049, 500.92, '53e7b1cc3cfb52771585f30daeedfa86f1fe4409', 2.92, 151.965, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '50', null, '2024-05-06 22:07:39', 49.8635922, 18.0933139, 5856.48, 'ae5c10a8b577a890a0efec709b76603678cba442', -9.14, 96.344, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '48', null, '2024-02-13 14:41:44', 15.3252049, 120.6560014, 952.57, '026084e3dc6252d4e35820fa8367c1c8d4f1aeaf', 9.45, 93.148, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '37', null, '2023-10-21 06:49:15', 7.0649018, 125.7230302, 220.79, '8acb1130d79a1d664e6a550c653f4ff2dcfb730b', -5.32, 166.479, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '40', null, '2023-11-12 12:03:20', 10.7613138, 123.3719862, 1848.05, '6afdcc880ede2825ec4e075856fa656cfa5a3c45', 0.34, 58.622, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '16', null, '2024-01-27 09:15:18', 36.3384589, 25.4333251, 1022.19, '355fbb4d41c8a7c36c5b0207c32835c9d1cc81a4', 26.36, 197.254, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '45', null, '2024-03-12 22:05:51', 33.0085361, 35.0980514, 1242.12, '2c7d7dbd49d214a117d97e191381fa51988b212e', 10.24, 246.708, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '28', null, '2023-09-28 02:09:39', 53.2945961, -0.9335791, 4074.17, '542292770e7087e4098292970aa0f54689864526', -1.28, 115.371, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '41', null, '2023-08-28 10:13:59', 58.4306551, 14.169785, 3782.71, null, 34.37, 200.414, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '43', null, '2024-03-29 14:34:52', 54.026345, -7.297914, 3104.39, 'ea167b0e8288be52370d025d35bbfca23c131c40', -2.38, 101.819, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '6', null, '2024-04-20 06:23:00', -22.601206, -45.168166, 4899.72, 'e3b8f4938d56290cbaae4442230583b031ff58ca', 5.48, 19.89, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '39', null, '2024-02-11 08:29:32', 28.074649, 119.141473, 3407.88, '31b122cbb15995355c8620c2188bb1c27244ea07', 26.15, 123.272, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '36', null, '2024-04-26 01:19:12', 13.4935504, 39.465738, 3891.87, 'a57e830def634acade353422a1b1fdb660f0aa06', 38.72, 63.377, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '49', null, '2023-08-16 00:36:37', 29.339476, 105.287612, 4062.17, '0b948350301a8f8316ed584c200d1587872e9aab', 36.22, 103.395, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '18', null, '2024-04-15 09:13:24', 28.188415, 112.290474, 5915.33, 'e6d913fdc7d23b75d70011f40323fabefe21e181', -9.46, 79.048, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '4', null, '2023-10-10 17:53:10', -7.6275173, 108.8016788, 5245.24, '53f9daabcb73918345159f8364110d55c2dd12f3', 29.76, 48.489, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '25', null, '2023-09-16 16:42:16', 36.195409, 113.116404, 329.33, '570c739c045a8d1ed095dd9404275e41fced25e7', 19.19, 12.109, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '34', null, '2023-08-17 22:31:50', 31.031384, 118.712281, 998.02, '97c490bfdd9b6f43788d2974c1785efe2368a231', 7.93, 103.169, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '47', null, '2024-03-08 16:04:42', 5.8330136, -72.9342451, 1894.8, '5c0f4e60b0bb60cb467d8530f70153307f9e5233', 26.9, 187.338, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '20', null, '2023-08-07 04:41:40', 53.2737147, -9.0288689, 1778.73, 'bba9e034ee3030450235fa72caec08753c27f52a', 37.27, 176.879, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '21', null, '2024-02-01 23:16:59', 29.1416432, 119.7889248, 4547.76, 'cf4d3ed21c89da5456ec58d99a0345d9e8ad9bef', 22.62, 139.212, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '17', null, '2023-10-15 11:15:59', 29.012339, 105.851885, 1612.67, 'a4f69dc3828f318a78f81171019473ff9ea754ac', 8.64, 104.85, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '30', null, '2024-02-05 07:46:33', 15.3749929, -4.2615383, 3508.39, '441ebfc9a0a969b96ba0633deda0fef13cbf3dc7', 23.98, 43.904, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '14', null, '2024-04-14 22:45:27', 7.9122744, 98.3459726, 162.26, '323fe4a1de86e513d79a3962109c9f037551178b', 8.67, 147.987, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '7', null, '2023-09-13 23:48:04', 17.45685, 121.74607, 3632.06, 'd2ae5f90a21379e0858438ab11747fb461217212', 17.93, 39.76, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '47', null, '2023-07-08 22:04:29', -2.3019472, -65.0008536, 1372.07, '849c326897f66e4caebba968802331647b9e2149', 27.13, 220.859, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '8', null, '2023-08-29 12:44:39', 35.4394848, 139.3722959, 4977.78, 'ad6cea5c4cee5b0655cd0fd52f6d1a03c6aba488', 31.8, 221.472, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '48', null, '2024-04-19 08:07:27', 54.3880144, 85.797215, 3948.61, '6b45e1d998ff15de9fb6ceb2450230773dddd738', 2.33, 88.628, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '24', null, '2023-08-03 18:59:54', -33.0516935, -71.3906234, 4628.96, 'e820ef25e7883d5dbab4792956b67d19bc9933eb', 15.28, null, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '13', null, '2023-08-08 04:25:07', 49.5178845, 6.190803, 1251.52, 'ef79ea4ab98a9817ffc79e435897d26f001a17f2', 8.01, 157.674, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '23', null, '2023-08-27 21:41:03', 9.0528821, 12.0575469, 1855.23, 'a1521df538e575fbb3ab5ad23682f9294ec793f9', 32.21, 78.182, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '46', null, '2023-07-10 04:12:29', 35.2392644, 128.655374, 4552.41, '59b4b72f5c4d87fedf22b82024dfd76887e69fb6', 1.0, 136.535, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '36', null, '2023-11-08 08:26:13', 53.3934077, 17.6633805, 4035.05, '5b9fce0ba289cf53958723cd42d315ce74e0dff7', 19.94, 187.202, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '41', null, '2023-10-16 12:45:33', 42.9534839, 129.9920883, 4018.5, '9b16ecad157cdd028ab19b9c0e6ba6af6e0774d5', 25.23, 91.598, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '21', null, '2023-09-05 05:17:14', 18.932625, -70.4079274, 3462.2, '4b4bb7eaa7278858adeefd45f6acf9acd2e58806', 12.26, 142.939, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '7', null, '2023-11-09 22:51:47', 49.2176624, 2.121866, 4382.09, '71e8c97c8a1fb213777ee423c79ccb8725804485', -2.13, 206.865, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '37', null, '2023-11-20 18:39:26', 31.8742348, 10.9750484, 1601.06, '73c4fa6b5422665a1960b23dac2c21e0192047df', 11.64, 138.894, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '12', null, '2024-03-03 02:06:59', -23.611227, -46.668872, 1774.81, '7af6c15fa5604f9d52653370681fc2f5d219566f', -5.93, 129.874, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '3', null, '2023-07-15 11:21:04', -6.5211331, 106.8502879, 5062.06, '7de7438750bf74622a87496bdda29d414ae1c0e0', 33.3, 164.32, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '32', null, '2024-02-02 01:55:24', 11.562733, 124.3973046, 3259.14, '6c14343b7f377dc1468181d31bb1bae675119e5f', 7.58, 176.435, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '14', null, '2023-08-26 06:07:53', 44.9794968, 19.6209662, 3918.29, 'dd792a828094b4e691f5178fd41546dbabc6a14f', 36.07, 235.706, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '44', null, '2023-12-27 07:18:46', 55.3734577, 26.2092274, 5531.31, 'b78deb73bfdc97cdc83292b3eb837ebccd043680', 8.03, 120.119, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '38', null, '2024-04-07 06:59:18', 30.1755285, 121.3325306, 2836.78, 'cec9ba34e27054876335346c3cb781653550de33', 36.39, 113.981, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '40', null, '2024-02-03 23:00:28', -7.4043939, -35.5876697, 1203.93, 'e15391d4b353b8847a16bcba86989694828ac836', -4.54, 202.078, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '17', null, '2023-06-19 13:58:12', 9.5138582, 123.1654018, 1273.1, '55f56b9263e319287ca886e925475e50b984112f', 5.23, 57.22, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '20', null, '2024-06-13 18:36:49', 46.160492, 15.8724103, 3514.57, '179a430181f264dfaa964f500e8226fbf3766a05', 28.91, 157.816, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '28', null, '2023-06-18 18:23:23', 47.5202786, 17.5142121, 1771.18, '555fce94eba621e7374bb6a79aedc89e271f471c', 17.4, 97.711, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '50', null, '2023-08-20 15:03:08', 35.40611, 129.16861, 382.06, 'e068a2f651050d3b88a018a93dd2092b0fcad147', 27.47, 194.422, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '2', null, '2023-12-19 08:15:45', 32.19537, 130.02554, 5364.78, '042c75fe936c2371155eb932cb0adab5a58cb175', -6.11, 161.505, 0.15);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '27', null, '2023-09-09 20:25:48', 37.953529, 114.816881, 498.83, '3c86f5a042290248620ab64500129faeb9873bf4', 21.7, 127.179, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '35', null, '2024-04-07 16:02:57', 51.5775677, 16.4684556, 3372.73, '4daaa4888465fb259fcfb6d51eb8516c94dae3bc', -1.51, 139.639, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '30', null, '2023-08-12 16:56:38', -6.904068, 107.6047939, 1022.46, '4d3837880e6479d24f8f5894029a98518ceb954e', 18.24, null, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '34', null, '2023-11-19 07:02:40', 17.9567646, -102.1943485, 4054.17, 'dbe2b9ccc01ba8447fe3786d0a9aebc7d279f508', 20.34, 197.592, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '19', null, '2023-10-21 15:56:42', 47.0302849, 28.7847456, 584.37, 'e677dd2a0ce46cce80fc1fcd3e75b2c9a08e0b79', 16.15, 54.02, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '42', null, '2023-07-27 03:04:56', 31.2570292, 121.492796, 4767.46, 'e67e6f3e95ea4ba148715af1d361be73cba2987c', -8.52, 62.728, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '18', null, '2023-11-03 06:44:28', 45.7123346, 15.8074521, 4492.1, '6a7d93f0ea9d6ccb2f4b74a24ada9973f56b96bf', 6.99, 139.778, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '25', null, '2023-10-03 08:33:05', 41.87507, 21.87599, 1426.49, 'd973f72d8cb3b0534f6c7503da2cb86725089c53', 15.23, 174.108, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '11', null, '2024-02-04 14:14:00', 14.5272379, -87.2157947, 655.34, '9ba175f247285a859ac34710213defcdd9b68624', 11.22, 254.091, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '22', null, '2023-12-05 05:36:18', 10.1980682, 105.9464874, 5029.89, 'e20b712042e9b6ac5a1a7cf4e46fda4ec9aeeeee', 0.52, 168.754, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '16', null, '2023-08-13 23:30:22', -54.281149, -36.5087385, 2741.17, '80f8a62432166c1be3977e182c2aaa86940a35d9', -3.98, 80.116, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '31', null, '2023-09-18 00:18:27', 49.4349603, 12.8128113, 5491.49, 'f33b4b9da29e72de994916b2b30ab6987e9e1764', 3.32, 180.98, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '43', null, '2024-02-26 18:09:21', -21.5418158, -42.1837129, 1925.7, '21160d8b1f87f3f08c4ae500da0f2e86c1c9ae47', 16.52, 193.043, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '39', null, '2024-04-04 13:29:12', 41.410051, -7.4489531, 62.76, '8700fb2c46720bdd50a391d14caeb6dd8f245ecc', 19.35, 161.577, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '33', null, '2023-10-12 12:45:35', -34.493672, -58.5854528, 71.8, '4bee91e17fdf09ad12b461f9646ff3b3d37268c9', -2.8, 8.266, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '29', null, '2023-10-28 06:48:14', 8.8469761, 7.0605998, 1534.06, '5727ca1337cb8c96df88e46f886e0441eae35b2a', 8.27, 215.773, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '10', null, '2024-02-21 17:59:16', 34.8015007, 135.5624945, 5226.72, '3a7db6d8888f60e9c5974d4bea4987e6785f4b6b', -0.68, 207.116, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '45', null, '2024-04-28 03:43:14', -28.6880903, 27.4380189, 36.37, '2d4086016fe3e7880655f7edc9949baa5a811091', null, null, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '1', null, '2023-12-31 14:09:29', -34.6559151, -54.1830076, 2819.5, 'a71fb9fef3f9610a6388e99a6001e0e779d90040', 33.33, 174.918, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '6', null, '2023-09-29 17:46:59', 32.052539, 35.125431, 2447.96, '76b81dfc4dce59c1c6db5ebdee0c0a746c3b0262', 25.2, 169.589, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '4', null, '2023-11-14 10:12:41', 30.4, -91.08, 2432.5, '8ca9e782c9be91808b4a00efbd299be2509f1850', 3.37, 249.918, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '26', null, '2023-08-21 18:29:17', -34.7235134, -58.7945777, 5516.45, 'b084f79a94656666a16f5ce1391b1d306fa07ddc', 17.2, 1.074, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '9', null, '2023-11-02 09:03:48', 3.9572072, 126.6795425, 1680.66, '066091c09d335d8f1a937eb620208b3a06a4a20d', 20.83, 236.843, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '15', null, '2023-12-23 05:44:14', -11.4346353, -41.3803558, 4806.72, 'ba9ee6125a208e9e441f1a951be6655812290b4c', 20.77, null, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '5', null, '2023-07-24 16:37:36', 48.3667546, 25.2298685, 162.18, '1fcb8670cb68dea190173e03402c46fc20d94847', 3.67, 115.236, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '49', null, '2024-01-24 02:42:41', 8.955271, 126.009711, 1829.94, '86618044a50cf07b9e4728cfc0bd72634cb9c2f8', 29.34, 59.802, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '38', null, '2024-01-26 18:31:36', 48.853463, 2.4836829, 556.16, 'a93c67dbe2221b76f5a4118c05ab0064b750847e', 15.7, 186.312, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '48', null, '2024-05-16 08:09:41', 37.177129, 119.942275, 4365.92, '2efc6b87d7481cb4094b2b0b485aafc7dc271293', 39.03, 129.392, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '7', null, '2023-10-11 09:26:27', 45.9859651, 14.5721903, 5952.75, 'c25c94eef7c50c13e8be650488537efaec3cb418', 25.05, 32.315, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '26', null, '2023-12-30 14:57:31', 38.03, -87.58, 4804.59, '94b71367f9ecb728963d4aa5c44e25a63d7c45cd', 21.92, 79.245, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '1', null, '2023-12-30 11:47:18', 43.6410973, 51.1985113, 5795.13, '6ef2f0b00d9303f8b80b674fd9f0fec6abb6b2f7', 35.61, 54.198, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '43', null, '2024-01-29 11:02:20', 32.6901244, -96.937016, 2690.12, 'e26015292259f55603cec353d415cf7c6bf58316', 21.13, 241.363, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '28', null, '2024-04-06 13:36:04', -34.8702993, -71.1664033, 1490.99, 'a793caf416da4c043e1316f5d43cd3001d4d9df3', 24.33, 229.346, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '20', null, '2023-10-27 08:44:33', 38.26667, 21.83333, 4229.04, '03f76a18b57034ff14ea03bf78c7b0fa1da0341c', 4.95, 234.258, 0.59);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '22', null, '2024-05-06 01:25:56', -10.0999445, 123.8132141, 4159.41, '0b4cfe3589d0e9a38d334d459c8d4565a8d83f25', -6.12, null, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '24', null, '2024-02-05 00:09:33', 51.9489686, 5.8564699, 85.03, 'e9b0df52a77e47e50be2c8792983479cb021378c', -3.5, 197.806, 0.26);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '10', null, '2024-01-03 17:37:45', 16.7572126, 121.7504855, 2446.48, '38d69027bb607d3e63cffe2f42da3aec2d9417c8', -7.3, 168.615, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '29', null, '2024-04-14 00:09:01', 41.2166819, -8.0597042, 5058.34, '9deec14c22496403065c2cf082ee6bc84938a30d', 28.5, 202.113, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '39', null, '2023-12-08 06:01:42', 34.0577762, 131.6460781, 5959.32, 'd58ca8bdccc5ce405e30a7543fa7d1a7bab2c1d5', 26.88, 241.977, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '23', null, '2024-02-16 16:55:08', 44.9532375, 17.3583673, 4662.72, '87744275022bc1ba0d373d52f0a92382d2d0a204', -6.69, 184.438, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '5', null, '2024-02-29 15:33:08', -8.3014, 123.4519, 923.99, 'dd7cfb8ed9be822412a9a38176cd49f622cdc779', -7.09, 181.3, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '47', null, '2023-10-12 21:40:38', -21.6824831, -51.0741711, 3911.34, '66529cdf87adc1cb8ad0c688c4f4c75788fc5c3a', 5.09, 254.221, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '41', null, '2023-12-16 05:18:44', 14.6287391, 121.0577928, 433.88, 'a17e97540d63819cbb525b172aaeb30567354a76', 20.24, 41.992, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '45', null, '2024-04-17 16:04:33', 9.3730352, 122.7631154, 769.46, '2271b0ec6e236630aa0a10dd70c4058f55377718', 26.23, 216.832, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '14', null, '2024-03-20 13:09:15', 35.62231, 10.75696, 1047.71, '209244de99d9268b1e80a528a55c18ebe374dffc', 26.55, 10.554, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '36', null, '2024-03-02 00:13:09', 50.2135674, 18.5396797, 4376.98, 'd5f0c655bbe08822e9c9984f3b6b2777552c1c39', 16.15, 96.084, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '8', null, '2024-04-07 10:43:15', 37.261564, 111.769893, 1292.35, '42652bb94f77917c4588ed2f7bb40eb13acd774c', 19.02, 43.755, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '27', null, '2023-09-26 00:54:26', 33.6634952, 112.6061178, 4095.44, 'a52632cee20e842c4a30f9c1ef66360e43ee5cba', 8.01, 94.804, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '3', null, '2024-04-13 06:20:19', 5.329576, 103.1369108, 4745.08, '787c15e2d35ea92dc6318c50f6eff1ad464e0a51', 1.91, 162.626, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '11', null, '2023-06-16 09:16:56', 25.66788, 110.547966, 4501.43, '6b7c6453d6e1211188b29aa7bbd5ae96f63696be', -3.28, 11.83, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '44', null, '2024-04-18 20:51:44', 44.9893604, 14.9036052, 2904.41, 'd8aceb5031503a1267fc8bd3791be10fdee648a1', 11.72, 97.454, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '49', null, '2024-03-13 17:30:39', 45.1604718, 14.7725567, 3583.61, '39e3537e1e215251aaa891ff2c8f6d83cd4cb214', 36.38, 143.195, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '13', null, '2023-07-17 13:37:10', 39.0745039, -84.33211, 5061.37, '24ac19ebaa4a86958a9c560d6f0ed175d3330832', 11.29, 94.249, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '4', null, '2023-11-11 21:41:24', 53.5324492, 28.187043, 5027.93, 'ccca0e9cb33411daf9da09ab303343b559ad3092', 19.37, 193.733, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '9', null, '2023-12-22 19:13:47', 29.079175, 119.64742, 1570.2, 'dfce7edcd6b5326ddc31f2f9c9d8db89c988ecc9', 31.12, 111.33, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '32', null, '2024-05-28 20:32:45', -12.034087, -38.7577605, 5403.38, '249b8adcea9adc5064e21b1aeb01b5516f99021a', 14.99, 26.745, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '37', null, '2023-11-29 15:00:26', 57.2567489, 58.7326317, 913.54, 'd66539f80cb671ce68c675100913401bfd8f30ff', 33.76, 30.407, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '15', null, '2023-06-26 08:04:39', 16.4112875, 120.6026406, 2846.31, 'b88e87486ec4f162b731881941b1e6345fd83598', -6.78, 37.845, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '30', null, '2023-09-22 01:07:19', 32.312511, 109.712183, 1675.52, '343dd1833a22c8dbf243249815eff13b26d85d83', -4.54, 189.066, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '12', null, '2024-02-22 09:17:22', 44.00012, -77.13275, 5690.87, '9e317b88e925cf776f59c038cd9a452659834fa4', 8.51, 120.75, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '46', null, '2024-04-27 12:54:56', 51.7173795, 15.4240467, 1382.28, '7d60a5e58190266ffcbfe57442f2b80d1bcb1d1c', -5.9, 105.811, 0.27);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '16', null, '2024-02-29 16:29:48', 30.1102634, 71.4201301, 4705.11, '0bce23533a19ef33b8c474bbe2d542e5ff5ed8a9', 4.27, 149.041, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '2', null, '2023-10-29 04:03:10', -8.7149312, 116.3426552, 2246.56, '7024a8fd9670192057153a8d61568f46157b6dd4', 3.58, 16.898, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '21', null, '2023-12-15 18:21:10', 53.2012042, 5.8112912, 1493.2, '1686c4f648c05be94f0ba6d6babdd277e8bf8a43', 29.83, 245.394, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '25', null, '2024-05-13 06:43:08', 45.3875142, 4.287114, 1088.53, '721587ba4537362ac796110ceeb3557eb4b778d1', -2.1, 25.145, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '17', null, '2023-11-17 13:09:38', -6.766187, 106.7519376, 4485.11, '60ad19b6d5b27cf9b22ba89c2f90a6a0ecb5c225', 39.79, 66.118, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '42', null, '2023-09-17 23:14:25', 52.96202, 158.25723, 1703.23, 'fdf932ad3a776b3a02318532604a4977f3e4a665', 7.9, 21.925, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '40', null, '2023-08-16 06:45:46', -29.1294007, -56.5481122, 1782.0, '07207ea8a9f14030f6548f712ebe30d6cc5a8ff6', 21.48, 89.156, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '50', null, '2023-10-14 22:45:33', 48.0589455, 34.6153907, 1441.79, '1645fad17a3d418f2c12b52a2bd9f30e1bf7b399', 25.47, 160.034, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '35', null, '2024-01-25 22:15:33', 25.8535635, -80.1484407, 5535.49, 'b29fd4ad08f78e7464235011d2452f1d736eef76', -3.96, 23.242, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '6', null, '2024-01-20 07:31:53', 5.0377396, 7.9127945, 1822.81, '0619bd8d1fc7a6221341496a372b23932be71edc', 20.63, 4.653, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '34', null, '2024-03-12 02:55:15', 44.5209494, 19.7483781, 2390.22, '2ae47ab120e1662b7c1c4b5d25505b91720d269c', -1.29, 28.932, 0.04);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '31', null, '2023-09-23 21:43:22', -6.6845518, 111.4365318, 550.07, 'f73d07eec242960f230e8bde6e2466de6749c3bb', 5.9, 125.217, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '18', null, '2024-04-14 23:29:28', 13.3649688, -86.3959473, 3868.39, '7477d47f4756eb566d2a866eb653a2885279001f', 0.59, 229.403, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '33', null, '2023-07-03 16:30:35', -7.6559369, 109.5895384, 3613.24, '1b36d7317ebb19d4eb24253aa9ab3b735fb3944f', -3.82, 26.593, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '19', null, '2023-10-12 16:40:55', 32.3206, 35.20329, 2306.92, '6ad945ac30fe42f1508ce72648e2e446b6519d2f', 32.17, 122.02, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '12', null, '2023-11-13 06:11:34', 30.137065, 113.509285, 3070.93, 'f9c3e78f2efd9145edaebfd8badb94645b2f247a', 30.42, 235.105, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '20', null, '2023-11-15 06:38:06', 46.322577, -0.4654102, 390.99, '60131b8a3277447184ccd51fd4efceaa8032bde8', 36.95, 8.01, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '31', null, '2024-05-12 13:12:12', -6.7061169, 111.4320603, 1541.19, 'e2c6b2c3942be2c463b031d3d96f2265f38b0bfa', 27.42, 106.544, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '40', null, '2023-10-02 17:08:59', 31.2457401, 121.4824439, 1531.91, '02671f207b7090f2886115a6981cca5c37209ad7', 4.72, 89.134, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '14', null, '2024-04-25 15:02:46', 40.42722, 71.71889, 4322.43, '1e67573bcbf9e0ba223403dd64d0641cb08d0419', 23.69, 16.799, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '44', null, '2023-09-04 01:49:33', 38.919414, 121.56013, 5905.9, '2de5031f9adba2cacb5291ca96b53c33846a1b75', 35.17, 2.978, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '6', null, '2024-02-14 18:27:11', 30.501816, 110.738098, 1937.54, 'ee7a7117d18f9738b95ba77d885fb003cbfb9fd7', 23.37, 159.706, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '47', null, '2024-06-05 10:44:19', 52.020802, 85.908397, 4866.56, '6f3a754d368e95f8e9bd7e36c42a4a765f873b15', 19.05, 98.223, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '33', null, '2024-01-30 09:15:16', 36.604225, 116.249785, 2379.67, '6564a99d7f6a06549fcf0526fd404f377d27d262', 25.78, 234.528, 0.39);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '1', null, '2024-05-07 09:04:39', 40.7038704, -74.0138541, 5742.66, '492e6ec4ad10df355f0c97f4551259621e04c522', 36.15, 202.676, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '36', null, '2023-09-03 16:55:37', 40.2675155, 69.6452877, 513.04, 'b1e7ce7fb88bd6840f529cb043581a53f27f56bc', 5.46, 252.997, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '50', null, '2024-03-24 00:39:09', 45.0169373, 39.1009227, 5500.08, 'ff0e29d262b15f0423d68ac442e76c02c02360b1', 6.27, 192.414, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '16', null, '2024-04-30 02:47:16', 53.3916434, -6.1920933, 549.81, '1c239c537bbc27602771447611590d7a8f4956b3', 37.53, 182.094, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '11', null, '2024-03-05 00:24:27', -13.65311, -73.95396, 1102.11, '4a84d50f2117d31efc12df8b70f4685e8f7fd298', 37.85, 18.264, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '39', null, '2023-11-03 05:37:55', -23.3233727, -46.7294577, 478.94, 'cb0ab75022ff4aad7497d969747681861b71619f', 19.19, 76.676, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '7', null, '2024-04-06 18:42:04', 6.2266087, 125.1233876, 567.84, 'e96ab36d7f9b05e58dc882081a17bc9a3d491fc2', -4.37, 108.377, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '25', null, '2024-02-21 21:50:31', 10.2471959, -63.9201942, 944.77, 'cc4d0f7d167743982009ef68ac6090207a881367', 30.56, 218.629, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '30', null, '2024-02-06 13:28:39', 32.254578, 35.191041, 2406.67, '3cb2b9d82d3463cf8136ef8e72b01d0aa1ede663', 1.61, 116.821, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '9', null, '2023-08-26 15:08:07', 51.4171963, 18.6035594, 5339.69, 'ecf213733b94f35c8b178c9439408638f226b45a', 30.99, 222.333, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '17', null, '2024-03-01 14:27:42', 38.6093672, -8.887687, 5728.68, '1050bceb7bf08e9d5c7dae3e30d0b28375b89757', 31.47, 244.727, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '13', null, '2024-04-08 03:33:33', 3.5053203, -76.7105632, 2022.88, '0094c4b9c0f1f391bcb0236520234a714719681a', 0.62, 80.594, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '34', null, '2023-07-08 07:53:44', 49.467631, 124.782276, 1417.12, 'fd7e96498409e52c5926e0cf8ab9a68b237a280e', 25.99, 190.562, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '45', null, '2024-06-09 07:39:59', -20.5558832, -48.5762695, 3604.04, 'eb9af517339c6a9427a77bd008a7f6111d8cef27', 33.84, 208.157, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '29', null, '2023-10-27 01:17:51', 32.388854, 109.361864, 5623.36, '69b4b08290a82f76db8fb3dfa2e6a4712d87d18c', 17.42, 226.705, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '23', null, '2024-02-11 02:02:51', 49.2095093, 2.5814197, 1480.25, '8d2f9d2cac6674fc23ceab046511c21b5921c0e6', -0.95, 121.924, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '46', null, '2023-11-09 02:28:26', 31.6584818, -6.4103979, 1545.71, '5dcc99c420df31a67c62cac4f406c2521d77f684', 0.22, 225.395, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '21', null, '2023-10-15 19:50:28', 17.76999, 52.48925, 3053.98, null, -0.87, 156.687, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '43', null, '2024-01-01 07:55:18', -18.3604041, 16.5805056, 5669.9, '213930802bc3cb7d473ff3d271a65cb10dc89664', 11.77, 5.883, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '37', null, '2024-05-24 19:20:17', 40.6196638, 47.1500324, 4733.46, 'ffb98541707e11491cb9e4736bd9e5f5b5d3fa12', 3.19, 90.599, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '15', null, '2023-12-12 04:13:23', 5.5249526, 7.4922407, 5328.69, '1c458bc89923705d00a5c0894e5f6d22052fe320', 11.62, 162.755, 0.37);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '35', null, '2023-09-20 20:13:42', 28.1905018, 112.999502, 4657.87, '237e9a07c6eb854171fc0e7075f63e7607fcb300', 37.05, 91.089, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '2', null, '2024-02-10 00:47:02', 47.2173146, 15.6237211, 29.56, null, 7.13, 40.629, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '4', null, '2023-12-02 23:58:26', 64.128759, 29.5197329, 2900.55, 'd664e23d2d1af7fb5cc1649ff0b78809de1e3c54', -1.38, 126.035, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '41', null, '2024-05-08 00:42:31', -7.3756003, 110.9476831, 3850.29, 'fb2ec5a3552e71311d242c0fe8779f5eb3ec5445', -3.44, 75.444, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '48', null, '2023-06-22 11:43:48', 29.57858, 110.191933, 1519.67, '71cf03a96c4436696b9e6f060005854725075810', 30.76, 6.295, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '26', null, '2024-03-10 05:51:14', 43.262695, 45.6506664, 4161.54, '6cbd99462c3b573afde6ac288c5e57644b22eda3', 17.5, 149.925, 0.75);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '24', null, '2023-10-23 12:04:06', 58.5355022, 25.4666818, 4484.91, 'd5deff8a64c06a0fa5d1c26b0dfcfeae5ffb97a3', -5.57, 177.723, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '3', null, '2024-06-08 06:28:13', 35.3527256, 24.4345055, 2525.08, 'f3f9b3843de342e1e0738ea19650589133e916cb', -4.34, 231.576, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '42', null, '2024-05-10 06:55:24', 4.888109, -73.366926, 2810.94, 'fe2d541cc27c56c53de5bd0315826eb8c6c139c4', 8.04, 106.753, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '19', null, '2023-11-22 17:17:59', 46.051126, 125.961814, 3697.97, '9b9026ea15ff988489d5d8f8b235c32f55461d59', 12.15, 150.09, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '49', null, '2023-09-02 23:53:57', -6.5978669, 106.635025, 5059.98, '8ab71b7d817a6a89fa8527401d1842d446d0175e', 23.99, 192.955, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '22', null, '2023-06-22 20:27:54', 19.453837, -99.1227878, 5225.73, '625209ada7b2ca006ef023c6d97f58092a94cf94', 25.28, 80.685, 1.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '10', null, '2024-04-09 04:42:09', 7.5273576, 125.6239227, 2655.42, 'c374b6e4c46bdfb477950edef7c8fc2290c05702', -7.57, 242.306, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '18', null, '2023-06-30 19:35:08', 18.6522482, -72.0927374, 4922.93, 'a378038b9bd71508167fc394de0bdf1c15175bf4', 15.55, 98.157, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '28', null, '2023-07-11 17:37:30', 36.962751, 100.901228, 3377.66, '188e642f4bd67eb80c2bbcb901e98ded29632e48', 33.92, 213.062, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '5', null, '2024-05-02 17:21:41', -6.9122509, 109.7457739, 5432.4, '7b0bb44768b38a3de74b83c1522ee2fc9d4bf5ab', 15.04, null, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '8', null, '2024-03-21 04:40:02', 3.7334765, 96.7999931, 461.41, '3120d54ccd17066ec277b839f7261a0075bf007b', 27.36, 32.586, 0.71);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '32', null, '2024-03-09 02:35:22', 8.6761, 16.566, 2309.68, '52a98f78fcdf8f8b42791e64bdd89c02ad260d83', -1.76, null, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '38', null, '2024-03-24 18:33:53', 49.67403, 20.07982, 808.33, '88ac330fcbdd52087f2330e45a95e0d1cdcc8af1', 24.88, null, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '27', null, '2024-03-18 10:14:55', 45.01, -93.65, 2624.71, 'e9fc24a2c88d93f86d0aede77aebbc36458ee427', 33.73, 86.67, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '20', null, '2023-09-23 12:06:46', 13.9603097, 120.6382357, 58.21, '522c0a1f84b70d20c8852f1670e6b9fe6335d322', 26.74, 177.488, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '27', null, '2023-07-01 19:12:02', 55.9955698, 40.3295557, 2179.39, '09c1b27fc6207d58d5ca8ca556913e1929733103', -2.17, 253.202, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '43', null, '2023-10-22 15:46:10', 31.6903638, -106.4245478, 1694.07, '0f9154aa15f0e844c04d22d8a85843990bfae7f5', -1.99, 183.228, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '38', null, '2024-01-11 19:01:39', 43.3831419, 17.592739, 5273.1, '1ee2452957585a0ff0e89baa5c319a63198f5dbc', null, 147.817, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '50', null, '2023-06-23 10:43:30', 57.1260445, 43.8059949, 4382.82, '9c7574600216c34072ddc310a4c5e852a48a2a3c', 14.58, 162.879, 0.15);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '10', null, '2023-08-09 09:26:43', 53.3417941, 16.0872459, 2363.45, '3a676d9d768e15f7c5ca1b3d4ea2ea91051f92fc', 30.99, 146.449, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '29', null, '2023-07-29 20:35:25', 16.2107446, 102.4839212, 309.14, '9852d0815698f1b5240d3328f6b435205d291f9c', 18.98, 222.218, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '41', null, '2023-10-11 11:16:16', 53.231395, -6.124065, 1460.53, '4e6dc0896e6f7e27d735965d0ac222de68019e49', 31.87, 168.673, 0.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '19', null, '2023-11-15 17:04:26', 1.3573565, 103.8832261, 1265.22, '46d185530d3af221ef814b88c4ce14b9144e113e', 39.03, 121.348, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '7', null, '2023-11-08 21:15:02', 56.6226418, 15.5189476, 705.19, '82420ce0f9968cccc57271163ad4a39afee775a1', 12.95, 43.514, 0.58);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '21', null, '2024-05-19 08:54:35', -25.7189601, -56.4104044, 4060.76, '6848acb2193f969fdfc980845d5d1d4d6554a54e', 5.91, 52.93, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '48', null, '2023-09-26 02:26:04', 33.048227, 120.575443, 5314.95, 'ec3063ebf13d805bc97f310dcb612067e75f5627', 32.79, 214.632, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '4', null, '2023-08-24 10:10:45', 36.776357, 119.98842, 5619.68, 'ab3018069630de04c35be8995013a97f12179041', 5.09, 163.858, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '39', null, '2023-09-24 08:42:30', 27.7303815, 112.0069982, 2959.18, '470c116d8fd46c447272db8bc7b83df0a88dff42', 5.29, null, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '3', null, '2023-08-14 21:56:00', 50.1381207, 30.7373521, 4864.94, 'aef71d565fab06f26c1b05726a85b8814218bc37', 19.11, 153.003, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '33', null, '2024-04-05 13:00:58', 13.4817182, -86.4920736, 274.07, 'fe3a67f9d4870e60a579ee8df1bbcfdbd2a8435c', 3.82, 13.452, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '47', null, '2023-10-11 12:28:50', 41.139883, 22.5397872, 738.01, '7a40208aa11e1ff25b9d70ddd8f36e3c183a9d65', 39.43, 227.175, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '18', null, '2024-06-13 02:42:57', 44.351935, -87.8445954, 5178.54, '0d8d2248b9f4d8d267db09f8ecb5f862cb2f533b', 36.41, 123.086, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '46', null, '2023-10-22 07:22:45', -19.9930478, -43.8485566, 361.56, '545c3b5fb8a85b028433dacbb90fe27e4cd4205d', -3.0, 237.103, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '22', null, '2024-01-27 05:06:56', 58.7472646, 17.0266546, 5304.66, 'aef46ba83cbd83a99ca56a8953a00fae2b191816', -9.06, 3.338, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '8', null, '2024-05-25 15:02:46', 39.3621896, 22.942159, 2949.5, '63f973dfeaf5496b26ca182e587dabe50f24fdc0', 25.08, 252.363, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '30', null, '2024-02-24 20:38:02', 32.901093, -6.7761686, 3841.7, '67cf029b7358db19fb27703b7eeaca4946c055c7', 29.79, 115.183, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '5', null, '2023-10-08 11:01:55', 10.6095479, 122.955299, 2996.04, '96a8665060896975559e67e15a7d95ada11272d6', 24.12, 156.378, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '23', null, '2023-08-07 18:30:27', 52.735825, 20.7121262, 981.69, '8ada57051359d9b989bd30d2ad0ce5d05d447567', 26.14, 97.1, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '40', null, '2023-08-12 04:29:30', 29.2444816, 52.7830627, 4861.9, 'f02064e2a551a76de362a5fb1303511af9ce543a', 4.53, 87.105, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '49', null, '2024-06-13 18:05:30', 48.6513092, -72.4519727, 2179.87, null, 24.28, 223.83, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '17', null, '2024-05-02 12:59:23', 16.5909145, 100.2992789, 3753.96, '75f8a03b461f0621ed7405e48db4d6858ad47268', 9.73, 210.383, 0.15);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '6', null, '2024-01-02 15:30:52', 22.9406641, 89.445851, 2579.72, 'd8a4e47d09da7adbb736653e4d252056f7813ff9', 16.1, 176.309, 0.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '11', null, '2023-08-04 19:45:14', -10.1774, 120.3595, 2710.46, '0f2217e150c03549d92a92e0f074ef83dcf1ea57', 17.21, 91.146, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '24', null, '2023-10-24 04:05:11', 40.0911416, 44.3907546, 2638.32, '3e1c04881ec22720e49173312e69a3a2b826582a', -6.98, 181.273, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '13', null, '2023-08-11 12:18:25', -31.6146073, -60.7152064, 3468.34, 'fab76372354871c7c5a46475a538ae95d85d83b0', 21.89, 54.121, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '42', null, '2023-06-20 10:41:26', 41.2614535, 24.9516869, 5832.14, 'f2ec0cb5fd7b13051df76288b2d89c103a01edfa', -7.99, 142.762, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '45', null, '2024-02-16 16:42:07', 22.000143, 100.771678, 4030.99, '353926e0b479419074e3a80a78cdfccc3d20d728', 26.37, 4.057, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '36', null, '2023-08-19 23:10:15', 46.7391101, 30.7866668, 1410.11, '8fa98e20f43aa90e9d5a77395a13c30b5c97a983', -9.77, 59.853, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '37', null, '2024-06-14 06:30:36', 28, 86.3, 983.92, 'f2f8161dc4867b176f3a4282a6e1bc5604cc0422', 11.92, 84.322, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '12', null, '2024-02-28 13:41:42', 49.9467601, 5.9721206, 1894.67, 'cb0f66c586a398b04344dd18a82881b3b7f82fd5', 13.3, 94.853, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '34', null, '2023-12-08 05:46:14', 33.094679, 100.596781, 2065.26, '51153d7e650d8ee3bdb80508d1c35ecc41f67d65', 34.18, 143.597, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '25', null, '2023-09-08 08:51:01', 15.1805822, 102.2575235, 1764.12, '20b77bd985b99cd4a0c62ca84eba4964fa596e05', -1.27, 139.418, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '2', null, '2024-04-05 08:35:19', 43.4945737, 5.8978018, 4522.05, 'fb8e85c275c8880192204f49eec3c4da80cbb740', 37.62, 193.135, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '1', null, '2024-02-21 06:09:42', 42.610438, 47.5970197, 5083.87, 'e704b0c5335e26e4e2abe2e40d66b86dea61d4f2', 29.35, 37.669, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '28', null, '2023-07-19 14:41:45', 38.0818216, 140.0392974, 33.87, '759045c162e7a618d3e1615b4902c1f888c1a969', 25.29, 141.254, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '9', null, '2023-10-13 08:33:38', -7.1582623, 107.9235563, 417.5, 'f4284582d7dbd845673fe22da5d85c21d43d4e90', 14.28, 122.062, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '44', null, '2024-05-21 00:57:42', -6.7597, 111.3245, 2029.4, '2d36cc24bd67e77f544d64ed819279771a6e89f5', 31.28, 162.692, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '14', null, '2023-12-08 08:15:00', -13.3964033, -72.0514291, 1133.12, '65b01ec27ccd3235fe7786e9bd9539e94113bb19', 10.84, 136.665, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '26', null, '2023-11-16 15:44:08', 22.948016, 113.366904, 664.96, '8e1c38576bb1de1aca85fb8491f867cac05ec83d', 31.26, 97.32, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '15', null, '2023-08-23 00:16:34', -17.76667, -149.41667, 4967.35, '9cb7692369d08db5e4eb37e0d5c5d8c464406f05', -0.18, 247.801, 0.3);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '32', null, '2024-06-01 17:21:31', 36.813372, 121.620148, 5571.14, 'e9fc466a33cd0e59bc5b997fd096c179614e9eba', 0.23, 35.663, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '31', null, '2023-07-05 23:22:11', 57.7313899, 12.9130426, 4303.6, '212fe04099c6ce77442cf5c1046c97a05aee79dc', 13.55, 251.747, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '35', null, '2023-06-23 07:00:15', 21.7425323, -78.7872876, 2239.99, '30742036b84f8c0da1836b8c510c2103272c56eb', 3.72, 195.055, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '16', null, '2023-08-19 01:51:28', -32.0288506, -53.3936083, 1823.74, 'dcfb7723f9ddc75ee5981c92d1e58ddb6f758185', 15.56, 7.343, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '26', null, '2024-03-15 23:42:20', 45.2213834, 37.1168274, 4657.75, '60880b431aa1263cdb08002bf57c56289b1917ce', 17.33, 135.436, 0.96);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '49', null, '2023-08-24 12:28:04', 23.8882098, 90.9605637, 156.83, '971b2c73ad6efdda8d61e47e7e054e708c8bade9', 35.38, 228.36, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '50', null, '2023-10-02 13:24:04', 29.509067, 110.300741, 5742.4, '11e483da747f6887e63a3fe1d5dbf5a37fd11f24', -3.69, 79.069, 0.39);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '18', null, '2024-03-05 00:57:14', 61.3066824, 17.0542559, 3265.49, 'e14e567d19db8d95de7bfee7cdc9e0f78ed01aa9', 26.42, 34.45, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '2', null, '2024-01-19 21:57:10', 18.2943776, 105.6745247, 1810.77, '8f40b2e76eff49bcec10b1e814c66f8fb56330b9', 18.91, 142.742, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '20', null, '2024-03-04 02:41:16', 34.313074, 108.715716, 2965.51, 'be4e7f68d709e1e2cc218066b245ac2fdd33a3e5', 19.74, 123.85, 0.01);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '44', null, '2023-06-22 02:15:40', 22.7918505, 100.9840933, 5397.98, '73ce8a2f525e1fb2302cacc2783aba88b7a5e8f8', 1.81, 167.243, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '9', null, '2024-04-20 12:17:43', 28.1434318, -82.3343375, 3999.37, '1215017e2caaa0179ce516fee35368db97fada8a', 14.51, 21.743, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '29', null, '2024-03-13 13:32:42', 23.945891, 104.412274, 2376.84, 'b94772e1d1b7b7fc5670b7ebcff7bd28395e8496', 32.65, 232.659, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '13', null, '2024-05-16 21:37:46', -6.9001, 113.5144, 309.3, 'c3867b026369c681899b802e5221ca6273c8ac1e', -8.71, 75.842, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '15', null, '2024-01-27 21:28:05', 50.9210958, 6.8968829, 1817.35, 'd83491d746f83990b5968dde2b2bcd6f54b59d0d', -1.53, 172.674, 0.75);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '21', null, '2024-02-09 18:08:06', 16.4306671, 100.1255164, 4316.5, 'ca01da210c60303ee644a6cc5307efa319ac68d1', 3.29, 112.876, 0.11);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '11', null, '2024-01-05 17:21:42', -8.197451, 112.6079459, 1745.49, 'caea807e2f945fde2e183b111939020f488381f6', 14.71, 147.843, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '48', null, '2023-10-03 01:17:58', 43.1235823, 132.392159, 4142.3, '35f672a2683ce3b841f97db32e7abdfec030170b', 37.39, 224.91, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '30', null, '2023-07-06 12:46:53', 48.8348801, 2.5070548, 5303.44, 'ea61f66f5d6e81e408f076de9a0b289c33b5d494', 16.12, 113.56, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '6', null, '2023-07-13 16:41:06', 32.0947711, 20.1879106, 616.74, '2d661b1a6af8b2d7d1c4307a6e58b39bf24f7030', 37.46, 135.247, 0.27);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '36', null, '2023-09-14 05:52:30', 34.052996, -118.2548551, 672.16, 'b46dfe59c761cf58ce402aebd5edcc947b5162bf', 17.99, 145.781, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '19', null, '2023-08-01 12:39:11', -6.8646647, 107.5889804, 5697.72, '3ae50708083cf3f630879e3165922ea20c57f478', 34.13, 52.878, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '40', null, '2023-07-14 09:40:15', 53.4131023, 18.0085553, 4859.48, '89921026b14edd5fa1169ad91f6a40a9b53994a7', -3.11, 185.603, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '4', null, '2024-05-22 17:12:07', 57.8852519, 25.4597761, 1336.54, 'ddae63d2a707781c840f5497262ab3e77008121f', 8.64, 23.993, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '10', null, '2024-05-16 20:24:02', 46.9, 109.75, 3836.51, '22f4a844f60efb7279f75d3ec1e4aad8bfdbac64', -6.9, 171.989, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '39', null, '2023-09-08 00:32:28', 39.224791, 117.135488, 3892.38, '22766983998ac32ef5229bb7f94b1028bcddda02', -3.01, 111.713, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '24', null, '2024-03-01 18:28:39', 11.8514489, 3.6547195, 1185.72, 'c9bc37ae91e65c3fdb4b7ce38f1bed1b806566a4', 22.76, 199.641, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '32', null, '2023-09-29 19:53:44', 45.6011009, 20.1415393, 5977.59, '4ac5b9d05ea27b7d605421724493a24f559c871c', 33.46, 131.101, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '7', null, '2023-10-17 13:53:07', -6.35357, 105.84432, 2968.85, '00606b6be235a6d9ff5fcf3e4c175013fd5bdaed', 26.08, 102.339, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '41', null, '2023-07-03 06:18:29', 31.060387, 31.6511258, 5077.04, 'e024a786122a3004817da5d4727893ce53197cf0', 29.05, 214.226, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '25', null, '2024-06-09 14:17:08', 14.0031627, 0.7556575, 4515.03, '743c16a7ee9be8b0beb8fc92e0229d545b3f8e47', 23.48, 148.237, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '33', null, '2023-08-08 09:33:05', 19.2273454, 99.9608287, 3653.31, '161516b5a04b0f631593740e2ccb9a0fbe1c35ca', -7.84, 247.994, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '23', null, '2024-01-27 15:34:53', 14.2042871, 121.0829852, 4560.0, '041fe9599d53e6fb893b7f58e9db7ff7a941a105', 3.33, 198.634, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '17', null, '2023-08-27 21:36:02', 40.0480719, 20.7528378, 1954.41, '7888dcbdb3553e54865a8c0c647abf9934fa009e', -3.29, 146.707, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '16', null, '2024-01-10 19:18:52', 40.9282833, 24.3057691, 2940.19, '498642c9497587250201a94cb7b810e10bd407b8', 11.69, 20.271, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '12', null, '2024-04-05 18:56:47', 15.9448806, 120.1907996, 4432.4, '292aff0a4bfaceb1ab1e1c92c4a4f8f702f31306', 29.5, 125.897, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '8', null, '2023-06-29 07:29:11', 39.1971979, -84.4578361, 1405.03, 'c3401984ffbab0e0655a145b1d36aa84909db93a', 17.02, 210.542, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '37', null, '2023-09-23 08:26:57', 18.1646497, -73.8110279, 3824.32, 'b5af76d4e7619ac8715d637fb3e032acab2b60f8', 26.19, 192.401, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '38', null, '2023-07-26 08:10:03', 29.643475, -95.4253757, 5293.32, '76d94fcf12d113654757e4164a509ab0d8bcb8da', 4.04, 92.66, 0.58);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '27', null, '2023-12-21 10:38:12', 23.301616, 115.660142, 5824.82, '222e6eecf7f6e08034abd6af55d2983062ca9f68', -4.47, 122.789, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '43', null, '2023-12-21 06:16:03', 57.7567214, 11.933686, 5765.66, '026678d78138701aba8bbf2de5b23056510dab38', 37.02, 24.684, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '35', null, '2023-11-09 08:22:40', 19.3972335, -99.1933664, 2757.74, '462d21c241fa60d3562ea5059043bf65b93d9d89', 26.89, 155.317, 0.22);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '14', null, '2023-06-15 18:29:43', 27.8469, 105.049027, 1870.22, '58cd55e3d4590728eb0413de85141286abfe82b3', 24.11, 100.88, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '45', null, '2024-01-30 21:43:15', 31.263629, 121.58448, 2190.41, '3524f4968820a05e73736bb61804093da187404e', -2.8, 196.834, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '1', null, '2024-01-25 15:15:33', 14.914778, -91.444669, 4608.46, '35c702c866c780c4141ebbe337c64f839c85bfcf', -3.55, 250.331, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '34', null, '2024-03-13 00:56:00', -7.1765167, -47.2923893, 2885.65, 'ccfbfd319fbb2839ae8a2a071fe1bf7351f89c19', 21.03, 181.863, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '47', null, '2024-04-30 22:54:36', -7.34307, 108.16434, 3218.45, '5fe74873e681b07a46d8af9c7f5c825f22ad2add', 20.19, 11.84, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '46', null, '2024-05-23 18:27:54', 38.95389, 127.89167, 2831.32, 'f30f44211fc771070760c0dc64c2095be766c47e', -2.01, 178.717, 0.58);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '31', null, '2024-05-24 01:08:45', -11.18917, -76.95139, 1622.61, '11b4b77cb88b06082ca9adc2f61d4ec2e13a46ba', 18.99, 137.173, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '28', null, '2023-11-06 01:59:25', 49.5597209, 12.7714782, 4727.65, '1a5ae1c08c2ad7926315a2629286b70f2cb4456b', 33.51, 204.094, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '22', null, '2023-09-18 15:13:03', 33.85, 44.233333, 2489.31, 'e338c27efca89dfc770813535f705ccc76bea107', 34.9, 39.81, 0.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '5', null, '2023-09-09 07:13:24', 7.7688818, 125.8239543, 1542.58, '5ef2e5d1a93982688a0e86b8f7c20cb4e1a4a790', 20.4, 165.417, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '42', null, '2023-08-11 20:52:26', 37.54, -77.45, 2340.66, 'fd15bdbdc591d2ccf277096fb559db6cc9e6b6a5', 5.39, 68.371, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '3', null, '2023-11-04 08:20:37', 7.5958893, 126.4361995, 3899.58, 'e51792269d95444982b12e0172de89a884459513', 5.27, 29.368, 0.18);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '28', null, '2024-06-03 23:58:56', -6.5211331, 106.8502879, 361.97, '5bc18735c833a14a58eeb3edeb98ea650e4e0138', 21.83, 50.272, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '36', null, '2023-11-12 11:40:57', 37.6703123, 140.6062909, 2485.82, 'a40f5b3316cec4dd8471865a1cb72351c26af43d', 33.13, 63.619, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '33', null, '2023-07-15 15:50:13', 48.1181855, 38.4585264, 5733.18, '1d42ff92b13a63c29c676e1a9de41b650d3f2190', 22.0, 164.049, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '42', null, '2024-02-06 03:02:15', -38.7445218, -72.9482281, 433.65, 'c36ea8f536ac1007d1b84df2fe2e65540816e008', 2.78, 214.888, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '38', null, '2024-03-24 15:48:14', 37.464539, 121.447852, 1452.31, 'fbe8a095193c4e52c21d9369030fc7f70c43c888', 39.14, 176.495, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '40', null, '2024-04-29 00:08:10', 31.5587, 35.1244, 4128.71, '20ce4c3a2d377a2d4ef01346545a9b1c15e2fae2', 1.96, 103.181, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '46', null, '2024-04-22 19:57:26', 48.0386685, -2.9231898, 3221.76, 'a5d95576fb569c99103429938ae2185a67395891', 17.36, 214.191, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '49', null, '2024-02-11 02:59:11', 7.08931, 171.3805, 4808.67, '0961d7b7339290efe578700e98c55292999c2737', 15.25, 166.407, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '34', null, '2023-08-29 03:29:01', 49.2803655, -0.2062549, 5228.49, '111b3e4f95c3447d6e090c5b2f49bb5e4c7ec6fb', 7.09, 153.492, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '7', null, '2023-12-25 17:40:37', 12.6400252, 10.7048554, 593.34, '8e86c3ffeac0046d6b0128ae5efb9146a4cdde84', 13.3, 198.385, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '15', null, '2024-06-02 00:13:06', 36.1069958, -79.8522564, 314.14, 'c6f208c49d96ed9e5dd3db834756029eb9beb323', 20.4, 125.655, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '8', null, '2023-10-15 13:37:11', 62.1331515, 22.55812, 4229.62, 'ddff7adeee2d43348fa6607b91484b435e469712', 24.5, 31.203, 0.52);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '44', null, '2023-06-24 12:46:39', 9.4535964, 12.0318456, 3203.23, '9a2140377badf22cd0e92918c43a12d35e237358', 11.11, 2.417, 0.93);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '20', null, '2024-02-02 10:53:23', 13.5085076, 123.1804731, 544.52, '4a0982002b17ef5b8bda25b3d19ef4582e153243', 31.63, 51.542, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '47', null, '2024-04-28 07:49:05', 40.024639, 122.711528, 909.84, 'c671b9ce388811689ad37e1cee0771670a82c0ea', 11.26, 46.913, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '4', null, '2023-12-20 22:12:51', 44.32554, 133.48134, 4825.96, 'abcd3133e206c12f44f578bae352d4c487d4e9ea', 25.31, 50.84, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '29', null, '2024-03-10 19:43:15', 23.2905, 113.234549, 1191.77, '4691b176b224bcfe9a618453def204f511f17daa', -2.88, 40.532, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '32', null, '2024-04-30 01:23:28', 45.521519, 3.5276642, 5999.36, '5d6b37d626a133b31ce0554ca4610665d873fdc8', 17.33, 214.705, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '26', null, '2024-05-15 16:54:22', -3.059218, 128.1903079, 2326.59, '14f7f938472fb22f3ee381bd97ade7d6e05ae4ae', 33.42, 174.238, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '2', null, '2023-12-26 19:16:09', -37.8268291, 174.7994271, 4074.71, '0d357c182c2bdcb7f98a19d3b501852f4cdf635d', 23.28, 254.636, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '18', null, '2024-03-02 09:27:24', 49.476996, 0.1639479, 1902.43, 'fa50f6f8e040b9a30bb2a8323840f1eeb08e51d4', 16.93, 56.045, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '31', null, '2023-11-27 11:07:14', 43.3911349, 42.9174509, 5824.26, 'f013eaf553ea2071c2f7c4bc2ce87d0ce99e0d15', 32.23, 184.35, 0.21);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '43', null, '2023-12-13 07:00:28', -22.5698961, -49.0817124, 1360.93, '667988e1d30c6a1401c211c95192b78293a070f1', 14.66, 21.665, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '39', null, '2023-10-15 13:17:34', 10.0192191, -69.2519936, 1718.19, 'd1412e0b4ff1e1969d69591388b933df1e11e8a8', -4.65, 40.568, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '41', null, '2023-07-08 01:33:09', 55.40776, 38.66261, 4869.86, '67937cea38dd66a93efa83437f8ac9ef4546249f', 36.43, 60.173, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '13', null, '2023-08-26 20:37:42', -34.6637851, -58.5017947, 3426.13, 'e27a88ab21befedea22565d30a9e7cb2f3520a61', 16.19, 176.237, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '11', null, '2024-03-03 14:43:08', -6.9078493, 108.5908437, 25.41, '01518e5ba5dbedc0e2a1b5e7b8c284fcc012ca43', 30.87, 122.767, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '10', null, '2023-06-29 12:28:16', 58.3669548, 45.5416034, 1372.23, '86d2bb71fb17324101f957b4f8fb4b2de28e3c03', 14.07, 90.784, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '19', null, '2024-03-06 23:55:04', 25.797931, 110.011238, 1150.73, '055ed74f9dd3b5179028d402af780b59fec27897', 13.92, 201.606, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '17', null, '2024-02-14 03:10:43', 39.9378208, 116.4103205, 847.36, '95499de4406f4c2e26f7a8ffc54b8f97f412f514', 11.39, 36.358, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '30', null, '2024-03-14 22:05:18', 44.0264621, 5.0852479, 2090.16, '2e4061cbcb912425001103e4663b05c807d8aaa5', -6.05, 9.223, 0.02);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '3', null, '2023-10-28 11:21:15', 5.6460924, -75.3178952, 5274.04, '6359815f3e7ada6a3c5366c17ee1010b8bc89478', 30.51, 117.189, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '27', null, '2023-12-26 15:36:35', -13.6332, -72.232262, 5435.32, '342bba1478b20882540bb6ce733c5379c4ed1c7c', 2.94, 121.271, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '48', null, '2023-12-04 21:04:57', 54.4868002, 18.2202834, 4005.8, '36145918bf3d27167c4e533af182588ef4538b86', -4.3, 232.815, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '21', null, '2024-04-17 16:12:10', 31.219568, 118.268101, 3526.35, 'e83e27a279e57df419d879b1a2594180a510e62f', 24.35, 4.643, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '23', null, '2024-05-07 15:14:16', 55.1662846, 58.7926322, 3953.9, 'a0021fb743883d9fb877ca71d23e24489f29491d', 13.36, 29.403, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '6', null, '2024-02-27 08:51:18', 34.477861, 110.084789, 1617.29, '69ccfb9a2fd4330604724920369403151434e276', -7.22, 249.471, 0.17);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '12', null, '2024-01-28 06:31:39', 23.1004248, -82.3858672, 1248.64, '6d78e1c8661287c941adc510bd1f8bbe649f6c5c', -3.44, 155.722, 0.59);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '16', null, '2023-11-16 18:27:55', 41.103983, 114.05056, 4841.3, 'f06ce2ca2e5d8b5033b7e8c6d6069970e974a42c', 29.1, 204.799, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '45', null, '2023-07-22 02:19:55', -8.0038635, 113.7216313, 5420.64, '13080af430af07795cd44936a6732bca22a79f1d', 6.87, 124.522, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '37', null, '2023-08-20 12:27:57', 34.0683214, 72.6206912, 5070.12, '437bfb3d218de532b32d20c8aa89b4ae04735439', 38.38, 49.388, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '5', null, '2023-09-16 20:57:50', 36.3006568, 137.9047429, 4198.06, '46a5579f8ce68a987598b70e56816505cd6f63ad', 25.29, 142.881, 0.93);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '14', null, '2023-07-27 01:01:08', 48.1752793, -1.7274799, 2651.16, '9d1dae8939832fdb5c73c4a9c36c9b2bf75e1c5d', -7.87, 99.788, 0.61);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '1', null, '2023-12-28 01:25:53', 41.3836182, -8.4170742, 3206.87, 'fc4bdb620802bcbf9cf4588b36d71e8c628a1626', 21.51, 108.126, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '50', null, '2023-12-23 02:38:00', 52.7990255, 27.9918895, 1547.05, '72935eb7035d7284aca24737fe649a5034dc4af3', 10.95, 157.605, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '9', null, '2024-06-07 19:17:47', -8.5392331, 116.4134873, 517.33, '3271e34abbbf96b7b7f2ce1844b03e84cd34c81b', 29.08, 4.925, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '24', null, '2024-01-05 03:21:59', 33.844582, 115.778676, 5980.7, 'e3e97cc1ad418ce14f9f580f85558c641c79e852', 27.56, 157.984, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '22', null, '2024-05-28 01:07:23', 10.3570803, 124.9696526, 3655.1, '00fde551e0c7c9538dd165035f4339c3d1f7e890', -7.5, 129.788, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '25', null, '2023-12-09 02:14:18', 38.9021066, -9.4174646, 2456.73, '6453999571ee11b0cf871bc97701fd7daa7e7e5c', 10.28, 220.221, 0.46);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '35', null, '2023-08-25 03:36:38', 33.54832, 36.21564, 709.93, 'adf8c54e71de31f4e24c3ea726add0426eedf7ac', 24.11, 149.301, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '21', null, '2023-07-03 09:14:15', -6.939897, 106.9506175, 3653.13, '9b261c32d540c2dc4211b927ae2472a61deb97de', 35.45, 237.39, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '19', null, '2024-01-06 16:09:09', 39.3915625, 21.9245288, 2802.29, '65d672271b82481f0924aff1f16208b4386d25e0', 14.31, 249.429, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '25', null, '2023-12-14 10:14:02', 39.3046388, 23.2207655, 3880.32, '192e20002e2d89580104b0297dae2722eb93316a', 11.75, 148.267, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '16', null, '2023-11-20 02:10:17', 28.179427, 121.216559, 1963.28, '236bf5ac91914ba2ab39c867e53180db606b2a3e', 10.36, 1.91, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '50', null, '2024-05-15 06:12:44', 51.7241507, 103.7082244, 3973.16, '30d228c4356d1e45722419450c21ffbc131beb82', 7.03, 37.841, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '2', null, '2023-07-26 02:22:26', 14.6430983, 121.0219885, 1338.5, '3d1523fb531a965a9c9137f99ad03f6062cece39', 33.29, 103.128, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '35', null, '2024-04-15 12:24:09', 42.8591137, -2.6844071, 4757.85, '185d0ad52a998e798573e7e5ab45982e4ebe22d1', 33.86, 64.665, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '46', null, '2023-11-03 08:05:17', 3.5233855, 125.5110513, 4762.14, '72b3d35bf9865cb36e4d8f012c85c3495afd5f64', 27.94, 85.209, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '20', null, '2023-11-12 18:42:06', -26.4822209, -49.073477, 3088.09, 'e73b4e54b829fad6a451c2d2616493fbe7f7e8c5', 26.49, 146.025, 0.99);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '4', null, '2023-11-01 16:49:24', 40.8318278, 44.2797884, 3480.58, 'b125679ac927c4ec223d19ed57c400cc38a1ef12', 1.74, 96.184, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '30', null, '2023-07-03 23:11:46', 30.3321838, -81.655651, 1666.34, '7028de94df4ce7bcdae74b1c37288bc7d167f727', 8.18, 128.767, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '24', null, '2023-10-31 21:37:52', -34.625324, -58.5187733, 5706.49, '755edc2366b36b7768d429df10dd5b7d5f80d5ff', 28.87, 153.777, 0.75);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '49', null, '2024-03-11 16:25:45', 0.8768231, 120.7579834, 5227.52, '7be4c8a9335578f758d4a3863c69a50cbd63d76e', 31.72, 159.034, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '18', null, '2024-06-10 04:01:41', 3.5126215, 33.9750018, 3357.27, '6a38a8a24ca292e79d12ec8e2620ddc7ce97647c', -8.14, 157.429, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '37', null, '2023-08-26 01:10:20', 49.0337974, 2.0875699, 3698.58, '98de1e8d0de25ff75da61cb5793c4a9e8347090a', -6.98, 223.062, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '40', null, '2024-01-16 08:04:08', 39.0730329, 141.7138242, 528.95, '336ceb6169799cf9c00b4953e0d91d14c88fc747', 38.45, 11.847, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '28', null, '2024-05-16 18:51:18', 41.057857, 23.6514405, 2494.25, '4c3be96125689362db9b28a7bf57784dbf705e37', 34.01, 72.687, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '44', null, '2023-12-12 16:28:18', 16.982797, 121.7837044, 379.5, 'bd5b71cd60f15dc64303193fcc3d8604c834fe7c', 3.79, 112.047, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '32', null, '2024-05-28 04:14:04', -8.557437, 114.0369075, 5619.0, '8eea15556b65d462e2ed623a843364f7cdb98baf', 27.89, 8.065, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '26', null, '2023-09-07 09:35:25', 20.448773, 121.9685567, 3912.51, '13328b7b91a1397b2924425df290bb285890e0c8', -0.54, 46.238, 0.2);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '45', null, '2024-02-02 21:21:19', 8.0120727, 4.8987523, 5026.93, 'da22945aa7705b1637bf938ac546422cd5e8da5f', 3.2, 139.703, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '39', null, '2024-03-14 22:25:36', -6.3385652, 106.9447146, 357.45, '769b80b9ca45997e237b1878fe2355a3ad1bf951', 37.72, 146.953, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '7', null, '2023-10-19 16:16:07', 56.2807392, 14.5530718, 712.13, '96fa183c45b4e3a7249b1bd93ee22b03479306ba', 18.16, 171.61, 0.6);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '8', null, '2024-01-24 21:39:03', 52.6244001, 20.3835279, 5539.11, '99748a8d6c8e3e83a58a3a419a3feb01176be5de', -3.66, 142.826, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '31', null, '2024-01-15 03:32:57', 48.8276508, 1.9697936, 5658.65, 'a5a3755d5cdad23c5cb8568b881116db2e403f04', 34.45, 205.719, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '3', null, '2024-04-24 10:57:16', 60.71418, 29.95525, 4028.48, '440a2282f696c0129f249f2a6167f2a8b8e5b14a', 29.83, 135.628, 0.65);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '15', null, '2023-11-12 02:25:49', 20.4593254, 94.8779969, 1662.69, '24b60bcec378e8f1719cd05ec24c295543d043e0', -2.94, 127.72, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '13', null, '2024-04-25 18:51:25', 30.6847903, 71.7511913, 3295.64, '29291acac65251e23f18be159a745610c754be98', 34.85, 206.729, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '22', null, '2023-10-17 19:44:43', 49.2908708, 15.4833007, 1276.38, '7cef10499fe7d0cc9c371daf4722484d693e0643', 21.4, 133.114, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '33', null, '2023-12-24 13:53:10', 33.7684556, -118.2022212, 3320.51, '8ab18ea5692233bffb044d278eba0235c9bba4e7', 10.14, 90.844, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '29', null, '2023-10-18 22:42:14', -35.1164987, -71.2829759, 691.93, '721e9fac2d10013a3dce9826d1f027e9e4f7c7ab', -5.24, 119.59, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '23', null, '2023-07-15 21:26:51', 39.0483943, 139.8738552, 4762.92, '08a43b879ce871734c21150bf3ff3defb8179990', -0.16, 156.315, 0.25);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '12', null, '2023-09-10 19:44:11', 32.627137, 119.257096, 4197.78, '4f784f36fcb0ed6ad32346ffb2246b866cf5e7eb', 31.28, 233.524, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '14', null, '2024-04-28 15:04:38', 33.5668566, -83.477106, 5580.77, '13c0c790ae54ed47426754f34490c206669f4a87', -3.66, 106.656, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '43', null, '2023-11-20 09:59:39', 48.4373686, -123.4112839, 5205.53, '7b5e361059ae1b8d83e59e7a4cc4b1f27c889ccf', 3.07, 88.37, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '48', null, '2024-04-25 10:24:14', -7.8225778, 110.3843618, 1664.25, '0f84ee9c9d95916a378d85f3f50c34f8e64ba083', 23.21, 173.931, 0.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '47', null, '2024-02-21 20:39:58', 36.23154, 40.77214, 5121.0, 'e43d4b7d18ae036b8ca560aea214fbb4eba98a48', 25.23, 5.999, 0.68);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '38', null, '2024-06-06 10:05:25', 39.822507, 109.963338, 2706.9, '5d5d784216e2a45e4edcab5e60eae4d1b47654ee', 7.8, 238.643, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '41', null, '2023-08-15 07:06:17', 58.276821, 12.3176309, 3284.49, 'f2a5623df9aca72251e078f4c68c7fbc59898357', 12.56, 244.424, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '27', null, '2023-12-23 07:07:33', 47.3845072, 34.9321089, 1078.33, '0003df10c50c328d590f5703d20d39f49054b2d7', 6.3, 174.318, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '11', null, '2023-08-02 15:26:15', 41.0285386, 72.7392711, 3197.08, null, 37.08, 201.661, 0.03);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '42', null, '2024-01-24 08:42:18', 59.2264863, 18.2509127, 4506.88, '90dcd7b9235a8f53b5d0c15a9a8ffb32d753c71e', 29.68, 56.805, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '17', null, '2023-07-18 03:38:18', 12.1359226, 10.5380494, 5321.35, '8b395bb404361d5aa3dcc7be4d5f8e918a90a3ba', 38.51, 159.762, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '6', null, '2024-02-12 17:49:36', 23.696329, 117.433977, 1775.95, 'f8587d2d0abc454647d7d6dc4c1bd699d543e4ae', 19.88, 197.419, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '9', null, '2024-01-20 21:47:30', -7.5002292, 107.9739244, 4140.32, 'b83ea383f4764a1e0f63e6805b2837e7f0ef360f', 34.33, 155.182, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '34', null, '2024-04-22 11:29:21', 25.6218514, 51.0835811, 5165.59, '5198a3cb256f56c9be5b384e869653c479999fc8', 17.94, 234.859, 0.93);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '36', null, '2024-02-20 04:43:05', 47.5173564, 42.1602043, 2886.26, 'f5eca2c80bdf4ae83dfa6476dd471445a5c058b9', 26.62, 241.236, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '1', null, '2024-02-28 19:59:44', 34.0899029, 131.3980655, 2994.37, '7b713455418c219bcc73b06a9cd37438ec6a568d', -2.76, 84.053, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '5', null, '2023-08-28 13:28:15', 40.0896078, -7.0929707, 2057.17, '83df2a38ddf3830b86d4b9061855ff5832daf7c7', -0.37, 209.033, 0.64);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '10', null, '2023-09-07 01:15:49', -7.150975, 110.1402594, 4614.31, '96cdb4bece8d7c4118ccd5c1f57d70d89b358539', 15.9, 198.728, 0.75);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '25', null, '2023-11-14 05:16:45', 49.9365011, 18.2190463, 692.83, null, 21.08, null, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '8', null, '2023-09-25 11:03:23', 31.275819, 121.499653, 4442.47, 'a511d95ba2055bb4935a0bc955d61dce2ac19ad7', 9.75, 43.259, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '10', null, '2023-07-06 15:10:16', 48.635763, 124.7681779, 2322.46, null, 17.65, 51.324, 0.38);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '4', null, '2024-05-01 07:01:20', -38.9615131, -68.103824, 3551.39, 'e4a61d8c3d75ac1ccd4873bf4deedc919dda6040', 16.31, 115.813, 0.15);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '21', null, '2024-05-23 10:56:54', 38.5301118, 68.2146857, 548.64, null, -4.03, 120.552, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '17', null, '2024-02-13 06:24:48', 41.8062766, -87.6482474, 3598.3, 'b8933fc226eea4f7a8be18bc253554fb1582552d', -5.15, null, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '30', null, '2023-08-27 08:08:31', 34.5925622, -117.8194197, 1047.76, 'ceca7fe2758ebffd0166a27d8e254e55ffe73eba', 38.14, 239.244, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '5', null, '2024-04-06 10:58:50', 13.71216, 45.30318, 5736.8, '3794cb7b18256b68194a9bbbf949c94ade6c5384', 26.53, 70.471, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '45', null, '2024-05-01 23:01:22', 41.6252602, 48.6763991, 5920.46, '6d83652f5dcdaf388461260f4acad8cfc426aa29', -8.01, 53.529, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '29', null, '2024-02-26 06:30:51', 31.172739, 115.008163, 1391.07, '3dee23e5a8d1c29c0cb59c79f617a8276e3f9341', 28.04, 222.946, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '18', null, '2024-06-08 02:10:40', 31.264698, 110.839164, 1575.07, 'dfcab388f2224c568911ae74b530fe6500514027', 6.91, 22.352, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '50', null, '2023-11-14 05:40:29', 36.757714, -4.2429565, 3251.02, 'ff3fd4d2dacfe9ba8f1c64fffadb398638e03c50', 26.14, 73.652, 0.41);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '19', null, '2023-11-20 01:19:14', 43.7041519, 43.3264539, 2747.84, 'a18f7a50bb83f48035ae56aa8375d59ccedfe1e0', 18.46, 58.518, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '26', null, '2024-01-11 21:09:35', 25.332842, 118.732669, 5469.16, 'f773869556086fc21cbb6dc8591ca9fb37b43fc3', 33.96, 41.285, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '31', null, '2023-08-06 03:08:52', 44.055922, 85.38086, 4516.61, null, 38.17, 239.762, 0.45);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '3', null, '2023-06-19 12:25:44', 34.395562, 113.740529, 1772.34, '2ef556ce31eed70d59d2eb2af9a916282a674703', 25.56, 9.878, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '33', null, '2024-01-18 14:43:06', 14.8974128, 121.0253575, 5898.67, '66f31df8a1c327c85158f1225e320ca401d2c70e', 7.39, 216.225, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '44', null, '2024-06-13 21:39:29', 0.565435, 108.9272, 5569.44, 'b50a36c8f3cfdc227cfd70650f430981ad190550', 0.05, 232.836, 0.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '48', null, '2023-10-26 10:09:23', -8.584571, 116.1245642, 4127.36, 'facf646566779c108ae0e90afbfe158534d1bb66', 19.16, 223.901, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '43', null, '2023-10-21 23:03:23', 29.341703, 110.085494, 4130.14, '61b9f361554131823286265bed86349234f11ded', 0.82, 13.943, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '35', null, '2023-11-11 11:01:17', 45.805566, -77.0941047, 4152.11, 'cdf3b48b0448e8fa7be55986a124f91cb301619f', -6.82, 9.316, 0.19);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '47', null, '2023-07-09 05:39:31', 54.5782648, 48.0835847, 2995.16, 'b7fc1860616caa48218d3fcd4894a341eccbb7bc', 20.96, 49.17, 0.23);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '15', null, '2024-02-04 22:41:57', 31.476202, 92.051239, 3271.68, 'bbc7df6b0e12de7025166cdafcba6f4c3f2252b8', -8.23, 150.975, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '41', null, '2023-12-11 03:36:11', 12.8603014, 101.5361726, 4945.36, '14c2e88ac00fbdf097b5b0cf1605e772b3efd329', 28.98, 53.846, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '46', null, '2024-01-16 10:19:39', -7.740099, -40.2884386, 5670.64, '017c95545d68e2d4976308f494363356bd959e04', 0.18, 115.574, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '14', null, '2023-12-19 09:05:44', 14.86876, 120.8294888, 4286.22, '621f81bbcf404f02fde23b2f49f5fc6bb96bc9eb', 39.7, 251.217, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '20', null, '2023-10-30 16:53:35', -2.7389977, -78.8458135, 5784.01, '3862ee6ec61c5bb5af7241af95aba5167ef9cc00', 6.87, 201.48, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '22', null, '2024-01-17 02:55:55', 27.1783117, 31.1859257, 3632.11, '4e14eb33cc53d616a3ecee4ff9c1d37e9fe7c4d6', 5.36, 135.228, 0.15);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '40', null, '2023-07-16 17:10:11', 40.417358, 117.500558, 3543.46, '983ef796798fd3c4eba2687c43248cd7a43e17c4', -1.09, null, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '13', null, '2024-04-04 14:43:16', -32.9413658, -60.652833, 3333.26, 'c71a1338c98f889d9535728d5f3e6b5f600313d0', 27.06, 165.535, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '37', null, '2024-01-04 15:14:08', -8.3187176, 114.2524236, 4326.81, '68dd91e2cdbd32aaca44092a4ffa650ad661e711', -3.19, 86.64, 0.56);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '23', null, '2024-04-03 22:01:36', 34.620202, 112.453926, 5100.21, '0fa6d0ff96fab80ac974514f92374f447d8081bc', 8.29, 195.03, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '6', null, '2023-11-04 17:39:34', -17.6929945, -42.5172107, 5494.85, '62aa36316541508b837108bfaebca047578a0cca', 10.87, 110.662, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '12', null, '2023-10-17 22:36:10', 54.5156, 28.9587, 4009.79, '51bb614d35fc717291ef67c4892704b66c926f00', 20.9, 93.424, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '34', null, '2023-11-26 23:15:55', 6.3833462, -75.5858886, 4337.03, 'd04225f1c00652e059fd1b43b69e6b401d4fd4b6', 12.76, 193.824, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '49', null, '2023-07-09 11:03:37', 30.859012, 113.979421, 4477.57, '6ab225ef6f68229f6f1ab977431d59ba3eaa5128', 35.5, 184.236, 0.54);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '24', null, '2023-12-08 21:50:47', 11.1490559, 123.9914417, 2260.47, '216cadcb67051c71c48a60f58fe9a4b639adf5cf', 3.89, 111.303, 0.35);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '11', null, '2023-10-01 13:28:19', 31.207378, 121.4174914, 5470.53, 'b850291659ebbeb7d0ed85a078cf06aa882b7a08', 11.61, 219.176, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '27', null, '2024-03-13 00:54:10', -6.6111441, 106.8473377, 5772.59, 'df1b765bf240793a8474f3461e398b6d3158edf8', 37.24, 46.078, 1.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '16', null, '2023-11-06 15:36:38', 40.753655, 111.673881, 4053.83, '9e000fb196c8d07042c15c1905d4e3cbef4f5caa', 6.98, null, 0.08);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '36', null, '2024-02-22 17:40:15', 33.1212187, 131.5637393, 256.32, 'd2f2391bc6ddeb611147fbd471d390b81a8e7804', 32.33, 205.759, 0.98);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '7', null, '2023-10-13 17:29:50', -26.7162431, 23.9253941, 2065.24, 'b3fbbf5774d9f05d75e09209988a671ccf7c4e54', 29.78, 51.764, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '38', null, '2023-06-23 06:57:35', 31.5909061, 120.4927974, 1271.06, '49187bb6e58007bfe6815c18a6dc919ce2b1992c', 4.92, 126.532, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '9', null, '2024-05-20 02:58:50', 34.7671945, 119.0790302, 570.14, '44946f4d50a0287301c00b4ed28756333357d95f', 7.06, 139.469, 0.8);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '39', null, '2023-07-09 12:18:28', 52.2163528, 61.2809373, 864.62, '0e1930728159e2e703136cf3e35f90a2e64651af', 20.47, 92.478, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '28', null, '2023-07-21 15:11:34', 11.1490559, 123.9914417, 3009.29, 'af03c1da38a1528954308ae05d7c993a2be29e55', 21.53, 134.915, 0.95);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '2', null, '2024-01-30 08:26:28', 53.3797233, 49.5564219, 959.89, '9572c864222c6c58dccd8e3ead723f72d88675f5', -0.69, 73.021, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '42', null, '2023-06-29 12:45:53', 21.8756188, -102.2848729, 3510.72, 'ed96c0060c3a7bee381a0d6795860fe421e91a3f', 31.4, 229.197, 0.63);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '1', null, '2024-03-18 19:42:21', 28.159141, 115.771093, 3213.01, '20c9a428ba0d593898e8bb5fc2bb888a00a47438', null, 78.472, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '32', null, '2024-02-17 19:40:02', 34.273409, 109.064671, 3180.52, '95960c505773744ed900f8d7be2df73bb638dcea', 20.81, 208.575, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '34', null, '2024-05-30 01:17:08', 49.8474618, 19.1473808, 5913.84, '5da02e162d216dd54b47654506289d5d509db4b2', null, 169.236, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '13', null, '2023-10-23 03:31:26', 50.4065746, 14.044039, 1727.62, 'daea01d7050bed0ac33015c4872b925259686735', 25.31, 109.734, 0.84);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '1', null, '2023-08-22 09:22:16', 28.91667, 30.85, 2126.48, 'c1e31aca73fd98efa5a4040fa9f38aa58981b75a', 30.81, 166.766, 0.69);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '18', null, '2024-02-19 00:06:31', -7.302664, 112.7330892, 4980.27, 'c7b34213eaebc89f6c68da4b4f1ce1da2f59d218', 28.06, 211.921, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '5', null, '2023-12-13 04:02:29', 30.400907, 111.81127, 5025.94, 'be827816b72021d758c4121022314a5b4c8ed404', -4.59, 61.702, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '26', null, '2023-09-25 09:26:27', 45.0206335, 37.5017499, 3280.64, '20b73d1caf464c44502b4236df62342f283886cb', 14.64, 196.17, 0.93);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '4', null, '2024-05-10 17:35:30', 41.4904044, 2.0776887, 5253.31, '392c8e78931c6afbdc56abbccc08945cec50e677', null, 63.757, 0.82);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '8', null, '2024-01-09 06:26:48', 38.5, -92.15, 3015.66, 'fda1ccb8f3ff68a996c28d16882f13146b91222a', 18.8, 171.728, 0.29);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '2', null, '2023-11-14 08:45:35', -27.0501654, -55.5746294, 189.6, '4f3697b8069369bf243231ec3d3eaaa0fbdf3b8e', 2.63, 92.811, 0.04);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '37', null, '2024-02-28 08:36:15', 18.8478608, -99.1843676, 5546.51, 'e16fa6b73b9e0864559170d38c7bbc63bbd0b764', 10.16, 15.321, 0.9);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '27', null, '2024-02-29 20:14:48', 52.4555293, 13.339803, 2719.52, '7449d2bfbc2ca16db428339c8c7f0b61a2429f31', 8.76, 25.846, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '19', null, '2023-10-28 23:16:23', 40.533557, 19.5954894, 4068.39, null, 23.58, 93.754, 0.87);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '28', null, '2024-04-08 07:24:03', -6.6572023, 106.7057733, 3404.5, '1db7b9adabfdf4448a7c4ab77dc1cf1bb7d07256', 32.57, 225.197, 0.05);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '48', null, '2024-04-15 03:25:02', 53.1844724, 18.6045572, 3068.39, '0800c829816e6e76a37b11624e33361c391ac7e0', 10.65, 235.306, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '43', null, '2023-10-30 06:10:31', 35.9411947, 139.3061655, 2795.13, '16d606140cb78a8a4fdc83a2cf0aebde2b02351b', -9.56, 50.682, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '49', null, '2023-08-18 00:42:56', 31.1655344, 121.6793537, 1534.26, 'cbc686a177382726fe2846e9a9dfb46472c003c8', 33.5, 195.073, 0.5);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '23', null, '2023-09-22 07:22:37', 43.3293419, 5.3835222, 1998.14, '505ec74c89c5f3bfb4a3028fe347adfa34c74153', 30.49, null, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '9', null, '2024-04-18 16:56:38', 39.309746, 115.958784, 5570.36, '61b30e03434d51fecf89f1a8d2396ae2aa894c41', 13.65, 196.858, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '41', null, '2023-07-16 21:15:46', 39.2126147, -9.2845234, 1640.71, '9a237f74146391cb1961efb986e7927a9c8960b9', 14.17, 61.946, 0.36);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '32', null, '2023-12-23 16:55:40', -6.8128491, 107.5087328, 4747.5, '72609dfdf0c7fa4023f9d9b8ee3e6eb1d3ad8a10', 5.17, 232.386, 0.97);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '39', null, '2023-06-17 10:09:42', -15.6903468, -39.1127352, 42.08, '4108b619dba7889a4f63caccf852a7e0e14c198a', 5.63, 125.761, 0.55);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '12', null, '2023-11-18 08:03:41', 46.9758047, 128.0462031, 2646.41, '1796d5bf6bbf7688be33674e1bd2b224a89c1b69', 30.28, 43.325, 0.71);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '17', null, '2024-04-15 06:47:00', 17.9309007, 103.1279039, 3180.51, '4042d85a4d5f6f57776710273dae3a4c6072af0c', -8.95, 197.57, 0.43);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '11', null, '2023-08-16 12:03:14', -7.2348751, 107.5564326, 3917.12, 'a84a545fec07eab74179f45e49f84a51ea45d0e1', 28.08, 33.42, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '21', null, '2023-10-13 15:49:39', -7.3305972, 108.7422767, 3995.42, '2d662309d1af3a9a4d709801825debec9af28f14', -4.88, 106.421, 0.3);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '30', null, '2023-09-27 14:22:21', -17.3410721, -44.9449465, 4006.17, '4d39879b6b4a6216e6fec1e237c3c4f65ca24578', 15.57, 59.43, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '7', null, '2023-11-24 17:35:06', 49.4603474, 8.402137, 4061.89, '099df1d2d424642de1754210d74d1296b2fd9c90', 26.18, 90.416, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '15', null, '2023-10-20 19:27:29', -34.6787774, -58.6694618, 5368.11, '2ab0345a0b36a03eb6810aa96b31a8d7c67bda3a', -2.38, 89.209, 0.4);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '22', null, '2023-07-05 08:45:01', -7.783297, 110.363649, 459.27, '67830028b034dab901416c7166f739ec3cd0867b', -8.17, 128.741, 0.11);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '16', null, '2023-10-11 04:59:19', 35.1612182, -5.2632201, 321.34, '64bf9779ca39470fa7b48f3e8ca23cdf61d3f060', 35.8, 208.19, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '24', null, '2023-11-28 20:44:37', 14.4670027, 47.2752844, 4879.05, 'ef540eb0f7fe6871a9e365daf0d81bff233eab01', 39.52, 97.61, 0.92);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '3', null, '2023-09-26 14:31:37', -7.7798092, 110.3562018, 3912.47, '6ed48d8f4d35d3e12f64f2d613a838f326483602', 30.83, 32.36, 0.67);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '47', null, '2024-06-02 12:04:15', 11.0002604, 122.740723, 2334.74, 'fb0ce640cbf1b3a58fc3ce4f512f633acb2285ad', -3.94, 137.512, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '35', null, '2024-05-15 13:48:38', 47.1427431, -122.4407344, 3735.19, '9b6c6dd7a9a85e8d8093da81db0866b2338bb721', 1.76, 65.362, 0.58);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '42', null, '2024-05-23 10:20:10', 31.4175388, 31.8144434, 1732.65, 'b412e89dfda04c58d45d61a77e9fa56eb5720437', 5.6, 154.406, 0.12);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '44', null, '2024-01-21 13:45:59', -34.990888, 138.574391, 3305.49, 'efbefa220d274790356f628cabfbce98316b8acb', 11.12, 100.815, 0.34);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '25', null, '2023-07-19 20:16:49', 38.3559764, 140.3748668, 2370.18, '9d83aa4da84bdd06429cd81109172e8784d34f6e', 6.11, 97.817, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '33', null, '2024-05-06 12:24:50', 45.1099574, 40.2950699, 5337.01, '872a3379dede7784d1123a30d16bb81f899a2020', 28.8, 75.489, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '45', null, '2024-04-17 15:47:29', 59.2648646, 15.2289108, 3465.95, '8e9d1c3b1df0f45a43de292152d8089861e2824a', 35.64, 61.694, 0.04);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '10', null, '2024-02-27 15:17:16', 32.768821, 120.679703, 2305.59, '3857ca1f92a485997439030c2c6a02f5995fd2ab', 21.1, null, 0.94);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '38', null, '2023-08-11 14:00:58', 49.2121445, 37.2665006, 1320.34, '9d3e2d83dba624faf3790880412e67a7b66c8458', 32.41, 112.064, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '46', null, '2024-01-06 18:55:26', 36.0917434, 140.1139616, 448.01, 'a7e1e6b77044efd89bdaf7a39a4ced5f40d612f1', -9.17, 250.766, 0.16);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '29', null, '2024-02-22 05:15:57', 41.764115, 86.145298, 5115.13, 'c5242d91dbc100d078b0c46463e807d64fdeafd8', 12.03, 232.838, 0.33);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '50', null, '2024-02-07 09:54:45', 29.2964866, 48.079379, 5296.72, 'e59d0453818eb5ebdc53e1263b7747914012ba7e', 26.24, 22.81, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '14', null, '2024-02-04 13:40:14', 58.7859889, 25.4275605, 5654.28, '4a17328109da521033a3bdd99bb3ad515d561d6d', -6.56, 238.999, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '6', null, '2024-06-04 11:10:58', -7.0448067, 109.1474718, 1811.25, '5befadc276420add93221b29c5ae88d37316460a', 22.61, 154.629, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '31', null, '2023-11-18 20:26:24', 50.4703083, 17.3392829, 1257.3, '3613fb0089d3b33f0d9e0e4ab77397dd34a4d035', 14.24, 49.57, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '36', null, '2023-08-14 17:38:00', 59.2643041, 18.0399695, 675.14, '533c40663fc2b58b58c64713a80bf25b4989683e', 29.84, 28.956, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '20', null, '2024-01-19 15:04:25', 48.3245206, 35.9379288, 5336.03, '803df825ac3817e43d8451208111a82c9ba9ba2a', 18.22, 56.732, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '40', null, '2023-12-12 23:51:47', 46.7976469, 16.233744, 497.79, 'a0144f9a4a96c9ee331420a06f994727538a7e5c', 34.32, 228.732, 0.18);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '2', null, '2023-10-17 09:11:00', 48.627474, 2.5921846, 3828.28, '386e9b83efb846eb2a6ebdd2ff6a25a1520eaf2f', 6.02, 231.583, 0.57);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '45', null, '2024-02-03 15:39:23', 52.4801084, 48.2090292, 5863.24, '940718e2f80a5b83744c4f5e2773ac25982fdb2a', 8.57, 221.411, 0.51);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '48', null, '2024-04-03 17:36:15', 39.0063718, 117.6852235, 5924.3, '5eb86b09119a7575f22eff07afdcc95ec4942d72', -0.4, 83.0, 0.49);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '3', null, '2024-04-19 18:58:57', 28.0955558, 112.9937015, 5142.34, '0af9633204f81792f5e505f2d8a51f45cfe270c8', 8.41, 10.09, 0.24);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '39', null, '2024-02-14 15:42:02', 13.533238, -15.412011, 323.4, '9efe5d73fc3db33aa513b2994f41621ceb7bda42', 26.47, 157.682, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '8', null, '2023-06-15 12:20:16', 29.5692083, 50.5239096, 3627.21, '07f2a5d50ab4f22a45a83bd7ec3877b87d36b828', 3.23, 66.132, 0.28);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '17', null, '2024-03-12 16:30:04', 39.7164885, -77.7312977, 316.73, '691af1d21b612c7a14f89e1972db43d67d1823af', 13.11, 105.14, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '36', null, '2023-08-12 16:59:32', 12.8074809, 122.0553349, 1116.59, '32fc860ed2dc2baf8fdf83cc4f7144f3fb6ed4d3', 16.91, 94.372, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '35', null, '2023-12-10 11:41:07', -34.493672, -58.5854528, 4831.01, '3224a90e463c8ddcd4b8b7e9b60b2d3dd214246d', -0.66, 130.853, 0.06);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '1', null, '2024-04-09 16:35:53', -7.9794517, 112.0416754, 321.21, 'f5b0dec1a45dd84589dc8860461aaa7ba749697c', 10.03, 61.634, 0.44);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '15', null, '2023-10-15 03:02:29', 48.7499009, 2.3825213, 5627.94, '19039141371e4d7005ce759a952a88d2328ef798', 4.63, 211.319, 0.72);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '26', null, '2023-10-01 19:14:19', 13.4734999, 122.6157793, 20.26, '5181cd4c23294f62baad2c5d1e3f330fd2a35a14', 38.29, 122.316, 0.73);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '50', null, '2024-02-11 16:41:32', 29.8601155, 69.1823141, 2851.59, '806067ce74b7afbc4a4cf510d2a7a9a44e9be8a4', 9.04, 64.329, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '46', null, '2023-10-09 00:26:11', 7.1864095, 100.5927222, 807.88, '86844103b13fccc3d13d5e897655adc96957eaf9', 12.17, 23.611, 0.79);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '13', null, '2023-08-03 03:27:30', 41.9575515, 101.0602341, 4762.66, '536346dba8e3dfa34d38aead195fd2d22af79d0d', 23.1, 112.147, 0.88);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '38', null, '2023-07-03 18:57:10', 59.9251489, 30.317148, 1724.14, 'f2dfedb26721f6a453a8529a3fef9d8d26cd2d3e', 3.78, 44.745, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '30', null, '2024-03-14 16:02:07', -7.766758, 110.289646, 3291.15, '3be983402a7e434ef323517330298393c8a0dd64', -3.28, 22.646, 0.31);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '7', null, '2023-07-16 07:26:30', 6.1307505, -75.6033497, 1935.02, '5b653b0a89a7769c97e9a2b23ea681aa0e1b5a91', 39.24, 116.163, 0.81);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '19', null, '2024-03-20 11:49:19', 38.9951183, 139.9228567, 5542.91, '398085d1bec71410e2874ee7034ea1acd36a313c', 33.83, 147.406, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '43', null, '2024-03-14 14:03:43', 58.2760382, 34.1125526, 3750.39, '2e1f258fdc26b34127db4aed311b0158d84d56c1', null, 253.596, 0.32);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '10', null, '2023-09-02 05:45:44', -22.6700589, 27.225321, 3831.35, '54f3d294578dea75b5c6ed872705da15313eacb4', 37.7, 149.96, 0.89);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '42', null, '2024-02-29 19:37:56', 41.6865621, -8.7534535, 3503.72, '58b19accd3b494a7b92851b3b04674dd6db66e3a', 3.03, 105.888, 0.7);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '34', null, '2023-11-23 10:20:51', 31.540397, 118.486745, 5917.63, '721e8aaf45fb098189ad93790d013e8768ef3770', 31.7, 90.573, 0.74);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '29', null, '2023-09-16 21:37:25', 48.7192002, 32.6770961, 1446.49, '4a9bb493f9b45949fdbca45f2861f5e44a400896', 16.96, 19.836, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '27', null, '2023-10-04 03:50:20', 34.1228075, 134.5990156, 5071.21, '05b75d5422ea27e52253cd7b5e77ba4bbd637def', 10.96, 65.503, 0.48);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('19', '25', null, '2024-01-16 06:12:08', -8.5403989, 115.2027279, 5684.31, '67ff4423d531e4a37ccea23a1d9fc54fa2c0c365', 38.49, 61.767, 0.53);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('21', '47', null, '2023-10-21 18:21:50', -8.1966, 111.611, 1364.09, '9fed9d4d4de81f9c65c197ccd560de60645d6a1e', 17.54, 21.066, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('16', '12', null, '2023-10-27 04:21:16', 27.95793, 109.589666, 1237.7, '7145a603490a84b6cf91c4bceba943d57998ca8c', 34.65, 211.066, 0.14);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('15', '49', null, '2024-03-22 16:29:45', 8.1087597, -11.8478324, 708.57, '4aecbaf87111fb2c857cdca82bae3198e2750789', 8.28, 254.997, 0.13);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('8', '41', null, '2023-09-21 05:09:54', -8.2794, 113.4073, 5198.93, '493fd5cd936ce00ae3766300797711606838191e', 8.22, 207.017, 0.77);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('11', '31', null, '2023-06-27 03:22:46', 34.2469767, 37.0561339, 5004.43, '2b00be0d1a045450c5fcb65501cffca68a3fa717', 14.22, 55.942, 0.07);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('25', '5', null, '2024-02-05 23:55:00', 9.8539292, -84.0911821, 4095.76, 'bddefd585d5371317168cd293539577be027ff5c', 10.74, 214.512, 0.66);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('4', '11', null, '2023-08-20 15:44:51', -8.0090935, 113.8436013, 2362.23, '7ec56734b71a86c1c73ed615b6c5fe23b69e26f8', 5.65, 46.287, 0.62);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('22', '32', null, '2024-05-20 16:31:33', 10.379923, -74.881979, 681.25, 'c3701a18f10f070577f270e020d1f0dc27384cbf', 30.08, 22.044, 0.86);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('13', '24', null, '2024-05-25 09:35:08', 44.9811213, 20.0818204, 3688.9, '5382163d368d83b8122136b1a75c6ddbbdddf321', 24.25, 222.734, 0.1);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('2', '4', null, '2024-02-09 16:33:59', 13.5213331, 120.9787095, 1219.86, 'f3e9e25b3abc686aa521ad265e6e2f1c6aaf3444', 25.89, 11.521, 0.76);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('3', '37', null, '2023-08-27 03:28:32', 5.5775857, 153.5799639, 3144.1, 'fc15dcbefd97c1609adcb3376a85c449b24a3a7a', 39.62, 224.678, 0.42);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('10', '16', null, '2023-12-04 14:11:55', 30.199688, 110.674706, 184.09, '7df3573c77515ce5b247a8cdee615c8389f242c2', 39.08, 22.564, 1.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('20', '40', null, '2023-09-21 03:50:34', -6.1583904, 106.4288088, 758.7, '3dee2b31e8eb087f7b8cca42a2bfb62def2f825d', 9.96, 130.082, 0.78);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('6', '22', null, '2023-11-27 16:51:16', 25.941937, 117.365052, 3082.27, '339ecb4a6463b8f700e3bfbaa89baef1d461918a', 27.58, 182.155, 0.09);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('12', '20', null, '2023-12-18 17:58:56', 41.3336366, -8.5749394, 3265.27, '177a776033b8f3e802f1923c1ad582aa11e7f997', 6.44, 198.299, 0.71);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('9', '6', null, '2024-04-29 14:53:50', -7.1610471, 111.5975081, 2544.36, 'e097d51bd667e63164315e9690a6540b12aea012', 9.15, 169.866, 0.85);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('7', '23', null, '2024-06-12 18:29:45', 49.0096906, 2.5479245, 2307.12, '3eec073e13cf98b10cde3fdceb8203e0ad4309e7', 21.27, 121.869, 0.91);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('24', '33', null, '2024-03-12 00:44:37', 40.078872, -82.9447782, 56.84, '4d7b61f5c1ebfd68ddfe47d7c7137f69a3b228ad', 31.0, 30.852, 1.0);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('5', '9', null, '2024-01-29 20:50:51', 6.9787414, 79.9310946, 4808.96, 'ff3827ec4afdd8cff7b8ea7da1c375a9acb50e54', 23.55, 20.479, null);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('23', '21', null, '2023-07-08 13:18:56', 23.021478, 113.121435, 3397.59, '50d072ce9ac482ba4be753797be3ec899f0cb33e', 0.08, 195.55, 0.27);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('17', '28', null, '2024-05-07 21:58:55', -7.2114552, 112.7450068, 3337.27, '459eb8f35c17e8e4f66cef71f1327cf355548ede', 27.95, 19.421, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('1', '18', null, '2023-10-14 18:06:01', 20.5800358, -75.2435307, 348.92, '1c669c0a93fa58d3797039d72ca65497f0721a4c', 1.34, 232.824, 0.47);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('14', '14', null, '2024-05-19 03:57:33', 46.798163, 134.013872, 2276.75, 'eb1e5afce9edf229b38bfd56c10692f7b59aa3ad', -2.87, 98.086, 0.83);
insert into ZoneData (ZoneID, DataScoopID, OwningSubscriptionID, recordTime, latitude, longitude, altitude, spectralData, temperature, ambientLight, humidity) values ('18', '44', null, '2023-12-21 12:50:50', 27.69417, 109.73583, 2729.57, 'e5f59ae8f774f2886e16ab40f4ff46ab4caa8195', -8.18, 135.939, 0.86);

-- SELECT * FROM ZoneData;

-- SubscriptionType
-- Data generated with Mockaroo
insert into SubscriptionType (SubscriptionName, price, subscriptionDescription) values ('Standard', 3033.82, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into SubscriptionType (SubscriptionName, price, subscriptionDescription) values ('Gold', 904.01, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into SubscriptionType (SubscriptionName, price, subscriptionDescription) values ('Platinum', 7514.40, 'In congue. Etiam justo. Etiam pretium iaculis justo.In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into SubscriptionType (SubscriptionName, price, subscriptionDescription) values ('SuperPlatinum', 7185.36, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');

-- SELECT * FROM SubscriptionType;

-- Subscription
-- Data generated with Mockaroo
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (1, 'Gold', '13', '5', '184', null, 0.59, '2023-07-07 20:09:04', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (2, 'SuperPlatinum', '23', '2', '120', null, 0.67, '2025-03-12 02:31:57', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (3, 'Standard', '32', '3', '4', 12, null, '2024-02-01 05:58:23', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (4, 'Gold', '31', '20', '127', 12, 0.91, '2024-02-25 01:31:27', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (5, 'Standard', '39', '4', '119', 11, 0.05, '2024-02-17 20:58:25', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (6, 'Standard', '35', '6', '12', 10, 0.47, '2025-05-16 17:15:53', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (7, 'Standard', '25', '18', '175', null, 0.93, '2024-01-19 19:49:43', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (8, 'Gold', '6', '17', '131', 11, null, '2024-07-04 05:52:42', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (9, 'Gold', '22', '16', '116', 12, 0.62, '2025-03-18 04:18:42', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (10, 'SuperPlatinum', '27', '1', '19', null, null, '2024-11-18 09:20:25', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (11, 'Standard', '30', '19', '65', 11, 0.11, '2024-05-14 22:31:51', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (12, 'Gold', '19', '9', '28', 10, null, '2024-10-13 14:00:14', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (13, 'Standard', '2', '12', '146', 12, 0.28, '2024-12-04 23:41:31', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (14, 'Gold', '26', '13', '6', 12, 0.53, '2025-02-26 19:34:01', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (15, 'Standard', '4', '10', '142', 12, 0.32, '2024-01-24 13:28:31', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (16, 'Standard', '29', '14', '107', null, 0.76, '2024-05-28 11:38:42', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (17, 'SuperPlatinum', '18', '8', '16', null, null, '2025-06-03 01:30:23', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (18, 'Platinum', '20', '7', '87', 11, 0.82, '2025-03-09 17:29:02', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (19, 'Gold', '40', '15', '147', null, 0.41, '2025-05-07 23:50:01', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (20, 'Standard', '28', '11', '10', 12, 0.76, '2023-06-24 05:36:06', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (21, 'Platinum', '1', '19', '60', 10, null, '2025-06-10 14:32:00', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (22, 'Gold', '11', '7', '143', 10, 0.59, '2024-02-03 16:15:09', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (23, 'Standard', '16', '10', '81', 12, null, '2025-06-08 04:48:04', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (24, 'Standard', '36', '13', '144', null, 0.21, '2024-01-21 21:56:45', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (25, 'Gold', '12', '6', '154', 12, 0.57, '2023-07-12 09:17:59', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (26, 'Platinum', '38', '4', '43', 11, 0.78, '2023-09-09 03:35:54', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (27, 'Platinum', '33', '3', '48', 11, 0.35, '2025-05-03 11:22:50', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (28, 'Platinum', '24', '8', '189', 11, 0.18, '2023-10-04 23:40:54', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (29, 'Standard', '7', '2', '100', 12, 0.04, '2023-10-09 17:57:03', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (30, 'Standard', '10', '14', '149', 11, 0.07, '2025-02-03 13:01:36', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (31, 'Platinum', '34', '12', '134', 11, 0.97, '2025-02-16 04:42:53', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (32, 'SuperPlatinum', '37', '20', '156', 10, null, '2024-07-19 20:59:41', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (33, 'Gold', '14', '5', '92', 12, null, '2025-03-06 14:06:22', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (34, 'Standard', '17', '1', '129', null, null, '2025-03-21 03:11:40', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (35, 'Platinum', '5', '16', '182', 10, null, '2025-03-31 08:50:53', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (36, 'Platinum', '15', '9', '162', 12, null, '2024-06-04 01:59:20', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (37, 'Standard', '8', '17', '117', 12, 0.87, '2024-07-20 18:57:24', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (38, 'Platinum', '3', '15', '98', null, 0.37, '2023-07-02 21:03:23', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (39, 'Standard', '9', '18', '150', 11, null, '2023-11-12 01:59:42', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (40, 'Standard', '21', '11', '44', null, 1.0, '2025-06-10 19:42:06', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (41, 'Gold', '17', '19', '63', 12, 0.35, '2025-06-11 14:39:51', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (42, 'Standard', '27', '4', '157', 10, 0.95, '2025-03-07 16:55:01', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (43, 'SuperPlatinum', '18', '3', '67', null, null, '2023-12-19 07:33:05', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (44, 'Standard', '8', '14', '196', 10, 0.09, '2024-02-15 12:54:08', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (45, 'Standard', '37', '9', '20', 12, null, '2024-03-20 04:24:34', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (46, 'Standard', '30', '2', '173', 11, 0.43, '2024-05-12 02:05:58', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (47, 'Standard', '1', '12', '115', 10, 0.96, '2024-09-28 03:44:30', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (48, 'Platinum', '21', '17', '93', null, 0.55, '2025-05-18 22:16:31', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (49, 'Standard', '4', '11', '164', 11, 0.46, '2024-12-22 09:48:51', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (50, 'Standard', '14', '10', '167', 10, 0.45, '2025-02-12 14:03:16', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (51, 'Gold', '11', '15', '97', null, 0.28, '2024-06-11 20:12:56', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (52, 'SuperPlatinum', '10', '13', '200', 12, null, '2024-01-23 08:38:09', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (53, 'Gold', '38', '18', '130', null, null, '2025-03-24 00:44:35', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (54, 'Standard', '29', '16', '85', 12, null, '2025-05-23 22:01:20', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (55, 'SuperPlatinum', '15', '1', '153', null, 0.06, '2024-07-08 19:56:11', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (56, 'Standard', '31', '7', '37', 11, null, '2024-08-02 23:14:04', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (57, 'Standard', '16', '8', '82', null, 0.17, '2024-11-05 12:28:15', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (58, 'Gold', '7', '20', '165', null, 0.78, '2024-11-20 19:53:45', 1);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (59, 'Standard', '9', '5', '96', null, 0.6, '2024-06-18 09:03:19', 0);
insert into Subscription (ID, SubscriptionType, CustomerID, ContractID, VideoStreamID, EmployeeID, discount, billingDate, recurring) values (60, 'Standard', '34', '6', '2', 12, 0.36, '2023-08-09 18:47:45', 0);

-- SELECT * FROM Subscription;

-- Gold
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (1, 1);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (4, 2);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (8, 3);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (9, 4);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (12, 5);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (14, 6);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (19, 7);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (22, 8);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (25, 9);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (33, 10);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (41, 11);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (51, 12);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (53, 13);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (58, 14);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (18, 15);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (21, 16);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (26, 17);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (27, 18);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (28, 19);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (31, 20);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (35, 21);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (36, 22);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (38, 23);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (48, 24);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (2, 25);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (10, 26);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (17, 27);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (32, 28);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (43, 29);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (52, 30);
INSERT INTO Gold (SubscriptionID, VideoStreamID) VALUES (55, 31);

-- SELECT * FROM Gold;

-- Platinum
INSERT INTO Platinum (SubscriptionID) VALUES (18);
INSERT INTO Platinum (SubscriptionID) VALUES (21);
INSERT INTO Platinum (SubscriptionID) VALUES (26);
INSERT INTO Platinum (SubscriptionID) VALUES (27);
INSERT INTO Platinum (SubscriptionID) VALUES (28);
INSERT INTO Platinum (SubscriptionID) VALUES (31);
INSERT INTO Platinum (SubscriptionID) VALUES (35);
INSERT INTO Platinum (SubscriptionID) VALUES (36);
INSERT INTO Platinum (SubscriptionID) VALUES (38);
INSERT INTO Platinum (SubscriptionID) VALUES (48);
INSERT INTO Platinum (SubscriptionID) VALUES (2);
INSERT INTO Platinum (SubscriptionID) VALUES (10);
INSERT INTO Platinum (SubscriptionID) VALUES (17);
INSERT INTO Platinum (SubscriptionID) VALUES (32);
INSERT INTO Platinum (SubscriptionID) VALUES (43);
INSERT INTO Platinum (SubscriptionID) VALUES (52);
INSERT INTO Platinum (SubscriptionID) VALUES (55);

-- SELECT * FROM Platinum;

-- SuperPlatinum
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (2);
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (10);
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (17);
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (32);
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (43);
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (52);
INSERT INTO SuperPlatinum (SubscriptionID) VALUES (55);

-- SELECT * FROM SuperPlatinum;



-- || DDL CONSTRAINTS || --

ALTER TABLE Biome
	ADD
		CONSTRAINT PK_Biome
			PRIMARY KEY (ID);

ALTER TABLE DataScoop
	ADD 
		CONSTRAINT PK_DataScoop
			PRIMARY KEY(ID),
		CONSTRAINT FK_DataScoop__Biome
			FOREIGN KEY (BiomeConfiguration) REFERENCES Biome (ID);

ALTER TABLE PartType
	ADD
		CONSTRAINT PK_PartType
			PRIMARY KEY (ID);

ALTER TABLE PartInstance
	ADD
		CONSTRAINT PK_PartInstance
			PRIMARY KEY (ID),
		CONSTRAINT FK_PartInstance__PartType
			FOREIGN KEY (PartType) REFERENCES PartType (ID);

ALTER TABLE DataScoop_PartInstance
	ADD
		CONSTRAINT PK_DataScoop_PartInstance
			PRIMARY KEY (DataScoopID, PartInstanceID, dateInstalled),
		CONSTRAINT FK_DataScoop_PartInstance__DataScoop
			FOREIGN KEY (DataScoopID) REFERENCES DataScoop (ID),
		CONSTRAINT FK_DataScoop_PartInstace__PartInstance
			FOREIGN KEY (PartInstanceID) REFERENCES PartInstance (ID);

ALTER TABLE Supplier
	ADD
		CONSTRAINT PK_Supplier
			PRIMARY KEY (ID),
		CONSTRAINT CHK_Supplier_XORNullEmailPhoneWebsite
			CHECK (phone IS NOT NULL OR email IS NOT NULL OR website IS NOT NULL);

ALTER TABLE Supplier_PartType
	ADD
		CONSTRAINT PK_Supplier_PartType
			PRIMARY KEY (PartTypeID, SupplierID),
		CONSTRAINT FK_Supplier_PartType__PartType
			FOREIGN KEY (PartTypeID) REFERENCES PartType (ID),
		CONSTRAINT FK_Supplier_PartType__Supplier
			FOREIGN KEY (SupplierID) REFERENCES Supplier (ID);

ALTER TABLE [Zone]
	ADD
		CONSTRAINT PK_Zone
			PRIMARY KEY (ID),
		CONSTRAINT FK_Zone__Biome
			FOREIGN KEY (Biome) REFERENCES Biome (ID);

ALTER TABLE VideoStream
	ADD
		CONSTRAINT PK_VideStream
			PRIMARY KEY (ID),
		CONSTRAINT FK_VideoStream__DataScoop
			FOREIGN KEY (DataScoopID) REFERENCES DataScoop (ID),
		CONSTRAINT KF_VideoStream__Zone
			FOREIGN KEY (ZoneID) REFERENCES [Zone] (ID);

ALTER TABLE ZoneData
	ADD
		CONSTRAINT FK_ZoneData__Zone
			FOREIGN KEY (ZoneID) REFERENCES [Zone] (ID),
		CONSTRAINT FK_ZoneData__DataScoop
			FOREIGN KEY (DataScoopID) REFERENCES DataScoop (ID);

ALTER TABLE PerimeterCoordinate
	ADD
		CONSTRAINT PK_PerimeterCoordinate
			PRIMARY KEY (ZoneID, coordinateNumber),
		CONSTRAINT FK_PerimiterCoordinate__Zone
			FOREIGN KEY (ZoneID) REFERENCES [Zone] (ID);

ALTER TABLE Employee
	ADD
		CONSTRAINT PK_Employee
			PRIMARY KEY (ID),
		CONSTRAINT FK_Employee__Manager
			FOREIGN KEY (Manager) REFERENCES Employee (ID);

ALTER TABLE DroneTechnician
	ADD
		CONSTRAINT PK_DroneTechnician
			PRIMARY KEY (EmployeeID),
		CONSTRAINT FK_DroneTechnicain__Employee
			FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);

ALTER TABLE DronePilot
	ADD
		CONSTRAINT PK_DronePilot
			PRIMARY KEY (EmployeeID),
		CONSTRAINT FK_DronePilot__Employee
			FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);

ALTER TABLE AdministrativeExecutive
	ADD
		CONSTRAINT PK_AdministrativeExecutive
			PRIMARY KEY (EmployeeID),
		CONSTRAINT FK_AdministrativeExecutive__Employee
			FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);

ALTER TABLE Salesperson
	ADD
		CONSTRAINT PK_Salesperson
			PRIMARY KEY (EmployeeID),
		CONSTRAINT FK_Salesperson__Employee
			FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);

ALTER TABLE [Contract]
	ADD
		CONSTRAINT PK_Contract
			PRIMARY KEY (ID),
		CONSTRAINT FK_Contract__AdministrativeExecutive
			FOREIGN KEY (EmployeeID) REFERENCES AdministrativeExecutive (EmployeeID);

ALTER TABLE Zone_Contract
	ADD
		CONSTRAINT PK_Zone_Contract
			PRIMARY KEY (ZoneID, ContractID),
		CONSTRAINT FK_Zone_Contract__Zone
			FOREIGN KEY (ZoneID) REFERENCES [Zone] (ID),
		CONSTRAINT FK_Zone_Contract__Contract
			FOREIGN KEY (ContractID) REFERENCES [Contract] (ID);

ALTER TABLE Inspection
	ADD
		CONSTRAINT PK_Inspection
			PRIMARY KEY (PartInstanceID, EmployeeID, inspectionDate),
		CONSTRAINT FK_Ispection__PartInstance
			FOREIGN KEY (PartInstanceID) REFERENCES PartInstance (ID),
		CONSTRAINT FK_Ispection__DroneTechnician
			FOREIGN KEY (EmployeeID) REFERENCES DroneTechnician (EmployeeID);

ALTER TABLE DronePilot_DataScoop_Zone
	ADD
		CONSTRAINT PK_DronePilot_DataScoop_Zone
			PRIMARY KEY (DataScoopID, EmployeeID, ZoneID),
		CONSTRAINT FK_DronePilot_DataScoop_Zone__DataScoop
			FOREIGN KEY (DataScoopID) REFERENCES DataScoop (ID),
		CONSTRAINT FK_DronePilot_DataScoop_Zone__DronePilot
			FOREIGN KEY (EmployeeID) REFERENCES DronePilot (EmployeeID),
		CONSTRAINT FK_DronePilot_DataScoop_Zone__Zone
			FOREIGN KEY (ZoneID) REFERENCES Zone (ID);

ALTER TABLE Customer
	ADD
		CONSTRAINT PK_Customer
			PRIMARY KEY (ID),
		CONSTRAINT CHK_Customer_XORNullEmailPhone
			CHECK (phone IS NOT NULL OR email IS NOT NULL);

ALTER TABLE SubscriptionType
	ADD
		CONSTRAINT PK_SubscriptionType
			PRIMARY KEY (SubscriptionName);

ALTER TABLE Subscription
	ADD
		CONSTRAINT PK_Subscription
			PRIMARY KEY (ID),
		CONSTRAINT FK_Subscription__SubscriptionType
			FOREIGN KEY (SubscriptionType) REFERENCES SubscriptionType (SubscriptionName),
		CONSTRAINT FK_Subscription__Customer
			FOREIGN KEY (CustomerID) REFERENCES Customer (ID),
		CONSTRAINT FK_Subscription__Contract
			FOREIGN KEY (ContractID) REFERENCES [Contract] (ID),
		CONSTRAINT FK_Subscription__VideoStream
			FOREIGN KEY (VideoStreamID) REFERENCES VideoStream (ID),
		CONSTRAINT FK_Subscription__Salesperson
			FOREIGN KEY (EmployeeID) REFERENCES Salesperson (EmployeeID);

ALTER TABLE Gold
	ADD
		CONSTRAINT PK_Gold
			PRIMARY KEY (SubscriptionID),
		CONSTRAINT FK_Gold__Subscription
			FOREIGN KEY (SubscriptionID) REFERENCES Subscription (ID),
		CONSTRAINT FK_Gold__VideoStream
			FOREIGN KEY (VideoStreamID) REFERENCES VideoStream (ID);

ALTER TABLE Platinum
	ADD
		CONSTRAINT PK_Platinum
			PRIMARY KEY (SubscriptionID),
		CONSTRAINT FK_Platinum__Gold
			FOREIGN KEY (SubscriptionID) REFERENCES Gold (SubscriptionID);

ALTER TABLE SuperPlatinum
	ADD
		CONSTRAINT PK_SuperPlatinum__Platinum
			PRIMARY KEY (SubscriptionID),
		CONSTRAINT FK_SuperPlatinum__Platinum
			FOREIGN KEY (SubscriptionID) REFERENCES Platinum (SubscriptionID);

ALTER TABLE [ZONE]
	ADD
		CONSTRAINT FK_Zone__SuperPlatinum
			FOREIGN KEY (OwningSubscriptionID) REFERENCES SuperPlatinum (SubscriptionID);

ALTER TABLE ZoneData
	ADD
		CONSTRAINT FK_ZoneData__Platinum
			FOREIGN KEY (OwningSubscriptionID) REFERENCES Platinum (SubscriptionID);
GO

-- || DDL Indexes || --

-- Employee
CREATE NONCLUSTERED INDEX IX_Employee_name
ON Employee(lastName, firstName);

-- Contract
CREATE NONCLUSTERED INDEX IX_Contract_contractor
ON Contract(contractor);


-- [][][][][][][][][][][][][][][][][][][][][][][][][] --


-- || Stored Procedures || --

-- Transaction A


DROP PROCEDURE IF EXISTS NewCustomerAndSubscriptionFromSalesperson;
GO

CREATE PROCEDURE NewCustomerAndSubscriptionFromSalesperson
	@SubscriptionType NVARCHAR(20),
	@ContractID INT,
	@EmployeeID INT,
	@Discount DECIMAL(3,2),
	@billingDate DATE,
	@recurring BIT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(100),
	@Phone NVARCHAR(20),
	@Email NVARCHAR(100),
	@Company NVARCHAR(100)
AS
	BEGIN TRY
		DECLARE @NextCustomerID INT;

		-- Find the next free ID number in the Customer table
		SELECT 
			@NextCustomerID = ISNULL(MAX(ID), 0) + 1 
		FROM Customer;

		-- Create new customer
		INSERT INTO Customer
		(
			ID,
			firstName,
			lastName, 
			phone, 
			email,
			company
		)
		VALUES
		(
			@NextCustomerID,
			@FirstName,
			@LastName,
			@Phone,
			@Email,
			@Company
		)

		DECLARE @NextSubscriptionID INT;

		-- Find the next free ID number in the Customer table
		SELECT 
			@NextSubscriptionID = ISNULL(MAX(ID), 0) + 1 
		FROM Subscription;

		-- Create new subscription
		INSERT INTO Subscription
		(
			ID,
			SubscriptionType,
			CustomerID,
			ContractID,
			EmployeeID,
			discount,
			billingDate,
			recurring
		)
		VALUES
		(
			@NextSubscriptionID,
			@SubscriptionType,
			@NextCustomerID,
			@ContractID,
			@EmployeeID,
			@Discount,
			@billingDate,
			@recurring
		)

		-- Display inserted data
		SELECT 
			c.ID AS 'CustomerID',
			c.firstName + ' ' + c.lastName AS 'Name',
			c.email,
			c.phone,
			c.company,
			s.ID 'SubscriptionID',
			s.ContractID,
			EmployeeID,
			discount,
			billingDate,
			recurring
		FROM 
			Customer c 
		JOIN 
			Subscription s 
		ON 
			c.ID = s.CustomerID
		WHERE
			c.ID = @NextCustomerID

	END TRY
	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE NewCustomerAndSubscriptionFromSalesperson 'Standard', 1, 12, 0.05, '2024-06-05', 0, 'Crangle', 'Vralmay', '123-245-567', 'email@server.com', 'cool company name here'
GO


-- Transaction B
DROP PROCEDURE IF EXISTS ListSalespersonSales;
GO

CREATE PROCEDURE ListSalespersonSales
	@firstName NVARCHAR(50),
	@lastName NVARCHAR(100)
AS
	BEGIN TRY
		SELECT
			c.firstName + ' '+ c.lastName AS 'Customer',
			c.email,
			c.phone
		FROM
			Customer c
		JOIN
			Subscription s
		ON
			c.ID = s.CustomerID
		JOIN
			Salesperson sp
		ON
			s.EmployeeID = sp.EmployeeID
		JOIN
			Employee e
		ON
			sp.EmployeeID = e.ID
		WHERE
			e.lastName = @lastName AND e.firstName = @firstName
	END TRY
	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE ListSalespersonSales 'Donnamarie', 'Farge'
GO


-- Transaction C
-- DELETE FROM ZoneData; -- For testing

DROP PROCEDURE IF EXISTS InsertDataFromDataScoop;
GO

CREATE PROCEDURE InsertDataFromDataScoop
	@ZoneID INT,
	@DataScoopID INT,
	@recordTime DATETIME,
	@latitude DECIMAL(18,15),
	@longitude DECIMAL(18,15),
	@altitude DECIMAL(6,2),
	@spectralData VARCHAR(8000),
	@Tempurature DECIMAL(7,3),
	@AmbientLight DECIMAL(18,14),
	@Humidity DECIMAL(4,3)
AS
	BEGIN TRY
		INSERT INTO ZoneData
		(
			ZoneID,
			DataScoopID,
			recordTime,
			latitude,
			longitude,
			altitude, 
			spectralData,
			temperature,
			ambientLight,
			humidity
		)
		VALUES
		(
			@ZoneID,
			@DataScoopID,
			@recordTime,
			@latitude,
			@longitude,
			@altitude,
			@spectralData,
			@Tempurature,
			@AmbientLight,
			@Humidity
		)
		SELECT * FROM ZoneData;
	END TRY
	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE InsertDataFromDataScoop 1, 1, '2024-07-20 02:30:00.000', 50.023452342, 173.23423433, 116.22, '394hfsnouw8wf8348ie8383ufwhq383hrhouhfouh2uhwuiwueh2u3h', 2.002, 243.3332, 0.13
GO


-- Transaction D
DROP PROCEDURE IF EXISTS GetDataScoopsFromContract
GO

CREATE PROCEDURE GetDataScoopsFromContract

AS
	BEGIN TRY
		SELECT DISTINCT
			d.ID AS 'DataScoopID',
			c.contractor AS 'Contracting Organisation',
			d.latitude,
			d.longitude,
			d.altitude
		FROM 
			[Contract] c
		JOIN
			Zone_Contract zc
		ON
			c.ID = zc.ContractID
		JOIN
			[Zone] z
		ON
			zc.ZoneID = z.ID
		JOIN
			DronePilot_DataScoop_Zone ddz
		ON
			z.ID = ddz.ZoneID
		JOIN
			DataScoop d
		ON
			ddz.DataScoopID = d.ID
		WHERE
			d.isDeployed = 1


	END TRY
	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE GetDataScoopsFromContract
GO


-- Transaction E
DROP PROCEDURE IF EXISTS GetDataFromContract
GO

CREATE PROCEDURE GetDataFromContract
	@Contractor NVARCHAR(100)
AS
	BEGIN TRY
		SELECT 
			c.contractor,
			zd.DataScoopID,
			zd.spectralData,
			zd.temperature,
			zd.ambientLight,
			zd.humidity
		FROM 
			[Contract] c
		JOIN
			Zone_Contract zc
		ON
			c.ID = zc.ContractID
		JOIN
			[Zone] z
		ON zc.ZoneID = z.ID
		JOIN
			ZoneData zd
		ON z.id = zd.ZoneID
		WHERE
			c.contractor = @Contractor
	END TRY
		BEGIN CATCH
			PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE GetDataFromContract 'Friesen Inc'
GO


-- Transaction F
DROP PROCEDURE IF EXISTS GetViewersByDataScoop
Go

CREATE PROCEDURE GetViewersByDataScoop
AS
	BEGIN TRY
	SELECT
		d.ID AS 'DataScoopID',
		c.firstName + ' ' + c.lastName AS 'Customer',
		v.ID AS 'VideoStreamID'
	FROM
		DataScoop d
	JOIN
		VideoStream v
	ON
		d.ID = v.DataScoopID
	JOIN
		Subscription s
	ON
		v.ID = s.VideoStreamID
	JOIN
		Customer c
	ON 
		s.CustomerID = c.ID
	ORDER BY
		d.ID

	END TRY
		BEGIN CATCH
			PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE GetViewersByDataScoop
GO

-- Transaction G
DROP PROCEDURE IF EXISTS GetPartSuppliersForDataScoop
GO

CREATE PROCEDURE GetPartSuppliersForDataScoop
@DataScoopID INT
AS
	BEGIN TRY
		SELECT DISTINCT
			pt.partName,
			s.supplierName
		FROM
		DataScoop d
		JOIN
			DataScoop_PartInstance dp
		ON
			d.ID = dp.DataScoopID
		JOIN
			PartInstance pn
		ON
			dp.PartInstanceID = pn.ID
		JOIN
			PartType pt
		ON
			pn.PartType = pt.ID

		JOIN
			Supplier_PartType spt
		ON 
			pt.id = spt.PartTypeID
		JOIN
			Supplier s
		ON spt.SupplierID = s.ID
		ORDER BY pt.partName
	END TRY
		BEGIN CATCH
			PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE GetPartSuppliersForDataScoop 1

-- Transaction H

DROP PROCEDURE IF EXISTS UpdateDataScoopLocation;
GO

CREATE PROCEDURE UpdateDataScoopLocation
	@DataScoopID INT,
	@Latitude DECIMAL(18,15),
	@Longitude DECIMAL(18,15),
	@Altitude DECIMAL(6,2),
	@ZoneID INT,
	@DronePilotID INT
AS 
	BEGIN TRY
		-- Update Datascoop Location
		UPDATE DataScoop
		SET
			latitude = @Latitude,
			longitude = @longitude,
			altitude = @Altitude
		WHERE
			ID = @DataScoopID


		-- Assign data scoop to new zone
		INSERT INTO DronePilot_DataScoop_Zone
		(
			DataScoopID,
			EmployeeID,
			ZoneID
		)
		VALUES
		(
			@DataScoopID,
			@DronePilotID,
			@ZoneID
		)

		SELECT DISTINCT
			*
		FROM
			DataScoop d
		JOIN
			DronePilot_DataScoop_Zone ddz
		ON
			d.ID = ddz.DataScoopID
		WHERE
			d.ID = @DataScoopID AND ddz.ZoneID = @ZoneID AND ddz.EmployeeID = @DronePilotID
	END TRY
		BEGIN CATCH
			PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE UpdateDataScoopLocation 1, 1.1234423, 1.123123123, 10.11, 3, 4
GO

-- Transaction I

DROP PROCEDURE IF EXISTS DeleteDataFromContract;
GO

CREATE PROCEDURE DeleteDataFromContract
	@ContractID INT
AS
	BEGIN TRY
		DELETE FROM
			ZoneData
		WHERE
			ZoneID IN 
			(
				SELECT
					z.ID
				FROM 
					[Contract] c
				JOIN
					Zone_Contract zc
				ON 
					c.ID = zc.ContractID
				JOIN
					[ZONE] z
				ON
					zc.ZoneID = z.ID
				WHERE c.ID = @ContractID
			)
	
		-- Display Results
		SELECT * FROM ZoneData ORDER BY ZoneID
	END TRY
	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;
GO

EXECUTE DeleteDataFromContract 2
GO

-- Transaction J

DROP PROCEDURE IF EXISTS GetTotalMaintenenceCost;
GO

CREATE PROCEDURE GetTotalMaintenenceCost
AS
	BEGIN TRY
		SELECT 
			SUM(cost)
		FROM
			PartType
		WHERE
			ID IN
			(
				SELECT
					p.PartType
				FROM
					Inspection i
				JOIN
					PartInstance p
				ON
					i.PartInstanceID = p.ID
			)
	END TRY
	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH;
GO

EXECUTE GetTotalMaintenenceCost
GO
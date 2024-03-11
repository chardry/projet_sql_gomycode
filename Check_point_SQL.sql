-- ********************** Cr�ation Base de Donn�es ******************
-- Cr�ation d'une Base de donn�es
CREATE DATABASE Gomycode;

-- S�lection de la Base Gomycode
use Gomycode;

-- 1 *** Impl�mentez le mod�le de relation fourni en utilisant SQL (partie DDL) ***

-- Cr�ation de la table Customers
CREATE TABLE Customers(
	customer_id int identity(1,1),
	customer_name varchar(50),
	customer_tel varchar(12)
	);

-- Ajout de la cl� primaire
ALTER TABLE Customers ADD CONSTRAINT pk_customer PRIMARY KEY(customer_id);

-- Cr�ation de la Table Products
CREATE TABLE Products(
	product_id INT IDENTITY(1,1),
	category VARCHAR(50),
	product_name VARCHAR(100) NOT NULL,
	price decimal CHECK (price > 0)
	);

-- Ajout de la cl� primaire
ALTER TABLE Products ADD CONSTRAINT pk_product PRIMARY KEY(product_id);

-- Cr�ation de la Table Orders
CREATE TABLE Orders(
	orders_id INT IDENTITY(1,1),
	customer_id INT,
	product_id INT,
	orders_date date,
	quantity INT CHECK (quantity > 0),
	total_amount INT
	);

-- Ajout des contraintes Cl�s primaire et �trang�re
ALTER TABLE Orders ADD CONSTRAINT pk_orders PRIMARY KEY(orders_id);
ALTER TABLE Orders ADD CONSTRAINT fk_customer_order FOREIGN KEY(customer_id) REFERENCES Customers(customer_id);
ALTER TABLE Orders ADD CONSTRAINT fk_product_order FOREIGN KEY(product_id) REFERENCES Products(product_id);

-- ********************  AJOUT DES DONNEES ************************
-- 2 *** Ins�rez des donn�es dans vos tables (partie DML) ***

-- Pour la Table Products

INSERT INTO Products VALUES ('widget','Electronique', 1500);
INSERT INTO Products VALUES ('gadget', 'Appareil', 700);
INSERT INTO Products VALUES ('doohickey', 'Tools', 2000);
INSERT INTO Products VALUES ('widget', 'Electronique', 2500);
INSERT INTO Products VALUES ('gadget', 'Appareil', 3000);
INSERT INTO Products VALUES ('gadget', 'Tools', 150000);

-- Pour la table Customers

INSERT INTO Customers VALUES ('Ahmed', '78 345 23 23');
INSERT INTO Customers VALUES ('Coulibaly', '78 305 23 23');
INSERT INTO Customers VALUES ('Libass', '78 345 23 22');
INSERT INTO Customers VALUES ('Cire', '78 045 23 23');
INSERT INTO Customers VALUES ('Youba', '78 345 23 23');
INSERT INTO Customers VALUES ('Abdoulaye', '78 445 44 23');
INSERT INTO Customers VALUES ('Adama', '77 345 23 44');
INSERT INTO Customers VALUES ('Idrissa', '76 345 23 23');

-- Pour la Table Orders

INSERT INTO Orders VALUES (17, 1, '2023-05-26', 3, 20000);
INSERT INTO Orders VALUES (17, 2, '2023-04-16', 3, 18000);
INSERT INTO Orders VALUES (17, 1, '2023-05-15', 6, 15000);
INSERT INTO Orders VALUES (18, 1, '2023-02-03', 7, 1050000);
INSERT INTO Orders VALUES (18, 6, '2023-05-26', 3, 20000);
INSERT INTO Orders VALUES (21, 5, '2023-02-05', 3, 9000);
INSERT INTO Orders VALUES (20, 4, '2023-05-08', 2, 4000);
INSERT INTO Orders VALUES (24, 2, '2023-05-19', 10, 15000);
INSERT INTO Orders VALUES (19, 3, '2023-05-06', 1, 2000);
INSERT INTO Orders VALUES (21, 2, '2023-05-18', 5, 3500);
INSERT INTO Orders VALUES (20, 2, '2023-05-08', 2, 4000);
INSERT INTO Orders VALUES (24, 1, '2023-05-19', 10, 15000);
INSERT INTO Orders VALUES (23, 6, '2023-05-06', 1, 2000);
INSERT INTO Orders VALUES (20, 6, '2023-05-18', 5, 3500);


-- ******************* Des requ�tes **********************

-- 3 �crivez une requ�te SQL pour r�cup�rer les noms des clients qui ont pass� une commande
-- d'au moins un widget et d'au moins un gadget, ainsi que le co�t total des widgets et 
-- gadgets command�s par chaque client. Le co�t de chaque article doit �tre calcul� en multipliant la quantit� par le prix du produit. 

SELECT DISTINCT c.customer_name, SUM(prod.price * ord.quantity) 'Cout Total' FROM Customers c,
Orders o, Products p, Orders ord, Products prod
WHERE c.customer_id = o.customer_id AND c.customer_id = ord.customer_id
AND o.product_id = p.product_id AND p.category = 'widget'
AND ord.product_id = prod.product_id AND prod.category = 'gadget' GROUP BY c.customer_name;

-- 4 �crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande 
-- pour au moins un widget, ainsi que le co�t total des widgets command�s par chaque client.

SELECT cust.customer_name, SUM(prod.price * ord.quantity) 'Cout Total' FROM Customers cust 
INNER JOIN Orders ord ON cust.customer_id = ord.customer_id 
INNER JOIN Products prod ON ord.product_id = prod.product_id
WHERE prod.category = 'widget' GROUP BY cust.customer_name;

-- 5 �crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande pour
-- au moins un gadget, ainsi que le co�t total des gadgets command�s par chaque client.

SELECT cust.customer_name, SUM(prod.price * ord.quantity) 'Cout Total' FROM Customers cust 
INNER JOIN Orders ord ON cust.customer_id = ord.customer_id 
INNER JOIN Products prod ON ord.product_id = prod.product_id
WHERE prod.category = 'gadget' GROUP BY cust.customer_name;

-- 6 �crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande 
-- d'au moins un doohickey, ainsi que le co�t total des doohickeys command�s par chaque client.

SELECT cust.customer_name, SUM(prod.price * ord.quantity) 'Cout Total' FROM Customers cust 
INNER JOIN Orders ord ON cust.customer_id = ord.customer_id 
INNER JOIN Products prod ON ord.product_id = prod.product_id
WHERE prod.category = 'doohickey' GROUP BY cust.customer_name;

-- 7 �crivez une requ�te pour r�cup�rer le nombre total de widgets et de gadgets command�s par chaque client,
-- ainsi que le co�t total des commandes.

SELECT cust.customer_name, COUNT(prod.product_name) 'Total Widget', 
SUM(prod.price * ord.quantity) 'Cout Total' FROM Customers cust 
INNER JOIN Orders ord ON cust.customer_id = ord.customer_id 
INNER JOIN Products prod ON ord.product_id = prod.product_id
WHERE prod.category = 'widget' GROUP BY cust.customer_name;

-- 8 �crivez une requ�te pour r�cup�rer les noms des produits qui ont �t� command�s par au moins un client, 
-- ainsi que la quantit� totale de chaque produit command�.

SELECT p.product_name, COUNT(o.quantity) 'Quatite Total' FROM Products p
INNER JOIN Orders o ON p.product_id = o.product_id
INNER JOIN Customers c ON o.customer_id = c.customer_id GROUP BY p.product_name;

--  9 �crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� le plus de commandes, 
--ainsi que le nombre total de commandes pass�es par chaque client.

SELECT c.customer_name, COUNT(o.customer_id) 'Total Commande' FROM Customers c
INNER JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_name HAVING COUNT(o.orders_id) >= 2;

-- 10 �crivez une requ�te pour r�cup�rer les noms des produits les plus command�s, ainsi que la quantit� totale de chaque 
-- produit command�.

SELECT p.product_name, COUNT(o.quantity) 'Quatit� Totale' FROM Products p
INNER JOIN Orders o ON o.product_id = p.product_id
WHERE o.quantity >= 2 GROUP BY p.product_name;

-- 11 �crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande chaque jour de la semaine, 
-- ainsi que le nombre total de commandes pass�es par chaque client.

SELECT c.customer_name, sum(o.quantity) 'Total Commandes'
FROM Customers c
INNER JOIN Orders o
ON o.customer_id = c.customer_id
INNER JOIN Products p
ON p.product_id = o.product_id
WHERE orders_date LIKE '2023-02-%' OR orders_date LIKE '2023-05-%'
GROUP BY Customer_name;
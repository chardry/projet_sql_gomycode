
-- Cr�ation d'une Base de donn�es
CREATE DATABASE Gomycode;

-- S�lection de la Base Gomycode
use Gomycode;

-- Cr�ation de la table Customers
CREATE TABLE Customers(
	customer_id int identity(1,1),
	name varchar(50),
	address varchar(50)
	);

-- Ajout de la cl� primaire
ALTER TABLE Customers ADD CONSTRAINT pk_customer PRIMARY KEY(customer_id);

-- Cr�ation de la Table Products
CREATE TABLE Products(
	product_id INT IDENTITY(1,1),
	name VARCHAR(100),
	price money
	);

-- Ajout de la cl� primaire
ALTER TABLE Products ADD CONSTRAINT pk_product PRIMARY KEY(product_id);

-- Cr�ation de la Table Orders
CREATE TABLE Orders(
	orders_id INT IDENTITY(1,1),
	customer_id INT,
	product_id INT,
	quantity INT,
	orders_date date
	);

-- Ajout des contraintes Cl�s primaire et �trang�re
ALTER TABLE Orders ADD CONSTRAINT pk_orders PRIMARY KEY(orders_id);
ALTER TABLE Orders ADD CONSTRAINT fk_customer_order FOREIGN KEY(customer_id) REFERENCES Customers(customer_id);
ALTER TABLE Orders ADD CONSTRAINT fk_product_order FOREIGN KEY(product_id) REFERENCES Products(product_id);

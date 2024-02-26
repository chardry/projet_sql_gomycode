-- 1 *** Ajout des enregistrements ***

-- Pour la Table Products

INSERT INTO Products VALUES('Cookies', 10);
INSERT INTO Products VALUES('Candy', 2.5);

-- Pour la table Customers

INSERT INTO Customers VALUES ('Ahmed', 'Tunusie');
INSERT INTO Customers VALUES ('Coulibaly', 'Senegal');
INSERT INTO Customers VALUES ('Hassan', 'Egypte');

-- Pour la Table Orders

INSERT INTO Orders VALUES(1, 2, 3, '2023-01-22');
INSERT INTO Orders VALUES(2, 1, 10, '2023-04-14');

-- 2 *** Mises à jour des tables ***

UPDATE Orders SET quantity = 6 WHERE orders_id = 2;

-- 3 *** Supprimer le 3ème Customers

DELETE FROM Customers WHERE customer_id = 3;

-- 4 *** Supprimez le contenu du tableau des commandes, puis supprimez le tableau. ***

DELETE FROM Orders;

DROP TABLE Orders;

-- *******************************************************************************

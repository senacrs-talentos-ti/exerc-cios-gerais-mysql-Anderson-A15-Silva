CREATE DATABASE Enterprise;
USE Enterprise;

/*
DROP TABLE Order_Items;
DROP TABLE Orders;
DROP TABLE Products;
DROP TABLE Clients;
*/

-- Exercício 1 - Fácil - CONCLUÍDO
/*
1. Crie a tabela `CLIENTS` com as seguintes colunas:

    - `id`: inteiro, chave primária, auto incrementável
    - `name`: texto, não nulo
    - `email`: texto, não nulo
*/
CREATE TABLE Clients(
    id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL
);

-- Exercício 2 - Fácil - CONCLUÍDO
/*
2. Crie a tabela `PRODUCTS` com as seguintes colunas:
    - `id`: inteiro, chave primária, auto incrementável
    - `name`: texto, não nulo
    - `price`: decimal, não nulo
*/
CREATE TABLE Products(
    id INT(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    price DECIMAL(6, 2) NOT NULL
);

-- Exercício 3 - Médio - CONCLUÍDO
/*
3. Crie a tabela `ORDERS` com as seguintes colunas:
    - `id`: inteiro, chave primária, auto incrementável
    - `client_id`: inteiro, chave estrangeira referenciando `CLIENTS(id)`
    - `order_date`: data, não nulo
    - `total`: decimal, não nulo
*/
CREATE TABLE Orders(
    id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_id INT(3) NOT NULL,
    order_date DATE NOT NULL,
    total DECIMAL(6, 2) NOT NULL,
    CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES Clients(id)
);

-- Exercício 4 - Médio - CONCLUÍDO
/*
4. Crie a tabela `ORDER_ITEMS` com as seguintes colunas:
    - `order_id`: inteiro, chave estrangeira referenciando `ORDERS(id)`
    - `product_id`: inteiro, chave estrangeira referenciando `PRODUCTS(id)`
    - `quantity`: inteiro, não nulo
    - `price`: decimal, não nulo
*/
CREATE TABLE Order_Items(
    order_id INT(4) NOT NULL PRIMARY KEY,
    product_id INT(5) NOT NULL,
    quantity INT(3) NOT NULL,
    price DECIMAL(6, 2) NOT NULL,
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES Orders(id),
    CONSTRAINT fk_product_id FOREIGN KEY (order_id) REFERENCES Products(id)
);

-- Exercício 5 - Fácil - CONCLUÍDO
-- 5. Insira dados nas tabelas `CLIENTS` e `PRODUCTS`.
INSERT INTO Clients VALUES
(default, "Carlos", "carlos10@gmail.com"),
(default, "Thiago", "thiago11@gmail.com"),
(default, "Anderson", "anderson12@gmail.com"),
(default, "Paulo", "paulo13@gmail.com"),
(default, "Pedro", "pedro14@gmail.com"),
(default, "Ana", "ana15@gmail.com"),
(default, "Marta", "marta16@gmail.com"),
(default, "Roberta", "roberta17@gmail.com"),
(default, "Cláudia", "claudia18@gmail.com"),
(default, "Emilly", "emilly19@gmail.com");

INSERT INTO Products VALUES
(default, "Notebook Lenovo", 3890),
(default, "Notebook ASUS", 4100),
(default, "Notebook VAIO", 3200.9),
(default, "Notebook Positivo", 2600),
(default, "Smartphone Samsumg", 900.9),
(default, "Smartphone Positivo", 720.99),
(default, "Smartphone Xaiomi", 1100.5),
(default, "Smartphone LG", 860),
(default, "Tablet Positivo", 1500),
(default, "Tablet Multilaser", 2200.5);
INSERT INTO Products VALUES(default, "Nokia Positivo", 1000.00);

-- Exercício 6 - Médio - CONCLUÍDO
-- 6. Insira dados na tabela `ORDERS`.
INSERT INTO Orders VALUES
(default, 7, '2021-01-01', 3890),
(default, 2, '2023-07-11', 4100.5),
(default, 4, '2024-10-14', 3200.9),
(default, 2, '2022-11-16', 5200),
(default, 6, '2023-06-26', 2702.7),
(default, 5, '2023-07-14', 720.99),
(default, 5, '2022-07-29', 1100.5),
(default, 3, '2024-02-23', 1721.98),
(default, 2, '2022-04-07', 1500),
(default, 1, '2022-03-08', 2200.5);

-- Exercício 7 - Médio - CONCLUÍDO
-- 7. Insira dados na tabela `ORDER_ITEMS`.
INSERT INTO Order_Items VALUES
(1, 1, 1, 3890),
(2, 2, 1, 4100.5),
(3, 3, 1, 3200.9),
(4, 4, 2, 2600),
(5, 5, 3, 900.9),
(6, 6, 1, 720.99),
(7, 7, 1, 1100.5),
(8, 8, 2, 860),
(9, 9, 1, 1500),
(10, 10, 1, 2200.5);

-- SELECT * FROM Clients;
-- SELECT * FROM Orders;
-- SELECT * FROM Order_Items;
-- SELECT * FROM Products;

-- SET SQL_SAFE_UPDATES = 0;

-- Exercício 8 - Difícil - CONCLUÍDO
-- 8. Atualize o preço de um produto na tabela `PRODUCTS` e todos os registros relacionados na tabela `ORDER_ITEMS`.
UPDATE Products SET price = 1300.50 WHERE id = 7;
UPDATE Order_Items SET price = 1300.50 WHERE product_id = 7;

-- Exercício 9 - Fácil - CONCLUÍDO
-- 9. Delete um cliente e todos os pedidos relacionados.
DELETE FROM Order_Items WHERE order_id = 6 OR order_id = 7;
DELETE FROM Orders WHERE id = 6 OR id = 7;
DELETE FROM Clients WHERE id = 5;

-- Exercício 10 - Médio - CONCLUÍDO
-- 10. Altere a tabela `CLIENTS` para adicionar uma coluna de data de nascimento (`birthdate`).
ALTER TABLE Clients ADD COLUMN birthdate DATE NULL;

-- Exercício 11 - Médio - CONCLUÍDO
-- 11. Faça uma consulta usando JOIN para listar todos os pedidos com os nomes dos clientes e os nomes dos produtos.
SELECT Clients.name as client, Products.name as product FROM Clients
INNER JOIN Orders ON Clients.id = Orders.client_id
INNER JOIN Order_Items ON Orders.id = Order_Items.order_id
INNER JOIN Products ON Order_Items.product_id = Products.id;

-- Exercício 12 - Difícil - CONCLUÍDO
-- 12. Faça uma consulta usando LEFT JOIN para listar todos os clientes e seus pedidos, incluindo clientes sem pedidos.
SELECT Clients.name as client, Products.name as product FROM Clients
LEFT JOIN Orders ON Clients.id = Orders.client_id
LEFT JOIN Order_Items ON Orders.id = Order_Items.order_id
LEFT JOIN Products ON Order_Items.product_id = Products.id;

-- Exercício 13 - Difícil - CONCLUÍDO
-- 13. Faça uma consulta usando RIGHT JOIN para listar todos os produtos e os pedidos que os contêm, incluindo produtos que não foram pedidos.
SELECT Clients.name as client, Products.name as product FROM Clients
RIGHT JOIN Orders ON Clients.id = Orders.client_id
RIGHT JOIN Order_Items ON Orders.id = Order_Items.order_id
RIGHT JOIN Products ON Order_Items.product_id = Products.id;

-- Exercício 14 - Médio - CONCLUÍDO
-- 14. Utilize funções de agregação para obter o total de vendas e a quantidade total de itens vendidos.
SELECT COUNT(Orders.id) as total_sales, SUM(quantity) as itens_sold FROM Order_Items 
INNER JOIN Orders ON Order_Items.order_id = Orders.id;

-- Exercício 15 - Médio - CONCLUÍDO
-- 15. Faça uma consulta para listar todos os clientes e a quantidade total de pedidos realizados por cada um, ordenados pela quantidade de pedidos em ordem decrescente.
SELECT Clients.name, COUNT(*) as orders_placed FROM Orders
INNER JOIN Clients ON Clients.id = Orders.client_id
GROUP BY Clients.name ORDER BY orders_placed DESC;

-- Exercício 16 - Médio - CONCLUÍDO
-- 16. Faça uma consulta para listar todos os produtos e a quantidade total de cada produto vendido, ordenados pela quantidade em ordem decrescente.
SELECT Products.name as produto, SUM(quantity) as products_sold FROM Order_Items
INNER JOIN Products ON Order_Items.product_id = Products.id
GROUP BY produto ORDER BY products_sold DESC;

-- Exercício 17 - Médio - CONCLUIÍDO
-- 17. Faça uma consulta para listar todos os clientes e o valor total gasto por cada um, ordenados pelo valor gasto em ordem decrescente.
SELECT Clients.name, SUM(total) as amount_spend FROM Orders
INNER JOIN Clients ON Orders.client_id = Clients.id
GROUP BY Clients.name ORDER BY amount_spend DESC;

-- Exercício 18 - Difícil - CONCLUÍDO
-- 18. Faça uma consulta para listar os 3 produtos mais vendidos (em quantidade) e o total de vendas de cada um.
SELECT Products.name, SUM(Order_Items.quantity) as sales_quantity, COUNT(*) as total_sales FROM Orders
INNER JOIN Order_Items ON Orders.id = Order_Items.order_id
INNER JOIN Products ON Order_Items.product_id = Products.id
GROUP BY Products.name ORDER BY sales_quantity DESC LIMIT 3;

-- Exercício 19 - Difícil - CONCLUÍDO
-- 19. Faça uma consulta para listar os 3 clientes que mais gastaram e o total gasto por cada um.
SELECT Clients.name, SUM(total) as amount_spend FROM Orders
INNER JOIN Clients ON Orders.client_id = Clients.id
GROUP BY Clients.name ORDER BY amount_spend DESC LIMIT 3;

-- Exercício 20 - Médio - CONCLUÍDO
-- 20. Faça uma consulta para listar a média de quantidade de produtos por pedido para cada cliente.
SELECT Clients.name, AVG(quantity) as avg_produto FROM Order_Items
INNER JOIN Orders ON Order_Items.order_id = Orders.id
INNER JOIN Clients ON Orders.client_id = Clients.id
GROUP BY Clients.name ORDER BY Clients.name ASC;

-- Exercício 21 - Médio - CONCLUÍDO
-- 21. Faça uma consulta para listar o total de pedidos e o total de clientes por mês.
-- Distinct
SELECT COUNT(DISTINCT(Clients.name)) as total_clients, COUNT(*) as total_orders, MONTH(order_date) as month 
FROM Orders INNER JOIN Clients ON Orders.client_id = Clients.id GROUP BY month;

-- Exercício 22 - Difícil - CONCLUÍDO
-- 22. Faça uma consulta para listar os produtos que nunca foram vendidos.
SELECT name FROM Products WHERE id NOT IN (SELECT product_id FROM Order_Items);

-- Exercício 23 - Médio - CONCLUÍDO
-- 23. Faça uma consulta para listar os pedidos que contêm mais de 2 itens diferentes.
SELECT order_id, quantity FROM Order_Items WHERE quantity > 2;

-- Exercício 24 - Médio - CONCLUÍDO
-- 24. Faça uma consulta para listar os clientes que fizeram pedidos no último mês.
SELECT Clients.name, order_date FROM Orders INNER JOIN Clients ON Orders.client_id = Clients.id WHERE MONTH(order_date) = MONTH(NOW());

-- Exercício 25 - Difícil - CONCLUÍDO
-- 25. Faça uma consulta para listar os clientes com o maior valor médio por pedido.
SELECT Clients.name, AVG(total) as avg_value FROM Orders
INNER JOIN Clients ON Orders.client_id = Clients.id
GROUP BY Clients.name ORDER BY avg_value DESC;
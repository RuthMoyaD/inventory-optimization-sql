USE mintclassics;

SELECT 
    p.productCode,
    p.productName,
    p.productLine,
    p.quantityInStock,
    w.warehouseCode,
    w.warehouseName
FROM mintclassics.products p
JOIN mintclassics.warehouses w
    ON p.warehouseCode = w.warehouseCode;



SELECT
    c.customerNumber,
    c.customerName,
    o.orderNumber,
    od.productCode,
    p.productName,
    od.quantityOrdered,
    od.priceEach
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
JOIN products p
    ON od.productCode = p.productCode
LIMIT 20;



SELECT 
    w.warehouseCode,
    w.warehouseName,
    p.productCode,
    p.productName,
    p.productLine,
    p.quantityInStock
FROM warehouses w
JOIN products p
    ON w.warehouseCode = p.warehouseCode
ORDER BY 
    w.warehouseCode,
    p.productLine,
    p.productName;

    

SELECT 
    c.country,
    SUM(od.quantityOrdered) AS total_demand
FROM orders o
JOIN customers c 
    ON o.customerNumber = c.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY total_demand DESC;
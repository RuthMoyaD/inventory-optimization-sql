USE mintclassics;

SELECT
    o.orderNumber,
    o.orderDate,
    w.warehouseCode,
    w.warehouseName,
    p.productCode,
    p.productName,
    od.quantityOrdered,
    od.priceEach
FROM mintclassics.orders o
JOIN mintclassics.orderdetails od
    ON o.orderNumber = od.orderNumber
JOIN mintclassics.products p
    ON od.productCode = p.productCode
JOIN mintclassics.warehouses w
    ON p.warehouseCode = w.warehouseCode
ORDER BY o.orderDate
LIMIT 50;



SELECT
    p.productCode,
    p.productName,
    YEAR(o.orderDate) AS orderYear,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM mintclassics.orderdetails od
JOIN mintclassics.orders o
    ON od.orderNumber = o.orderNumber
JOIN mintclassics.products p
    ON od.productCode = p.productCode
GROUP BY
    p.productCode,
    p.productName,
    YEAR(o.orderDate)
ORDER BY
    orderYear,
    total_quantity_ordered DESC;



SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock,
    COALESCE(SUM(od.quantityOrdered), 0) AS totalSales,
    ROUND(p.quantityInStock / NULLIF(SUM(od.quantityOrdered), 0), 2) AS stockToSalesRatio
FROM products p
LEFT JOIN orderdetails od 
    ON p.productCode = od.productCode
LEFT JOIN orders o 
    ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY stockToSalesRatio DESC;